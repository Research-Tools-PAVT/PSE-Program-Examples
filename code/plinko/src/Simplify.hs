module Simplify where

import Data.Generics.Uniplate.Operations
import Control.Monad (mplus)
import qualified Data.HashMap.Strict as Map
import Data.List

import Syntax
import Util

algSimplify :: KExpr -> KExpr
algSimplify = rewrite simplifications 
  where simplifications e = addIdentity e 
          `mplus` multIdentity e
          `mplus` multZero e
          `mplus` eqWithSelect e
          `mplus` trivialOp e
          `mplus` boolAlg e
          `mplus` simplifyIverson e

addIdentity :: KExpr -> Maybe KExpr
addIdentity (Add _ (NumC 0) e) = Just e
addIdentity (Add _ e (NumC 0)) = Just e
addIdentity (Sub _ e (NumC 0)) = Just e
addIdentity (Sub t (NumC 0) e) = Just $ Mul t (NumC (-1)) e
addIdentity _ = Nothing
multIdentity :: KExpr -> Maybe KExpr
multIdentity (Mul _ (NumC 1) e) = Just e
multIdentity (Mul _ e (NumC 1)) = Just e
multIdentity _ = Nothing
multZero :: KExpr -> Maybe KExpr
multZero (Mul _ (NumC 0) _) = Just $ NumC 0
multZero (Mul _ _ (NumC 0)) = Just $ NumC 0
multZero (UDiv _ (NumC 0) _) = Just $ NumC 0
multZero (URem _ (NumC 0) _) = Just $ NumC 0
multZero (SDiv _ (NumC 0) _) = Just $ NumC 0
multZero (SRem _ (NumC 0) _) = Just $ NumC 0
multZero _ = Nothing

-- when I do this weird type shit happens
eqWithSelect :: KExpr -> Maybe KExpr
eqWithSelect (Eq (NumC 1) e) = nestedSelect e
eqWithSelect (Eq (NumC 0) e) = Not Boolean <$> nestedSelect e
eqWithSelect (Ne (NumC 1) e) = Not Boolean <$> nestedSelect e
eqWithSelect (Ne (NumC 0) e) = nestedSelect e
eqWithSelect _ = Nothing

nestedSelect :: KExpr -> Maybe KExpr
nestedSelect (Select _ cond1 (Select _ cond2 (NumC 1) (NumC 0)) (NumC 0)) = Just $ And Boolean cond1 cond2
nestedSelect (Select _ cond1 (Select _ cond2 (NumC 1) (NumC 0)) (NumC 1)) = Just $ Or Boolean cond2 $ Not Boolean cond1
nestedSelect (Select _ cond1 (Select _ cond2 (NumC 0) (NumC 1)) (NumC 0)) = Just $ And Boolean cond1 $ Not Boolean cond2
nestedSelect (Select _ cond1 (Select _ cond2 (NumC 0) (NumC 1)) (NumC 1)) = Just $ Not Boolean (Or Boolean cond1 cond2)
nestedSelect _ = Nothing

trivialOp :: KExpr -> Maybe KExpr
trivialOp (Eq (NumC n1) (NumC n2)) = Just $ BoolC $ n1 == n2
trivialOp (Eq (BoolC b1) (BoolC b2)) = Just $ BoolC $ b1 == b2
trivialOp (Eq (VarC _ s1) (VarC _ s2)) = if s1 == s2 then Just $ BoolC True else Nothing
trivialOp (Ne (NumC n1) (NumC n2)) = Just $ BoolC $ n1 /= n2
trivialOp (Ne (BoolC b1) (BoolC b2)) = Just $ BoolC $ b1 /= b2
trivialOp (Ne (VarC _ s1) (VarC _ s2)) = if s1 /= s2 then Just $ BoolC True else Nothing
trivialOp (Add _ (NumC n1) (NumC n2)) = Just $ NumC $ n1 + n2
trivialOp (Sub _ (NumC n1) (NumC n2)) = Just $ NumC $ n1 - n2
trivialOp (Mul _ (NumC n1) (NumC n2)) = Just $ NumC $ n1 * n2
trivialOp (UDiv _ (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ NumC $ n1 `quot` n2 else Nothing
trivialOp (URem _ (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ NumC $ n1 `rem` n2 else Nothing
trivialOp (SDiv _ (NumC n1) (NumC n2)) = Just $ NumC $ n1 `quot` n2
trivialOp (SRem _ (NumC n1) (NumC n2)) = Just $ NumC $ n1 `rem` n2
trivialOp (And _ (BoolC b1) (BoolC b2)) = Just $ BoolC $ b1 && b2
trivialOp (Or _ (BoolC b1) (BoolC b2)) = Just $ BoolC $ b1 || b2
trivialOp (Not _ (BoolC b)) = Just $ BoolC $ not b
trivialOp (Xor _ (BoolC b1) (BoolC b2)) = Just $ BoolC $ (b1 && not b2) || (b2 && not b1)
trivialOp (Ult (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ BoolC $ n1 < n2 else Nothing
trivialOp (Ule (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ BoolC $ n1 <= n2 else Nothing
trivialOp (Ugt (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ BoolC $ n1 > n2 else Nothing
trivialOp (Uge (NumC n1) (NumC n2)) = if n1 >= 0 && n2 >= 0 then Just $ BoolC $ n1 >= n2 else Nothing
trivialOp (Slt (NumC n1) (NumC n2)) = Just $ BoolC $ n1 < n2 
trivialOp (Sle (NumC n1) (NumC n2)) = Just $ BoolC $ n1 <= n2 
trivialOp (Sgt (NumC n1) (NumC n2)) = Just $ BoolC $ n1 > n2 
trivialOp (Sge (NumC n1) (NumC n2)) = Just $ BoolC $ n1 >= n2
trivialOp _ = Nothing
boolAlg :: KExpr -> Maybe KExpr
boolAlg (Not Boolean (Not Boolean e)) = Just e
boolAlg (Or _ e (BoolC False)) = Just e
boolAlg (Or _ (BoolC False) e) = Just e
boolAlg (Or _ e (BoolC True)) = Just $ BoolC True
boolAlg (Or _ (BoolC True) e) = Just $ BoolC True
boolAlg (And _ (BoolC False) e) = Just $ BoolC False
boolAlg (And _ e (BoolC False)) = Just $ BoolC False
boolAlg (And _ (BoolC True) e) = Just e
boolAlg (And _ e (BoolC True)) = Just e
boolAlg (Or _ e1 e2) = if e1 == e2 then Just e1 else Nothing
boolAlg (And _ e1 e2) = if e1 == e2 then Just e1 else Nothing
boolAlg (Or _ e1 (And _ e2 e3)) = if e1 == e2 || e1 == e3 then Just e1 else Nothing
boolAlg (Or _ (And _ e2 e3) e1) = if e1 == e2 || e1 == e3 then Just e1 else Nothing
boolAlg (And _ (Or t e1 e2) (Or _ e3 e4))
  | e1 == e3 = Just $ Or t e1 (And t e2 e4)
  | e1 == e4 = Just $ Or t e1 (And t e2 e3)
  | e2 == e3 = Just $ Or t e2 (And t e1 e4)
  | e2 == e4 = Just $ Or t e2 (And t e1 e3)
  | otherwise = Nothing
boolAlg _ = Nothing

simplifyIverson :: KExpr -> Maybe KExpr
simplifyIverson (Iverson (BoolC True)) = Just $ NumC 1
simplifyIverson (Iverson (BoolC False)) = Just $ NumC 0
simplifyIverson _ = Nothing

-- applyExprMap :: [([KExpr],[DistDef],Integer)] -> Map.HashMap (KExpr,[DistDef]) (String,Bool) -> Z3
-- applyExprMap paths exprMap = map applyOnPath paths
--   where applyOnPath :: ([KExpr],[DistDef],Integer) -> [KExpr]
--         applyOnPath (path,dists,weight) = let weightExpr = NumC weight

--                                               applyOnConj :: (KExpr,[DistDef]) -> KExpr
--                                               applyOnConj k = case Map.lookup exprMap k of
--                                                 Just (s,b) -> if b
--                                                               then Sub Real (NumC 1) (VarC Real s)
--                                                               else VarC Real s
--                                                 Nothing -> error "Shouldn't happen ever..."
--           in weightExpr:(map applyOnConj $ zip path (repeat dists))

-- Includes negated paths
-- True => Negated
-- False => Not negated
buildExprMap :: [([KExpr],[DistDef],Integer)] -> Map.HashMap (KExpr,[DistDef]) (String,Bool)
buildExprMap paths = foldl' checkThenInsert Map.empty $ zip (concatMap pairExprWithDists paths) [0..]
  where pairExprWithDists :: ([KExpr], [DistDef], Integer) -> [(KExpr,[DistDef])]
        pairExprWithDists (es, ds, _) = zip es $ repeat ds

        checkThenInsert :: Map.HashMap (KExpr,[DistDef]) (String,Bool) -> ((KExpr,[DistDef]),Int) -> Map.HashMap (KExpr,[DistDef]) (String,Bool)
        checkThenInsert m ((e,ds),i) = let negated = negateExpr e
          in case (Map.lookup (e,ds) m, Map.lookup (negated,ds) m) of
               (Just (v1,b1), Just (v2,b2)) -> m
               (Just _, Nothing) -> m
               (Nothing, Just (v,_)) -> Map.insert (e,ds) (v,True) m
               (Nothing, Nothing) -> Map.insert (e,ds) ("plinko_dyn_var" ++ show i,False) m

-- 1) Transform paths so that all static updates are done first, then probabilistic updates after.
-- 2) Grab all static arrays and store in hash map with mapping from unique variable names
-- 3) Replace all static arrays with those variable names.
extractArrayUpdate :: DistMap -> [[KExpr]] -> ([[KExpr]], Map.HashMap KExpr String)
extractArrayUpdate distMap paths = let separated = map (map (transform separateProbUpdates)) paths 
                                       arrays = nub $ concatMap (concatMap (\es -> [ e | e@(KArrayUpdate _ (KArray _)) <- universe es])) separated
                                       subMap = Map.fromList $ zip arrays ["plinko_arr_var" ++ show i | i <- [0..]]
  in (map (map (transform (sub subMap))) separated, subMap) 
  where separateProbUpdates :: KExpr -> KExpr
        separateProbUpdates (KArrayUpdate es arr@(KArray _)) = let 
          isProbUpdate :: (KExpr,KExpr) -> Bool
          isProbUpdate (ind,val) = not (null [s | (VarC _ s) <- universe ind, Map.member s distMap]) || not (null [s | (VarC _ s) <- universe val, Map.member s distMap])

          (probWrites,detWrites) = partition isProbUpdate $ toPairs es
          in if null probWrites
             then KArrayUpdate es arr
             else KArrayUpdate (fromPairs probWrites) (KArrayUpdate (fromPairs detWrites) arr)
        separateProbUpdates e = e

        sub :: Map.HashMap KExpr String -> KExpr -> KExpr
        sub _ (KArrayUpdate [] arr) = arr
        sub m e@(KArrayUpdate es (KArray _)) = case Map.lookup e m of
          Just s -> VarC (Arr (BitVec 32) (BitVec 8)) s
          Nothing -> e
        sub _ e = e
