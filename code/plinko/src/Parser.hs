{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

module Parser where

import Syntax

import Data.Char 
import Data.Functor
import qualified Data.HashMap.Lazy as Map
import qualified Text.Parsec as TP
import qualified Text.Parsec.ByteString as B
import Data.Aeson
import Data.Aeson.Key
import qualified Data.Aeson.KeyMap as KM
import qualified Data.List as L
import Text.ParserCombinators.Parsec
import Numeric

type KParser = TP.Parsec String Context

instance FromJSON JSONPathList where
  parseJSON = withObject "JSONPathList" $ \obj ->
    let kvs = KM.toList obj
        nums = map (read . toString . fst) kvs
        vals = map snd kvs
    in do branches <- mapM parseJSON vals
          return $ PathList (map (uncurry Path) $ zip nums branches)

instance FromJSON Branch where
  parseJSON = withObject "Branch" $ \obj -> do
    predicate' <- runParser parseKExpr Map.empty "" <$> obj .:? "predicate" .!= "true"
    nodeTrueQuery' <- parseListWithContext Map.empty <$> obj .: "nodeTrueQuery"
    nodeFalseQuery' <- parseListWithContext Map.empty <$> obj .: "nodeFalseQuery"
    return ( Branch { predicate = predicate',
                      nodeTrueQuery = nodeTrueQuery',
                      nodeFalseQuery = nodeFalseQuery'
                    })

instance FromJSON WinningPath where
  parseJSON = withObject "WinningPath" $ \obj -> do
    pathNum <- obj .: "Path"
    var <- obj .:? "Var Name"
    case var of
      Just "" -> return $ WinningPath pathNum Nothing Nothing
      Just _ -> do val <- runParser parseKExpr Map.empty "" <$> obj .: "Var Value"
                   return $ WinningPath pathNum var (Just val)
      Nothing -> return $ WinningPath pathNum var Nothing

parseListWithContext :: Context -> [String] -> [Either ParseError KExpr]
parseListWithContext ctx (x:xs) = let curCtx = runParser (parseKExpr >> TP.getState) ctx "" x
                                      res = runParser parseKExpr ctx "" x
  in case curCtx of
       Left _ -> res:parseListWithContext ctx xs
       Right c -> res:parseListWithContext (Map.union c ctx) xs
parseListWithContext _ [] = []

number :: TP.Stream s m Char => TP.ParsecT s u m Int
number = fromInteger <$> integer

integer :: TP.Stream s m Char => TP.ParsecT s u m Integer
integer = read <$> many1 digit
      <|> char '-' *> (negate . read <$> many1 digit)

rational :: TP.Stream s m Char => TP.ParsecT s u m Rational
rational = do
  lhs <- many1 digit
  _ <- char '.'
  rhs <- many1 digit
  return (fst . head $ readFloat (lhs ++ "." ++ rhs))

boolean :: TP.Stream s m Char => TP.ParsecT s u m Bool
boolean =  string "true" $> True
       <|> string "false" $> False

ident :: TP.Stream s m Char => TP.ParsecT s u m String
ident = do
  first <- satisfy (\a -> isLetter a || a == '_')
  rest  <- many $ satisfy (\a -> isDigit a || isLetter a || a == '.' || a == '_')
  return (first:rest)

sym :: TP.Stream s m Char => String -> TP.ParsecT s u m String
sym kw = string kw <* spaces

keyword :: TP.Stream s m Char => String -> TP.ParsecT s u m String
keyword kw = string kw <* skipMany1 space

parseKExpr :: KParser KExpr
parseKExpr = parseIdent
          <|> parseNumC
          <|> parseBoolC
          <|> parseVarC
          <|> parseAdd
          <|> parseSub
          <|> parseMul
          <|> parseUDiv
          <|> parseURem
          <|> parseSDiv
          <|> parseSRem
          <|> parseNot
          <|> parseAnd
          <|> parseOr
          <|> parseXor
          <|> parseShl
          <|> parseLShr
          <|> parseAShr
          <|> parseEq
          <|> parseNe
          <|> parseUlt
          <|> parseUle
          <|> parseUgt
          <|> parseSlt
          <|> parseSle
          <|> parseSgt
          <|> parseSge
          <|> parseConcat
          <|> parseExtract
          <|> parseZExt
          <|> parseSExt
          <|> parseReadLSB
          <|> parseReadMSB
          <|> parseRead
          <|> parseArray
          <|> parseArrayUpdate
          <|> parseSelect
          <|> parseFPExt
          <|> parseFPTrunc
          <|> parseFPToUI
          <|> parseFPToSI
          <|> parseUIToFP
          <|> parseSIToFP
          <|> parseFSqrt
          <|> parseFAbs
          <|> parseFNeg
          <|> parseFRint
          <|> parseIsNaN
          <|> parseIsInfinite
          <|> parseIsNormal
          <|> parseIsSubnormal
          <|> parseFAdd
          <|> parseFSub
          <|> parseFMul
          <|> parseFDiv
          <|> parseFRem
          <|> parseFMax
          <|> parseFMin
          <|> parseFOEq
          <|> parseFOLt
          <|> parseFOLe
          <|> parseFOGt
          <|> parseFOGe

parseIdent :: KParser KExpr
parseIdent = TP.try $ do
  version <- ident
  _ <- char ':'
  ke <- parseKExpr
  TP.modifyState (Map.insert version ke)
  return ke

parseNumC :: KParser KExpr
parseNumC = NumC <$> number

parseKType :: KParser KType
parseKType = do
  _ <- char 'w'
  num <- many1 digit
  spaces
  return $ BitVec $ read num

parseKTypeFP :: KParser KType
parseKTypeFP = do
  _ <- char 'w'
  num <- many1 digit
  spaces
  return $ FP $ read num

parseKTypeDist :: B.Parser KType
parseKTypeDist = do
  _ <- char 'w'
  num <- many1 digit
  return $ BitVec $ read num

parseBoolC :: KParser KExpr
parseBoolC = TP.try $ BoolC <$> boolean

parseVarC :: KParser KExpr
parseVarC = do
  var <- ident
  ctx <- TP.getState
  case Map.lookup var ctx of
    Nothing -> return $ VarC Unknown var
    Just ke -> return ke

parseUnary :: String -> (KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseUnary kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                            (spaces <* char ')')
                                            (cnstr <$> body)

parseUnaryWithType :: String -> (KType -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseUnaryWithType kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                                    (spaces <* char ')')
                                                    (cnstr <$> parseKType <*> body)

parseUnaryWithFPType :: String -> (KType -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseUnaryWithFPType kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                                      (spaces <* char ')')
                                                      (cnstr <$> parseKTypeFP <*> body)

parseBinary :: String -> (KType -> KExpr -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseBinary kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                             (spaces <* char ')')
                                             (cnstr <$> parseKType <*> (spaces *> body) <*> (skipMany1 space *> body))

parseBinaryNoType :: String -> (KType -> KExpr -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseBinaryNoType kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                                   (spaces <* char ')')
                                                   (cnstr Unknown <$> body <*> (skipMany1 space *> body))

parseBinaryNoTypeNeeded :: String -> (KExpr -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseBinaryNoTypeNeeded kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                        (spaces <* char ')')
                                        (cnstr <$> body <*> (skipMany1 space *> body))

parseBinaryWithFPType ::  String -> (KType -> KExpr -> KExpr -> KExpr) -> KParser KExpr -> KParser KExpr
parseBinaryWithFPType kw cnstr body = TP.try $ between (sym "(" *> keyword kw)
                                             (spaces <* char ')')
                                             (cnstr <$> parseKTypeFP <*> (spaces *> body) <*> (skipMany1 space *> body))

parseAdd :: KParser KExpr
parseAdd = parseBinary "Add" Add parseKExpr

parseSub :: KParser KExpr
parseSub = parseBinary "Sub" Sub parseKExpr

parseMul :: KParser KExpr
parseMul = parseBinary "Mul" Mul parseKExpr

parseUDiv :: KParser KExpr
parseUDiv = parseBinary "UDiv" UDiv parseKExpr

parseURem :: KParser KExpr
parseURem = parseBinary "URem" URem parseKExpr

parseSDiv :: KParser KExpr
parseSDiv = parseBinary "SDiv" SDiv parseKExpr

parseSRem :: KParser KExpr
parseSRem = parseBinary "SRem" SRem parseKExpr

parseNot :: KParser KExpr
parseNot =  parseUnaryWithType "Not" Not parseKExpr
        <|> TP.try (between (sym "(" *> keyword "Not")
                     (spaces <* char ')')
                     (Not Unknown <$> parseKExpr))

parseAnd :: KParser KExpr
parseAnd =  parseBinary "And" And parseKExpr
        <|> parseBinaryNoType "And" And parseKExpr

parseOr :: KParser KExpr
parseOr =  parseBinary "Or" Or parseKExpr
       <|> parseBinaryNoType "Or" Or parseKExpr

parseXor :: KParser KExpr
parseXor =  parseBinary "Xor" Xor parseKExpr
        <|> parseBinaryNoType "Xor" Xor parseKExpr

parseShl :: KParser KExpr
parseShl =  parseBinary "Shl" Shl parseKExpr
        <|> parseBinaryNoType "Shl" Shl parseKExpr

parseLShr :: KParser KExpr
parseLShr =  parseBinary "LShr" LShr parseKExpr
         <|> parseBinaryNoType "LShr" LShr parseKExpr

parseAShr :: KParser KExpr
parseAShr =  parseBinary "AShr" AShr parseKExpr
         <|> parseBinaryNoType "AShr" AShr parseKExpr

parseEq :: KParser KExpr
parseEq =  parseBinaryNoTypeNeeded "Eq" Eq parseKExpr

parseNe :: KParser KExpr
parseNe =  parseBinaryNoTypeNeeded "Ne" Ne parseKExpr

parseUlt :: KParser KExpr
parseUlt = parseBinaryNoTypeNeeded "Ult" Ult parseKExpr

parseUle :: KParser KExpr
parseUle = parseBinaryNoTypeNeeded "Ule" Ule parseKExpr

parseUgt :: KParser KExpr
parseUgt = parseBinaryNoTypeNeeded "Ugt" Ugt parseKExpr

parseSlt :: KParser KExpr
parseSlt = parseBinaryNoTypeNeeded "Slt" Slt parseKExpr

parseSle :: KParser KExpr
parseSle = parseBinaryNoTypeNeeded "Sle" Sle parseKExpr

parseSgt :: KParser KExpr
parseSgt = parseBinaryNoTypeNeeded "Sgt" Sgt parseKExpr

parseSge :: KParser KExpr
parseSge = parseBinaryNoTypeNeeded "Sge" Sge parseKExpr

parseConcat :: KParser KExpr
parseConcat = parseBinary "Concat" Concat parseKExpr
       <|> parseBinaryNoType "Concat" Concat parseKExpr

parseExtract :: KParser KExpr
parseExtract = (TP.try $ between (sym "(" *> keyword "Extract")
                                (spaces <* char ')')
                                (Extract <$> parseKType <*> (skipMany space *> number) <*> (skipMany1 space *> parseKExpr)))
  <|> (TP.try $ between (sym "(" *> keyword "Extract")
                                (spaces <* char ')')
                                (Extract Boolean <$> (skipMany space *> number) <*> (skipMany1 space *> parseKExpr)))
parseZExt :: KParser KExpr
parseZExt = parseUnaryWithType "ZExt" ZExt parseKExpr

parseSExt :: KParser KExpr
parseSExt = parseUnaryWithType "SExt" SExt parseKExpr

parseReadLSB :: KParser KExpr
parseReadLSB = TP.try $ between (sym "(" *> keyword "ReadLSB")
                        (spaces <* char ')')
                        (ReadLSB <$> parseKType <*> (skipMany space *> parseKExpr) <*> (skipMany1 space *> parseKExpr))

parseReadMSB :: KParser KExpr
parseReadMSB = TP.try $ between (sym "(" *> keyword "ReadMSB")
                        (spaces <* char ')')
                        (ReadMSB <$> parseKType <*> (skipMany space *> parseKExpr) <*> (skipMany1 space *> parseKExpr))

parseRead :: KParser KExpr
parseRead = TP.try $ between (sym "(" *> keyword "Read")
                     (spaces <* char ')')
                     (Read <$> parseKType <*> (skipMany space *> parseKExpr) <*> (skipMany1 space *> parseKExpr))

parseArray :: KParser KExpr
parseArray = TP.try $ between (sym "[")
                      (spaces <* char ']')
                      (KArray <$> sepBy1 integer spaces)

parseArrayUpdate :: KParser KExpr
parseArrayUpdate = KArrayUpdate <$> (sym "[" *> sepBy1 parseIndexVal (sym ",")) <*> (sym "]" *> sym "@" *> parseKExpr)
  where parseIndexVal :: KParser (KExpr,KExpr)
        parseIndexVal = do
          ind <- parseKExpr
          _ <- char '='
          val <- parseKExpr
          return (ind,val)

parseSelect :: KParser KExpr
parseSelect = TP.try $ between (sym "(" *> keyword "Select")
                       (spaces <* char ')')
                       (Select <$> parseKType <*> (spaces *> parseKExpr) <*> (spaces *> parseKExpr) <*> (spaces *> parseKExpr))

parseFPExt :: KParser KExpr
parseFPExt = parseUnaryWithFPType "FPExt" FPExt parseKExpr

parseFPTrunc :: KParser KExpr
parseFPTrunc = parseUnaryWithFPType "FPTrunc" FPTrunc parseKExpr

parseFPToUI :: KParser KExpr
parseFPToUI = parseUnaryWithFPType "FPToUI" FPToUI parseKExpr

parseFPToSI :: KParser KExpr
parseFPToSI = parseUnaryWithFPType "FPToSI" FPToSI parseKExpr

parseUIToFP :: KParser KExpr
parseUIToFP = parseUnaryWithType "UIToFP" UIToFP parseKExpr

parseSIToFP :: KParser KExpr
parseSIToFP = parseUnaryWithType "SIToFP" SIToFP parseKExpr

parseFSqrt :: KParser KExpr
parseFSqrt = parseUnary "FSqrt" FSqrt parseKExpr

parseFAbs :: KParser KExpr
parseFAbs = parseUnaryWithFPType "FAbs" FAbs parseKExpr

parseFNeg :: KParser KExpr
parseFNeg = parseUnary "FNeg" FNeg parseKExpr

parseFRint :: KParser KExpr
parseFRint = parseUnary "FRint" FRint parseKExpr

parseIsNaN :: KParser KExpr
parseIsNaN = parseUnary "IsNaN" IsNaN parseKExpr

parseIsInfinite :: KParser KExpr
parseIsInfinite = parseUnary "IsInfinite" IsInfinite parseKExpr

parseIsNormal :: KParser KExpr
parseIsNormal = parseUnary "IsNormal" IsNormal parseKExpr

parseIsSubnormal :: KParser KExpr
parseIsSubnormal = parseUnary "IsSubnormal" IsSubnormal parseKExpr

parseFAdd :: KParser KExpr
parseFAdd = parseBinaryWithFPType "FAdd" FAdd parseKExpr

parseFSub :: KParser KExpr
parseFSub = parseBinaryWithFPType "FSub" FSub parseKExpr

parseFMul :: KParser KExpr
parseFMul = parseBinaryWithFPType "FMul" FMul parseKExpr

parseFDiv :: KParser KExpr
parseFDiv = parseBinaryWithFPType "FDiv" FDiv parseKExpr

parseFRem :: KParser KExpr
parseFRem = parseBinaryWithFPType "FRem" FRem parseKExpr

parseFMax :: KParser KExpr
parseFMax = parseBinaryNoTypeNeeded "FMax" FMax parseKExpr

parseFMin :: KParser KExpr
parseFMin = parseBinaryNoTypeNeeded "FMin" FMin parseKExpr

parseFOEq :: KParser KExpr
parseFOEq = parseBinaryNoTypeNeeded "FOEq" FOEq parseKExpr

parseFOLt :: KParser KExpr
parseFOLt = parseBinaryNoTypeNeeded "FOLt" FOLt parseKExpr

parseFOLe :: KParser KExpr
parseFOLe = parseBinaryNoTypeNeeded "FOLe" FOLe parseKExpr

parseFOGt :: KParser KExpr
parseFOGt = parseBinaryNoTypeNeeded "FOGt" FOGt parseKExpr

parseFOGe :: KParser KExpr
parseFOGe = parseBinaryNoTypeNeeded "FOGe" FOGe parseKExpr

parseDistDefs :: B.Parser [DistDef]
parseDistDefs = (endBy parseDistDef newline) <* eof

parseDistDef :: B.Parser DistDef
parseDistDef = DistDef <$> ident <*> (skipMany1 space *> sym "~" *> parseDist) <*> (spaces *> keyword "::" *> parseKTypeDist)

parseArrType :: B.Parser KType
parseArrType = Arr <$> parseKTypeDist <*> (spaces *> keyword "->" *> parseKTypeDist)

parseDist :: B.Parser Dist
parseDist =  parseUniformIntDist
         <|> parseBernoulliDist

parseEitherIntString :: B.Parser (Either Int String)
parseEitherIntString = (Left <$> number <|> Right <$> ident) <* spaces

parseEitherRationalString :: B.Parser (Either Rational String)
parseEitherRationalString = (Left <$> rational <|> Right <$> ident) <* spaces

parseUniformIntDist :: B.Parser Dist
parseUniformIntDist = between (sym "UniformInt" *> sym "(")
                              (spaces <* char ')')
                              (UniformInt <$> parseEitherIntString <*> (sym "," *> parseEitherIntString))

parseBernoulliDist :: B.Parser Dist
parseBernoulliDist = between (sym "Bernoulli" *> sym "(")
                             (spaces <* char ')')
                             (Bernoulli <$> parseEitherRationalString)
