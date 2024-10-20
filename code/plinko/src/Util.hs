module Util where

import Syntax
import Convert

import Text.ParserCombinators.Parsec
import Z3.Monad
import Data.Generics.Uniplate.Operations
import Data.Maybe
import Data.Either
import Data.List
import Data.Hashable
import Control.Monad ((>=>))
--import Text.Parsec (ParseError)
import Debug.Trace

import qualified Data.HashSet as Set
import qualified Data.HashMap.Lazy as Map
import qualified Data.Traversable as T

isNegation :: KExpr -> KExpr -> Bool
isNegation (BoolC True) (BoolC False) = True
isNegation (BoolC False) (BoolC True) = True
isNegation (Not Boolean e1) e2 = e1 == e2
isNegation e1 (Not Boolean e2) = e1 == e2
isNegation (And Boolean e1 e2) (Or Boolean e3 e4) = (isNegation e1 e3 && isNegation e2 e4) || (isNegation e1 e4 && isNegation e2 e3)
isNegation (Or Boolean e1 e2) (And Boolean e3 e4) = (isNegation e1 e3 && isNegation e2 e4) || (isNegation e1 e4 && isNegation e2 e3)
isNegation (Eq e1 e2) (Ne e3 e4) = (e1 == e3 && e2 == e4) || (e1 == e4 && e2 == e3)
isNegation (Ne e1 e2) (Eq e3 e4) = (e1 == e3 && e2 == e4) || (e1 == e4 && e2 == e3)
isNegation (Ult e1 e2) (Uge e3 e4) = e1 == e3 && e2 == e4
isNegation (Uge e1 e2) (Ult e3 e4) = e1 == e3 && e2 == e4
isNegation (Ule e1 e2) (Ugt e3 e4) = e1 == e3 && e2 == e4
isNegation (Ugt e1 e2) (Ule e3 e4) = e1 == e3 && e2 == e4
isNegation (Slt e1 e2) (Sge e3 e4) = e1 == e3 && e2 == e4
isNegation (Sge e1 e2) (Slt e3 e4) = e1 == e3 && e2 == e4
isNegation (Sle e1 e2) (Sgt e3 e4) = e1 == e3 && e2 == e4
isNegation (Sgt e1 e2) (Sle e3 e4) = e1 == e3 && e2 == e4
isNegation (Iverson e1) (Iverson e2) = isNegation e1 e2
isNegation _ _ = False

negateExpr :: KExpr -> KExpr
negateExpr (BoolC b) = BoolC $ not b
negateExpr (Not Boolean e) = e
negateExpr (And Boolean e1 e2) = Or Boolean (Not Boolean e1) (Not Boolean e2)
negateExpr (Or Boolean e1 e2) = And Boolean (Not Boolean e1) (Not Boolean e2)
negateExpr (Eq e1 e2) = Ne e1 e2
negateExpr (Ne e1 e2) = Eq e1 e2
negateExpr (Ult e1 e2) = Uge e1 e2
negateExpr (Uge e1 e2) = Ult e1 e2
negateExpr (Ule e1 e2) = Ugt e1 e2
negateExpr (Ugt e1 e2) = Ule e1 e2
negateExpr (Slt e1 e2) = Sge e1 e2
negateExpr (Sge e1 e2) = Slt e1 e2
negateExpr (Sle e1 e2) = Sgt e1 e2
negateExpr (Sgt e1 e2) = Sle e1 e2
negateExpr (Iverson e) = Iverson (Not Boolean e)
negateExpr e = e

fromPairs :: [(a,a)] -> [a]
fromPairs [] = []
fromPairs ((x,y):zs) = x:y:fromPairs zs

toPairs :: [a] -> [(a,a)]
toPairs [] = []
toPairs [_] = error "Shouldn't happen..."
toPairs (x:y:zs) = (x,y):toPairs zs

notMember :: (Eq k, Hashable k) => k -> Map.HashMap k a -> Bool
notMember k m = not $ Map.member k m

disjoint :: (Eq a, Hashable a) => Set.HashSet a -> Set.HashSet a -> Bool
disjoint hs1 hs2 = Set.null $ Set.intersection hs1 hs2

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
removeReads :: Map.HashMap String KType -> KExpr -> KExpr
removeReads m e = case e of
  (ReadLSB t (NumC n) (VarC _ v)) -> determineExtract v t n
  (ReadMSB t (NumC n) (VarC _ v)) -> determineExtract v t n
  (Read t (NumC n) (VarC _ v)) -> determineExtract v t n
  _ -> e

  where determineExtract :: String -> KType -> Integer -> KExpr
        determineExtract v t@(BitVec s) n = case m Map.!? v of
          Just t' -> if t == t'
                     then VarC t v
                     else Extract (BitVec s) (8*n) (VarC t' v)
          Nothing -> VarC t v
        determineExtract _ _ _ = error $ "Non-bitvector read: " ++ show e 

astToIOString :: Z3 AST -> IO String
astToIOString ast = evalZ3 $ astToString =<< ast

convertObservedVals :: Bool -> Map.HashMap String KType -> DistMap -> [Path] -> [[KExpr]] -> ([[KExpr]], Maybe (Z3 [AST]))
convertObservedVals fBool foralls dists ps paths
  | all (isJust . obsVal) ps && fBool = let (kes, path) = foldr1 maximizePath $ zip paths ps
    in ([kes], trace ("Number of Comparisons = " ++ show (fromRight (NumC (-1)) (varVal (fromJust (obsVal path))))) Nothing)
  | all (isJust . obsVal) ps && not fBool = (paths, Just $ mapM (convVal . varVal) (mapMaybe obsVal ps))
  | otherwise = (paths, Nothing)
  where convVal :: Either ParseError KExpr -> Z3 AST
        convVal (Right ke) = convertToZ3' dists (BitVec 32) (transform (removeReads foralls . negateComparison) ke)
        convVal (Left err) = error $ "Error: ParseErrors found in winning paths: " ++ show err

        maximizePath :: ([KExpr], Path) -> ([KExpr], Path) -> ([KExpr], Path)
        maximizePath x1@(_, Path _ _ (Just ov1)) x2@(_, Path _ _ (Just ov2))
          | ov1 == maximizeObsVal ov1 ov2 = x1
          | otherwise = x2
        maximizePath _ _ = error "Should never happen..."

        maximizeObsVal :: ObservedValue -> ObservedValue -> ObservedValue
        maximizeObsVal ov1@(ObservedValue _ (Right v1)) ov2@(ObservedValue _ (Right v2))
          | v1 == max v1 v2 = ov1
          | otherwise = ov2
        maximizeObsVal (ObservedValue _ (Left err)) _ = error $ "Error: ParseError found in winning paths: " ++ show err
        maximizeObsVal _ (ObservedValue _ (Left err)) = error $ "Error: ParseError found in winning paths: " ++ show err

expandAnd :: [KExpr] -> [KExpr]
expandAnd = nub . concatMap expand
  where expand :: KExpr -> [KExpr]
        expand (And _ e1 e2) = [e1,e2]
        expand ke = [ke]

-- checkWinning :: [WinningPath] -> Set.HashSet (Set.HashSet KExpr)
-- checkWinning = Set.fromList . map (Set.fromList . extractErrors)
--   where extractErrors :: WinningPath -> [KExpr]
--         extractErrors (WinningPath ws _ _) = case partitionEithers ws of
--           ([], r) -> r
--           (l, _) -> error $ "Error converting WinningPath into KExprs" ++ show l ++ show ws

-- filterWinning :: Set.HashSet (Set.HashSet KExpr) -> [Branch] -> Bool
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

collectForallSizes :: DistMap -> [[Branch]] -> Map.HashMap String KType
collectForallSizes dm bs = let allExprs = concatMap (concatMap (\b -> rights $ predicate b:nodeTrueQuery b)) bs
                               allForallReads = concatMap (\e' -> [ extractVarAndType e | e <- universe e', isForallRead e]) allExprs
  in Map.fromListWith max allForallReads
  where isForallRead :: KExpr -> Bool
        isForallRead (ReadLSB _ (NumC _) (VarC _ s)) = notMember s dm
        isForallRead (ReadMSB _ (NumC _) (VarC _ s)) = notMember s dm
        isForallRead (Read _ (NumC _) (VarC _ s)) = notMember s dm
        isForallRead _ = False

        -- Assuming range of 8 bits
        extractVarAndType :: KExpr -> (String, KType)
        extractVarAndType (ReadLSB (BitVec w) (NumC i) (VarC _ s)) = (s, BitVec (w + 8*fromInteger i))
        extractVarAndType (ReadMSB (BitVec w) (NumC i) (VarC _ s)) = (s, BitVec (w + 8*fromInteger i))
        extractVarAndType (Read (BitVec w) (NumC i) (VarC _ s))    = (s, BitVec (w*(fromInteger i+1)))
        extractVarAndType e = error $ "extractVarAndType: unexpected expression:" ++ show e


collectPSVs :: [DistDef] -> [[KExpr]] -> [DistDef]
collectPSVs origDists bs = let allPSVs = nub [ v | path <- bs, e <- path, VarC _ v <- universe e]
  in map joinDistWithVar (filter (\v -> any (flip isPrefixOf v . varName) origDists) allPSVs)
  where joinDistWithVar :: String -> DistDef
        joinDistWithVar v = case find (\s -> varName s `isPrefixOf` v) (reverse origDists) of
          Just d -> DistDef v (dist d) (ktype d)
          Nothing -> error ("Unknown prob. sym. var: " ++ v)

collectAssumes :: Map.HashMap String KType -> DistMap -> [[Branch]] -> (Z3 AST, Z3 [AST])
collectAssumes foralls dists bss = let perPathAssumes = map (Set.filter removeIfPSV . collectPerPath) bss
                                       univAssumes = if null perPathAssumes
                                                     then Set.empty
                                                     else foldr1 Set.intersection perPathAssumes
                                       uniquePerPathAssumes = map
                                         ((\ xs -> if null xs
                                                   then [BoolC True]
                                                   else xs)
                                          . Set.toList . flip Set.difference univAssumes)
                                         perPathAssumes
  in (mapM (convertToZ3 dists) (Set.toList univAssumes) >>= mkAnd, mapM (mapM (convertToZ3 dists) >=> mkAnd) uniquePerPathAssumes)
  where collectPerPath :: [Branch] -> Set.HashSet KExpr
        collectPerPath bs = let preds = case partitionEithers $ map predicate bs of
                                  ([], r) -> Set.fromList (map (transform $ removeReads foralls) r)
                                  (l, _)  -> error $ "Error: ParseErrors found in predicate, collectAssumes" ++ show l
                                assumes = case partitionEithers (init (nodeTrueQuery (bs !! (length bs - 2)))) of
                                  ([], r) -> Set.fromList (map (transform $ removeReads foralls) r)
                                  (l, _)  -> error $ "Error: ParseErrors found in nodeTrueQuery, collectAssumes" ++ show l
          in Set.difference assumes preds

        removeIfPSV :: KExpr -> Bool
        removeIfPSV ke = let vars = nub [ v | VarC _ v <- universe ke ]
          in not $ any (\v -> any (`isPrefixOf` v) (Map.keys dists)) vars

distsToDistMap :: [DistDef] -> DistMap
distsToDistMap = Map.fromList . map (\d -> (varName d, (dist d, ktype d)))

partitionConjuncts :: DistMap -> [IndPartition] -> [KExpr] -> [[KExpr]]
partitionConjuncts distMap ips ks = map extractConjuncts ips
  where extractConjuncts :: IndPartition -> [KExpr]
        extractConjuncts ip = filter (\k -> Set.fromList [ v | VarC _ v <- universe k, Map.member v distMap ] `Set.isSubsetOf` ip) ks

extractRelevantDists :: KExpr -> [DistDef] -> [DistDef]
extractRelevantDists e = filter (flip elem [v | VarC _ v <- universe e] . varName)

getDistDomain :: Dist -> [Integer]
getDistDomain (UniformInt l u) = case (l,u) of
          (Right _, _) -> error "TODO: Implement non-integer domain"
          (_, Right _) -> error "TODO: Implement non-integer domain"
          (Left l', Left u') -> [toInteger l'..toInteger u']
getDistDomain (Bernoulli _) = [0,1]

isNum :: KExpr -> Bool
isNum (NumC _) = True
isNum _ = False

isBool :: KExpr -> Bool
isBool (BoolC _) = True
isBool _ = False

extractNum :: KExpr -> Maybe Integer
extractNum (NumC n) = Just n
extractNum _ = Nothing

extractBool :: KExpr -> Maybe Bool
extractBool (BoolC b) = Just b
extractBool _ = Nothing

extractNums :: [KExpr] -> [Integer]
extractNums = mapMaybe extractNum

extractBools :: [KExpr] -> [Bool]
extractBools = mapMaybe extractBool


-- storeDists :: [Either ParseError KExpr] -> ([KExpr], Either String (IO Dists))
-- storeDists ks = let (lefts',rights') = partitionEithers ks
--   in if (not . null) lefts'
--      then ([], Left ("Unsupported KExprs: " ++ unlines (map show lefts')))
--      else let concrVars = collectConcretized rights'
--           in (Map.elems concrVars, storeDists' rights' concrVars)
--   where collectConcretized :: [KExpr] -> Map.HashMap String KExpr 
--         collectConcretized ((Eq (BoolC _) _):ks') = collectConcretized ks'
--         collectConcretized ((Eq _ (BoolC _)):ks') = collectConcretized ks'
--         collectConcretized (e@(Eq e1 e2):ks') = let varName = head ([ v | VarC v <- universe e1 ] ++ [ v | VarC v <- universe e2 ])
--           in Map.insert varName e (collectConcretized ks')
--         collectConcretized (_:ks') = collectConcretized ks'
--         collectConcretized [] = Map.empty
          
-- storeDists' :: [KExpr] -> Map.HashMap String KExpr -> Either String (IO Dists)
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
--   where evalBound :: [String] -> [String] -> KExpr -> Map.HashMap String KExpr -> IO (Either Int KExpr)
--         evalBound vars replVars ke concrVars'
--           | null vars || null (vars \\ replVars) = do
--               maybeNewVal <- evalZ3 (getConcretizedVal (convertToZ3 ke) (map (convertToZ3 . (Map.!) concrVars') replVars))
--               return $ Left $ (fromInteger . fromJust) maybeNewVal
--           | otherwise = return $ Right ke
-- storeDists' (_:ds) concrVars = storeDists' ds concrVars
-- storeDists' [] _ = Right (return Map.empty)
