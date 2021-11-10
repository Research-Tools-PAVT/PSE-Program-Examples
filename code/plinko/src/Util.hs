module Util where

import Syntax
import Convert

import qualified Data.Set as Set

import Text.ParserCombinators.Parsec
import Z3.Monad
import Data.Generics.Uniplate.Data
import Data.Maybe
import Data.Either
import Data.List

--import Text.Parsec (ParseError)

import Debug.Trace

import qualified Data.Set as Set
import qualified Data.Map.Strict as Map
import qualified Data.Traversable as T

isSimple :: KExpr -> Bool
isSimple (Eq (NumC _) (VarC _ _))  = True  
--isSimple (Ne (NumC _) (VarC _ _))  = True
isSimple (Ult (NumC _) (VarC _ _)) = True
isSimple (Ule (NumC _) (VarC _ _)) = True
isSimple (Ugt (NumC _) (VarC _ _)) = True
isSimple (Uge (NumC _) (VarC _ _)) = True
isSimple (Slt (NumC _) (VarC _ _)) = True
isSimple (Sle (NumC _) (VarC _ _)) = True
isSimple (Sgt (NumC _) (VarC _ _)) = True
isSimple (Sge (NumC _) (VarC _ _)) = True
isSimple (Eq (VarC _ _) (NumC _))  = True  
--isSimple (Ne (VarC _ _) (NumC _))  = True
isSimple (Ult (VarC _ _) (NumC _)) = True
isSimple (Ule (VarC _ _) (NumC _)) = True
isSimple (Ugt (VarC _ _) (NumC _)) = True
isSimple (Uge (VarC _ _) (NumC _)) = True
isSimple (Slt (VarC _ _) (NumC _)) = True
isSimple (Sle (VarC _ _) (NumC _)) = True
isSimple (Sgt (VarC _ _) (NumC _)) = True
isSimple (Sge (VarC _ _) (NumC _)) = True
isSimple _ = False

negateComparison :: KExpr -> KExpr
negateComparison (Eq (BoolC False) (Eq e1 e2))  = Ne e1 e2
negateComparison (Eq (BoolC False) (Ne e1 e2))  = Eq e1 e2
negateComparison (Eq (BoolC False) (Ult e1 e2)) = Uge e1 e2
negateComparison (Eq (BoolC False) (Ule e1 e2)) = Ugt e1 e2
negateComparison (Eq (BoolC False) (Ugt e1 e2)) = Ule e1 e2
negateComparison (Eq (BoolC False) (Uge e1 e2)) = Ult e1 e2
negateComparison (Eq (BoolC False) (Slt e1 e2)) = Sge e1 e2
negateComparison (Eq (BoolC False) (Sle e1 e2)) = Sgt e1 e2
negateComparison (Eq (BoolC False) (Sgt e1 e2)) = Sle e1 e2
negateComparison (Eq (BoolC False) (Sge e1 e2)) = Slt e1 e2
negateComparison (Eq (Eq e1 e2) (BoolC False))  = Ne e1 e2
negateComparison (Eq (Ne e1 e2) (BoolC False))  = Eq e1 e2
negateComparison (Eq (Ult e1 e2) (BoolC False)) = Uge e1 e2
negateComparison (Eq (Ule e1 e2) (BoolC False)) = Ugt e1 e2
negateComparison (Eq (Ugt e1 e2) (BoolC False)) = Ule e1 e2
negateComparison (Eq (Uge e1 e2) (BoolC False)) = Ult e1 e2
negateComparison (Eq (Slt e1 e2) (BoolC False)) = Sge e1 e2
negateComparison (Eq (Sle e1 e2) (BoolC False)) = Sgt e1 e2
negateComparison (Eq (Sgt e1 e2) (BoolC False)) = Sle e1 e2
negateComparison (Eq (Sge e1 e2) (BoolC False)) = Slt e1 e2
negateComparison e = e

-- Assuming range of 8 bits
removeReads :: Map.Map String KType -> KExpr -> KExpr
removeReads m e = case e of
  (ReadLSB t (NumC n) (VarC _ v)) -> determineExtract v t n
  (ReadMSB t (NumC n) (VarC _ v)) -> determineExtract v t n
  (Read t (NumC n) (VarC _ v)) -> determineExtract v t n
  _ -> e

  where determineExtract :: String -> KType -> Int -> KExpr
        determineExtract v t@(BitVec s) n = case m Map.!? v of
          Just t' -> if t == t'
                     then VarC t v
                     else Extract (BitVec s) (8*n) (VarC t' v)
          Nothing -> VarC t v
        determineExtract _ _ _ = error $ "Non-bitvector read: " ++ show e 

astToIOString :: Z3 AST -> IO String
astToIOString ast = evalZ3 $ astToString =<< ast

getVarVals :: Map.Map String KType -> DistMap -> [WinningPath] -> Maybe (Z3 [AST])
getVarVals foralls dists wps 
  | all (isJust . varVal) wps = Just $ mapM convVals (catMaybes $ map varVal wps)
  | otherwise = Nothing
  where convVals :: Either ParseError KExpr -> Z3 AST
        convVals (Right ke) = convertToZ3' dists (BitVec 32) (transform (removeReads foralls . negateComparison) ke)
        convVals (Left err) = error $ "Error: ParseErrors found in winning paths: " ++ show err

expandAnd :: [KExpr] -> [KExpr]
expandAnd = nub . concatMap expand
  where expand :: KExpr -> [KExpr]
        expand (And _ e1 e2) = [e1,e2]
        expand ke = [ke]

-- checkWinning :: [WinningPath] -> Set.Set (Set.Set KExpr)
-- checkWinning = Set.fromList . map (Set.fromList . extractErrors)
--   where extractErrors :: WinningPath -> [KExpr]
--         extractErrors (WinningPath ws _ _) = case partitionEithers ws of
--           ([], r) -> r
--           (l, _) -> error $ "Error converting WinningPath into KExprs" ++ show l ++ show ws

-- filterWinning :: Set.Set (Set.Set KExpr) -> [Branch] -> Bool
-- filterWinning winning bs = case partitionEithers $ map predicate $ tail bs of
--   ([], paths) -> Set.member (Set.fromList paths) winning
--   (errors, _) -> error $ "Error: Parse errors found in the _paths.json file: " ++ show errors

-- distsToSymIntervals :: Dists -> IO [SymInterval]
-- distsToSymIntervals dists = T.sequence $ map convert (Map.toList dists)
--   where convert (v, (Left l, Left u))   = return $ SymInterval v (show l) (show u)
--         convert (v, (Left l, Right u))  = SymInterval v (show l) <$> astToIOString (convertToZ3 u)
--         convert (v, (Right l, Left u))  = (\l' -> return $ SymInterval v l' (show u)) =<< astToIOString (convertToZ3 l)
--         convert (v, (Right l, Right u)) = do l' <- astToIOString (convertToZ3 l)
--                                              u' <- astToIOString (convertToZ3 u)
--                                              return $ SymInterval v l' u'

getConcretizedVal :: Z3 AST -> [Z3 AST] -> Z3 (Maybe Integer)
getConcretizedVal v eqs = do
  rawV <- v
  rawEqs <- mkAnd =<< T.sequence eqs
  assert rawEqs
  fmap snd $ withModel $ \m -> fromJust <$> evalInt m rawV

collectForallSizes :: DistMap -> [[Branch]] -> Map.Map String KType
collectForallSizes dm bs = let allExprs = concatMap (concatMap (\b -> rights $ (predicate b):(nodeTrueQuery b))) bs
                               allForallReads = concatMap (\e' -> [ extractVarAndType e | e <- universe e', isForallRead e]) allExprs
  in Map.fromListWith max allForallReads
  where isForallRead :: KExpr -> Bool
        isForallRead (ReadLSB _ (NumC _) (VarC _ s)) = Map.notMember s dm
        isForallRead (ReadMSB _ (NumC _) (VarC _ s)) = Map.notMember s dm
        isForallRead (Read _ (NumC _) (VarC _ s)) = Map.notMember s dm
        isForallRead _ = False

        -- Assuming range of 8 bits
        extractVarAndType :: KExpr -> (String, KType)
        extractVarAndType (ReadLSB (BitVec w) (NumC i) (VarC _ s)) = (s, BitVec (w + 8*i))
        extractVarAndType (ReadMSB (BitVec w) (NumC i) (VarC _ s)) = (s, BitVec (w + 8*i))
        extractVarAndType (Read (BitVec w) (NumC i) (VarC _ s))    = (s, BitVec (w*(i+1)))
        extractVarAndType e = error $ "extractVarAndType: unexpected expression:" ++ show e


collectPSVs :: [DistDef] -> [[KExpr]] -> [DistDef]
collectPSVs origDists bs = let allPSVs = nub [ v | path <- bs, e <- path, VarC _ v <- universe e]
  in map joinDistWithVar (filter (\v -> any (flip isPrefixOf v . varName) origDists) allPSVs)
  where joinDistWithVar :: String -> DistDef
        joinDistWithVar v = case find (\s -> isPrefixOf (varName s) v) (reverse origDists) of
          Just d -> DistDef v (dist d) (ktype d)
          Nothing -> error ("Unknown prob. sym. var: " ++ v)

collectAssumes :: Map.Map String KType -> DistMap -> [[Branch]] -> (Z3 AST, Z3 [AST])
collectAssumes foralls dists bss = let perPathAssumes = map (Set.filter removeIfPSV . collectPerPath) bss
                                       univAssumes = if null perPathAssumes then Set.empty else foldr1 Set.intersection perPathAssumes
                                       uniquePerPathAssumes = map (\xs -> if null xs then [BoolC True] else xs) $ map (Set.toList . flip Set.difference univAssumes) perPathAssumes  
  in (mapM (convertToZ3 dists) (Set.toList univAssumes) >>= mkAnd, sequence $ map (\xs -> mapM (convertToZ3 dists) xs >>= mkAnd) uniquePerPathAssumes)
  where collectPerPath :: [Branch] -> Set.Set KExpr
        collectPerPath bs = let preds = case partitionEithers $ map predicate bs of
                                  ([], r) -> Set.fromList (map (transform $ removeReads foralls) r)
                                  (l, _)  -> error $ "Error: ParseErrors found in predicate, collectAssumes" ++ show l
                                assumes = case partitionEithers $ (init (nodeTrueQuery (bs !! (length bs - 2)))) of
                                  ([], r) -> Set.fromList (map (transform $ removeReads foralls) r)
                                  (l, _)  -> error $ "Error: ParseErrors found in nodeTrueQuery, collectAssumes" ++ show l
          in Set.difference assumes preds

        removeIfPSV :: KExpr -> Bool
        removeIfPSV ke = let vars = nub [ v | VarC _ v <- universe ke ]
          in not $ any (\v -> any (flip isPrefixOf v) (Map.keys dists)) vars

distsToDistMap :: [DistDef] -> DistMap
distsToDistMap = Map.fromList . map (\d -> (varName d, (dist d, ktype d)))

partitionConjuncts :: DistMap -> [IndPartition] -> [KExpr] -> [[KExpr]]
partitionConjuncts distMap ips ks = map extractConjuncts ips
  where extractConjuncts :: IndPartition -> [KExpr]
        extractConjuncts ip = filter (\k -> Set.fromList [ v | VarC _ v <- universe k, Map.member v distMap ] `Set.isSubsetOf` ip) ks

-- storeDists :: [Either ParseError KExpr] -> ([KExpr], Either String (IO Dists))
-- storeDists ks = let (lefts',rights') = partitionEithers ks
--   in if (not . null) lefts'
--      then ([], Left ("Unsupported KExprs: " ++ unlines (map show lefts')))
--      else let concrVars = collectConcretized rights'
--           in (Map.elems concrVars, storeDists' rights' concrVars)
--   where collectConcretized :: [KExpr] -> Map.Map String KExpr 
--         collectConcretized ((Eq (BoolC _) _):ks') = collectConcretized ks'
--         collectConcretized ((Eq _ (BoolC _)):ks') = collectConcretized ks'
--         collectConcretized (e@(Eq e1 e2):ks') = let varName = head ([ v | VarC v <- universe e1 ] ++ [ v | VarC v <- universe e2 ])
--           in Map.insert varName e (collectConcretized ks')
--         collectConcretized (_:ks') = collectConcretized ks'
--         collectConcretized [] = Map.empty
          
-- storeDists' :: [KExpr] -> Map.Map String KExpr -> Either String (IO Dists)
-- storeDists' ((Sle lower' (ReadLSB _ _ (VarC v1))):ds) concrVars = case head ds of
--   (Sle (ReadLSB _ _ (VarC v2)) upper') -> if v1 == v2 && Map.notMember v1 concrVars
--     then let lowerVars = [ v | VarC v <- universe lower' ]
--              upperVars = [ v | VarC v <- universe upper' ]
--              lowerReplVars = Map.keys concrVars `intersect` lowerVars
--              upperReplVars = Map.keys concrVars `intersect` upperVars
--          in case storeDists' (tail ds) concrVars of
--               Left s -> Left s
--               Right ioDists -> Right $ do lowerVal <- evalBound lowerVars lowerReplVars lower' concrVars
--                                           upperVal <- evalBound upperVars upperReplVars upper' concrVars
--                                           Map.insert v1 (lowerVal, upperVal) <$> ioDists
--     else if v1 == v2
--          then storeDists' (tail ds) concrVars
--          else Left $ show v1 ++ " does not match " ++ show v2
--   e -> Left $ "Expecting (Sle) expression; received: " ++ show e ++ show (Sle lower' (ReadLSB 0 (NumC 0) (VarC v1)))
--   where evalBound :: [String] -> [String] -> KExpr -> Map.Map String KExpr -> IO (Either Int KExpr)
--         evalBound vars replVars ke concrVars'
--           | null vars || null (vars \\ replVars) = do
--               maybeNewVal <- evalZ3 (getConcretizedVal (convertToZ3 ke) (map (convertToZ3 . (Map.!) concrVars') replVars))
--               return $ Left $ (fromInteger . fromJust) maybeNewVal
--           | otherwise = return $ Right ke
-- storeDists' (_:ds) concrVars = storeDists' ds concrVars
-- storeDists' [] _ = Right (return Map.empty)