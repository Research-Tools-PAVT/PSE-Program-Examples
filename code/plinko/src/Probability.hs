module Probability where

import qualified Data.HashSet as Set
import qualified Data.HashMap.Strict as Map
import Data.List as List
import Data.Maybe
import Data.Generics.Uniplate.Operations
import Z3.Monad
import Control.Monad ( join, zipWithM, (<=<) )
import Control.Monad.Extra (concatMapM)
import Data.Ratio
import Debug.Trace

import Syntax
import Util
import Convert
import Simplify (algSimplify, buildExprMap)

indepOptimize :: [DistDef] -> DistMap -> [([KExpr],[DistDef],Integer)] -> [[IndPartition]] -> Z3 [AST]
indepOptimize dists distMap = zipWithM kernel
  where kernel :: ([KExpr],[DistDef],Integer) -> [IndPartition] -> Z3 AST
        kernel (ks,newDists,w) ips = let partConjuncts = partitionConjuncts distMap ips ks
                                         partDists = map (\p -> filter (flip Set.member p . varName) newDists) ips
                                         onlyForall = filter (\k -> null [v | VarC _ v <- universe k, Map.member v distMap]) ks
                                         perConjProbs = zipWith (constructProbs distMap) (onlyForall : partConjuncts) ([] : partDists)
          in do numer <- mkMul =<< sequence (mkIntNum w:perConjProbs)
                denom <- (mkRational . toRational) $ distsToTotalWeight dists
                mkDiv numer denom

constructProbs ::  DistMap -> [KExpr] -> [DistDef] -> Z3 AST
constructProbs distMap ks dists = computePathProb dists $ map (convertToZ3 distMap) ks
  where computePathProb :: [DistDef] -> [Z3 AST] -> Z3 AST
        computePathProb ds bs = do
          rawASTs <- sequence bs
          fullPathCond <- mkAnd rawASTs
          substsWithWeights <- distsToSubsts ds
          numer <- mapM (\(subst,w) -> indicator (substitute fullPathCond subst) w) substsWithWeights
          mkAdd numer
--          str <- astToString numSum
--          numSumSort <- getSort (trace str numSum) >>= sortToString
--          numSumSort <- getSort numSum >>= sortToString
--          denom <- (mkRational . toRational) $ distsToTotalWeight dists
--          denomSort <- getSort denom >>= sortToString
--          mkDiv numSum denom

-- expandExprs :: [([KExpr],[DistDef],Integer)] -> Map.HashMap (KExpr,[DistDef]) KExpr
-- expandExprs xs = let baseMap = filterUniquePaths xs
--   in Map.mapWithKey applyAssignment baseMap
--   where genAllAssignments :: [(KExpr,[Integer])] -> [([KExpr],[KExpr])]
--         genAllAssignments varsAndVals = let vars = map fst varsAndVals
--                                             vals = map snd varsAndVals
--           in zip (repeat vars) (sequence $ map (map NumC) vals)

--         applyAssignment :: (KExpr,[DistDef]) -> KExpr -> KExpr
--         applyAssignment (e',ds) e = let 
--           vals = map (getDistDomain . dist) ds
--           vars = map (uncurry VarC) $ zip (map ktype ds) (map varName ds)

--           sub :: KExpr -> KExpr -> KExpr -> KExpr
--           sub vr vl e'' = if e == vr then vl else e''
                                       
--           assignments = genAllAssignments $ zip vars vals
--           baseExpansion = Add Real $ map (\(vars',vals') -> Iverson $ foldl' (\cond -> \(var',val') -> transform (sub var' val') cond) e $ zip vars' vals') assignments
--           in if isNegation e' e
--              then Sub Real (NumC 1) baseExpansion
--              else baseExpansion

simplifyAndCombine' :: Bool -> [([KExpr],[DistDef],Integer)] -> [DistDef] -> DistMap -> Map.HashMap (KExpr,[DistDef]) KExpr -> Z3 [AST]
simplifyAndCombine' simplify' paths dists distMap exprMap = do 
  paths' <- mapM (convertToZ3Real distMap . combinePerPath) paths
  denom <- (mkRational . toRational) $ distsToTotalWeight dists
  zipWithM mkDiv paths' (repeat denom)
  where combinePerPath :: ([KExpr], [DistDef], Integer) -> KExpr
        combinePerPath (conjs, ds, weight) = let weightExpr = NumC weight
                                                 probConjs = weightExpr : map (\ x_ -> curry (exprMap Map.!) x_ ds) conjs
          in (if simplify' then algSimplify else id) $ foldl1' (Mul Real) probConjs

constructRawProbFormula :: [([KExpr],[DistDef],Integer)] -> [[[KExpr]]]
constructRawProbFormula = map (\(ps,ds,weight) -> computePathProbForm ps ds weight) 
  where -- Expensive...
        genAllAssignments :: [(KExpr,[Integer])] -> [([KExpr],[KExpr])]
        genAllAssignments varsAndVals = let vars = map fst varsAndVals
                                            vals = map snd varsAndVals
          in zip (repeat vars) (mapM (map NumC) vals)

        applyAssignments :: KExpr -> [KExpr] -> [[Integer]] -> [KExpr]
        applyAssignments cond vars vals = let sub :: KExpr -> KExpr -> KExpr -> KExpr
                                              sub var' val e = if e == var' then val else e

                                              varsInCond = [v | VarC _ v <- universe cond]
                                              filteredVarsAndVals = filter (\(VarC _ v,_) -> v `elem` varsInCond) $ zip vars vals
                                              assignments = genAllAssignments filteredVarsAndVals
          in map (\(vars',vals') -> foldl' (\cond' (var', val') -> transform (sub var' val') cond') cond $ zip vars' vals') assignments

        computePathProbForm :: [KExpr] -> [DistDef] -> Integer -> [[KExpr]]
        computePathProbForm ps ds weight = let vals = map (getDistDomain . dist) ds
                                               vars = zipWith VarC (map ktype ds) (map varName ds)
                                               weightExpr = [NumC weight]
          in weightExpr:map (\ cond -> applyAssignments (Iverson cond) vars vals) ps

simplifyAndCombine :: [DistDef] -> DistMap -> [[[KExpr]]] -> Z3 [AST]
simplifyAndCombine dists distMap pss = let --pss' = map (map (map algSimplify)) pss
                                           paths = map (algSimplify . combinePerPath) pss
  in do paths' <- mapM (convertToZ3Real distMap) paths
        denom <- (mkRational . toRational) $ distsToTotalWeight dists
        zipWithM mkDiv paths' (repeat denom)
  where combinePerPath :: [[KExpr]] -> KExpr
        combinePerPath ps = let conjs = map combinePerConj ps
--          in algSimplify $ foldl1' (Mul Real) conjs
          in foldl1' (Mul Real) conjs
        
        combinePerConj :: [KExpr] -> KExpr
--        combinePerConj ps = algSimplify $ foldl1' (Add Real) ps
        combinePerConj = foldl1' (Add Real)

exprMapToAsserts ::  DistMap -> Map.HashMap (KExpr,[DistDef]) (String,Bool) -> (Z3 [AST], Map.HashMap (KExpr,[DistDef]) (Z3 [AST]))
exprMapToAsserts distMap exprMap = let uniqueExprs = nub $ Map.toList $ Map.map removeBool exprMap
  in (concatMapM createAssert uniqueExprs, Map.mapWithKey updateExprMap exprMap)
  where substMap :: Map.HashMap [DistDef] (Z3 [([(AST,AST)],AST)])
        substMap = let allDists = Set.toList $ Set.map snd $ Map.keysSet exprMap
          in Map.fromList $ zip allDists $ map distsToSubsts allDists

        updateExprMap :: (KExpr,[DistDef]) -> (String,Bool) -> Z3 [AST]
        updateExprMap (_,ds) (s,b) = do
          substs <- case Map.lookup ds substMap of
            Just x -> x
            Nothing -> error "Shouldn't happen..."
          varNamesAsASTs <- mapM (mkRealVar <=< mkStringSymbol) [ s ++ "-" ++ show i | i <- [0..length substs-1]]
          if b 
            then mapM (\p -> indicator (mkEq p =<< mkInteger 0) =<< mkInteger 1) varNamesAsASTs
            else return varNamesAsASTs

        removeBool :: (String,Bool) -> String
        removeBool (s,_) = s

        createAssert :: ((KExpr,[DistDef]),String) -> Z3 [AST]
        createAssert ((e,ds),s) = do
          substs <- case Map.lookup ds substMap of
            Just x -> x
            Nothing -> error "Shouldn't happen..."
          varNamesAsASTs <- mapM (mkRealVar <=< mkStringSymbol) [ s ++ "-" ++ show i | i <- [0..length substs-1]]
          ast <- convertToZ3 distMap e
          probs <- mapM (\(subst,w) -> indicator (substitute ast subst) w) substs
          zipWithM mkEq probs varNamesAsASTs

distsToSubsts :: [DistDef] -> Z3 [([(AST,AST)],AST)]
distsToSubsts ds = do
  vars <-  mapM varToSort ds
  let (vals, weights) = distsToDomainsAndWeights ds
  elems <- mapM valsToZ3 $ zip (map ktype ds) vals
  let substs = zipWithM (zip . repeat) vars elems
  prodWeights <- mapM (mkRational . toRational . product) (sequence weights)
  return $ zip substs prodWeights

constructProbsNoIndep :: [DistDef] -> DistMap -> [([KExpr],[DistDef],Integer)] -> Z3 [AST]
constructProbsNoIndep dists distMap = mapM (\(ps,ds,weight) -> computePathProb ds weight $ map (convertToZ3 distMap) ps)
  where denom :: Z3 AST
        denom = (mkRational . toRational) $ distsToTotalWeight dists

        computePathProb :: [DistDef] -> Integer -> [Z3 AST] -> Z3 AST
        computePathProb ds weight bs = do
          rawASTs <- sequence bs
          fullPathCond <- mkAnd rawASTs
          substsWithWeights <- distsToSubsts ds
          numer <- mapM (\(subst,w) -> indicator (substitute fullPathCond subst) w) substsWithWeights
          numSum <- mkMul =<< sequence [mkIntNum weight, mkAdd numer] -- multiply by weight
--          str <- astToString numSum
--          numSumSort <- getSort (trace str numSum) >>= sortToString
          mkDiv numSum =<< denom

distsToDomainsAndWeights :: [DistDef] -> ([[Integer]], [[Integer]])
distsToDomainsAndWeights dists = (map (getDistDomain . dist) dists, map (getWeight . dist) dists)
  where getDistDomain :: Dist -> [Integer]
        getDistDomain (UniformInt l u) = case (l,u) of
          (Right _, _) -> error "TODO: Implement non-integer domain"
          (_, Right _) -> error "TODO: Implement non-integer domain"
          (Left l', Left u') -> [toInteger l'..toInteger u']
        getDistDomain (Bernoulli _) = [0,1]

        getWeight :: Dist -> [Integer]
        getWeight (UniformInt (Left l) (Left u)) = genericReplicate (u - l+1) 1
        getWeight (UniformInt _ _) = error "TODO: Implement weight for string Uniform weight"
        getWeight (Bernoulli (Left p)) = [denominator p - numerator p, numerator p]
        getWeight (Bernoulli (Right _)) = error "TODO: Implement weight for string Bernoulli weight"

distsToTotalWeight :: [DistDef] -> Integer
distsToTotalWeight dists = product $ map (getDenom . dist) dists
  where getDenom :: Dist -> Integer
        getDenom (UniformInt l u) = case (l,u) of
          (Right _, _) -> error "TODO: Implement non-integer domain"
          (_, Right _) -> error "TODO: Implement non-integer domain"
          (Left l', Left u') -> toInteger u' - toInteger l' + 1
        getDenom (Bernoulli (Left p)) = denominator p
        getDenom (Bernoulli (Right _)) = error "TODO: Implement denom for string Bernoulli weight"       

calcIMap :: DistMap -> [KExpr] -> [IndPartition]
calcIMap dists = Set.toList . kernel (Set.map Set.singleton allPsvs)
  where allPsvs = Set.fromList $ Map.keys dists
        kernel :: Set.HashSet IndPartition -> [KExpr] -> Set.HashSet IndPartition
        kernel curPart (k:ks') = let curPsvs = Set.intersection allPsvs $ Set.fromList [ v | VarC _ v <- universe k ]
                                     newPart = Set.map (\p -> if not (disjoint p curPsvs) then Set.union p curPsvs else p) curPart
          in kernel newPart ks'
        kernel curPart [] = curPart

preprocessSimple :: [DistDef] -> [[KExpr]] -> [([KExpr],[DistDef],Integer)]
preprocessSimple dists = map preprocessPath
  where preprocessPath :: [KExpr] -> ([KExpr],[DistDef],Integer)
        preprocessPath p = let probVarConjuncts = map (\d -> filter (\e -> varName d `elem` [s | VarC _ s <- universe e]) p) dists
                               simpleConjuncts = map (filter isSimple) probVarConjuncts
                               weightExprs = zipWith (\ c s ->
                                                        if (length c == length s) && not (null s)
                                                         then Just (last s)
                                                         else Nothing)
                                             probVarConjuncts simpleConjuncts
                               updateExprs = zipWith (\ s l -> case l of
                                                                Nothing -> s
                                                                Just _ -> init s)
                                             simpleConjuncts weightExprs
                               newDists = zipWith (\ es d -> DistDef (varName d) (foldl' updateDist (dist d) es) (ktype d)) updateExprs dists
                               weight = product $ zipWith calcWeight weightExprs newDists
          in (p List.\\ concat simpleConjuncts, concatMap (\(ws,ds) -> ([ds | isNothing ws])) $ zip weightExprs newDists, weight)

        updateDist ::  Dist -> KExpr -> Dist
        updateDist (UniformInt (Left l) (Left u)) (Eq (NumC n) _)
          | l <= n && n <= u = UniformInt (Left n) (Left n)
          | otherwise = UniformInt (Left 1) (Left (-1))
        updateDist (UniformInt (Left _) (Left u)) (Ult (NumC n) _) = UniformInt (Left (n+1)) (Left u)
        updateDist (UniformInt (Left _) (Left u)) (Ule (NumC n) _) = UniformInt (Left n) (Left u)
        updateDist (UniformInt (Left l) (Left _)) (Ugt (NumC n) _) = UniformInt (Left l) (Left (n-1))
        updateDist (UniformInt (Left l) (Left _)) (Uge (NumC n) _) = UniformInt (Left l) (Left n)
        updateDist (UniformInt (Left _) (Left u)) (Slt (NumC n) _) = UniformInt (Left (n+1)) (Left u)
        updateDist (UniformInt (Left _) (Left u)) (Sle (NumC n) _) = UniformInt (Left n) (Left u)
        updateDist (UniformInt (Left l) (Left _)) (Sgt (NumC n) _) = UniformInt (Left l) (Left (n-1))
        updateDist (UniformInt (Left l) (Left _)) (Sge (NumC n) _) = UniformInt (Left l) (Left n)
        updateDist (UniformInt (Left l) (Left u)) (Eq _ (NumC n))
          | l <= n && n <= u = UniformInt (Left n) (Left n)
          | otherwise = UniformInt (Left 1) (Left (-1))
        updateDist (UniformInt (Left l) (Left _)) (Ult _ (NumC n)) = UniformInt (Left l) (Left (n-1))
        updateDist (UniformInt (Left l) (Left _)) (Ule _ (NumC n)) = UniformInt (Left l) (Left n)
        updateDist (UniformInt (Left _) (Left u)) (Ugt _ (NumC n)) = UniformInt (Left (n+1)) (Left u)
        updateDist (UniformInt (Left _) (Left u)) (Uge _ (NumC n)) = UniformInt (Left n) (Left u)
        updateDist (UniformInt (Left l) (Left _)) (Slt _ (NumC n)) = UniformInt (Left l) (Left (n-1))
        updateDist (UniformInt (Left l) (Left _)) (Sle _ (NumC n)) = UniformInt (Left l) (Left n)
        updateDist (UniformInt (Left _) (Left u)) (Sgt _ (NumC n)) = UniformInt (Left (n+1)) (Left u)
        updateDist (UniformInt (Left _) (Left u)) (Sge _ (NumC n)) = UniformInt (Left n) (Left u)
        updateDist _ _ = error "Unsupported KExpr or Dist"

        calcWeight :: Maybe KExpr -> DistDef -> Integer
        calcWeight Nothing _ = 1
        calcWeight (Just e) (DistDef _ (UniformInt (Left l) (Left u)) _) 
          | l <= u = case e of
              (Eq (NumC n) _) -> if l <= n && n <= u then 1 else 0
              (Ult (NumC n) _) -> toInteger $ max (u - n) 0
              (Ule (NumC n) _) -> toInteger $ max (u-n+1) 0
              (Ugt (NumC n) _) -> toInteger $ max (n-l) 0
              (Uge (NumC n) _) -> toInteger $ max (n-l+1) 0
              (Slt (NumC n) _) -> toInteger $ max (u - n) 0
              (Sle (NumC n) _) -> toInteger $ max (u-n+1) 0
              (Sgt (NumC n) _) -> toInteger $ max (n-l) 0
              (Sge (NumC n) _) -> toInteger $ max (n-l+1) 0
              (Eq _ (NumC n)) -> if l <= n && n <= u then 1 else 0
              (Ult _ (NumC n)) -> toInteger $ max (n-l) 0
              (Ule _ (NumC n)) -> toInteger $ max (n-l+1) 0
              (Ugt _ (NumC n)) -> toInteger $ max (u-n) 0
              (Uge _ (NumC n)) -> toInteger $ max (u-n+1) 0
              (Slt _ (NumC n)) -> toInteger $ max (n-l) 0
              (Sle _ (NumC n)) -> toInteger $ max (n-l+1) 0
              (Sgt _ (NumC n)) -> toInteger $ max (u-n) 0
              (Sge _ (NumC n)) -> toInteger $ max (u-n+1) 0
              e' -> error ("Unsupported KExpr: " ++ show e')
          | otherwise = 0
        calcWeight _ d = error ("Unsupported dist: " ++ show d) 
          
indicator :: Z3 AST -> AST -> Z3 AST
indicator p v = join $ mkIte <$> p <*> return v <*> mkRational 0

dynProgNoSimplify :: [([KExpr],[DistDef],Integer)] -> [DistDef] -> DistMap -> (Z3 [AST], Z3 [AST])
dynProgNoSimplify paths dists distMap = let exprMap = buildExprMap paths
                                            (varAsserts, exprMap') = exprMapToAsserts distMap exprMap
  in (varAsserts, mapM (applyExprMap dists exprMap') paths)

applyExprMap :: [DistDef] -> Map.HashMap (KExpr,[DistDef]) (Z3 [AST]) -> ([KExpr],[DistDef],Integer) -> Z3 AST
applyExprMap dists _ ([],[],weight) = do
  weight' <- mkInt2Real =<< mkIntNum weight
  mkDiv weight' =<< denom
  where denom :: Z3 AST
        denom = (mkRational . toRational) $ distsToTotalWeight dists
applyExprMap dists exprMap (path,ds,weight) = do
  path' <- mapM (exprMap Map.!) $ zip path (repeat ds)
  numer <- mkAdd =<< mapM mkMul (transpose path')
  weight' <- mkIntNum weight
  numerWithWeight <- mkMul [weight', numer]
  mkDiv numerWithWeight =<< denom
  where denom :: Z3 AST
        denom = (mkRational . toRational) $ distsToTotalWeight dists


