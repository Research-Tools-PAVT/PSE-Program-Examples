module Probability where

import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.List as List
import Data.Maybe
import Data.Generics.Uniplate.Data
import Z3.Monad
import Control.Monad ( join, zipWithM )
import Data.Ratio

import Syntax
import Util
import Convert

import Debug.Trace

indepOptimize :: [DistDef] -> DistMap -> [([KExpr],[DistDef],Integer)] -> [[IndPartition]] -> Z3 [AST]
indepOptimize dists distMap ppaths iips = mapM (uncurry kernel) $ zip ppaths iips
  where kernel :: ([KExpr],[DistDef],Integer) -> [IndPartition] -> Z3 AST
        kernel (ks,newDists,w) ips = let partConjuncts = partitionConjuncts distMap ips ks
                                         partDists = map (\p -> filter ((flip Set.member) p . varName) newDists) ips
                                         onlyForall = filter (\k -> null [v | VarC _ v <- universe k, Map.member v distMap]) ks
                                         perConjProbs = map (uncurry $ constructProbs distMap) $ zip (onlyForall:partConjuncts) ([]:partDists)
          in do numer <- mkMul =<< sequence ((mkIntNum w):perConjProbs)
                denom <- (mkRational . toRational) $ distsToTotalWeight dists
                mkDiv numer denom

constructProbs ::  DistMap -> [KExpr] -> [DistDef] -> Z3 AST
constructProbs distMap ks dists = computePathProb dists $ map (convertToZ3 distMap) ks
  where substsAsAST :: [DistDef] -> Z3 [([(AST,AST)],AST)]
        substsAsAST ds = do vars <-  mapM varToSort ds
                            let (vals, weights) = distsToDomainsAndWeights ds
                            elems <- mapM valsToZ3 $ zip (map ktype ds) vals 
                            let substs = zipWithM (zip . repeat) vars elems
                            prodWeights <- mapM (mkRational . toRational . product) (sequence weights)
                            return $ zip substs prodWeights

        indicator :: Z3 AST -> AST -> Z3 AST
        indicator p v = join $ mkIte <$> p <*> return v <*> mkRational 0

        computePathProb :: [DistDef] -> [Z3 AST] -> Z3 AST
        computePathProb ds bs = do
          rawASTs <- sequence bs
          fullPathCond <- mkAnd rawASTs
          substsWithWeights <- substsAsAST ds
          numer <- mapM (\(subst,w) -> indicator (substitute fullPathCond subst) w) substsWithWeights
          mkAdd numer
--          str <- astToString numSum
--          numSumSort <- getSort (trace str numSum) >>= sortToString
--          numSumSort <- getSort numSum >>= sortToString
--          denom <- (mkRational . toRational) $ distsToTotalWeight dists
--          denomSort <- getSort denom >>= sortToString
--          mkDiv numSum denom

constructProbsNoIndep :: [DistDef] -> DistMap -> [([KExpr],[DistDef],Integer)] -> Z3 [AST]
constructProbsNoIndep dists distMap ppaths = mapM (\(ps,ds,weight) -> computePathProb ds weight $ map (convertToZ3 distMap) ps) ppaths
  where substsAsAST :: [DistDef] -> Z3 [([(AST,AST)],AST)]
        substsAsAST ds = do vars <-  mapM varToSort ds
                            let (vals, weights) = distsToDomainsAndWeights ds
                            elems <- mapM valsToZ3 $ zip (map ktype ds) vals 
                            let substs = zipWithM (zip . repeat) vars elems
                            prodWeights <- mapM (mkRational . toRational . product) (sequence weights)
                            return $ zip substs prodWeights

        indicator :: Z3 AST -> AST -> Z3 AST
        indicator p v = join $ mkIte <$> p <*> return v <*> mkRational 0

        computePathProb :: [DistDef] -> Integer -> [Z3 AST] -> Z3 AST
        computePathProb ds weight bs = do
          rawASTs <- sequence bs
          fullPathCond <- mkAnd rawASTs
          substsWithWeights <- substsAsAST ds
          numer <- mapM (\(subst,w) -> indicator (substitute fullPathCond subst) w) substsWithWeights
          numSum <- mkMul =<< sequence [mkIntNum weight, mkAdd numer] -- multiply by weight
--          str <- astToString numSum
--          numSumSort <- getSort (trace str numSum) >>= sortToString
          numSumSort <- getSort numSum >>= sortToString
          denom <- (mkRational . toRational) $ distsToTotalWeight dists
          denomSort <- getSort denom >>= sortToString
          mkDiv numSum denom

distsToDomainsAndWeights :: [DistDef] -> ([[Integer]], [[Integer]])
distsToDomainsAndWeights dists = (map (getDistDomain . dist) dists, map (getWeight . dist) dists)
  where getDistDomain :: Dist -> [Integer]
        getDistDomain (UniformInt l u) = case (l,u) of
          (Right _, _) -> error "TODO: Implement non-integer domain"
          (_, Right _) -> error "TODO: Implement non-integer domain"
          (Left l', Left u') -> [toInteger l'..toInteger u']
        getDistDomain (Bernoulli _) = [0,1]

        getWeight :: Dist -> [Integer]
        getWeight (UniformInt (Left l) (Left u)) = replicate (u - l+1) 1
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
        kernel :: Set.Set IndPartition -> [KExpr] -> Set.Set IndPartition
        kernel curPart (k:ks') = let curPsvs = Set.intersection allPsvs $ Set.fromList [ v | VarC _ v <- universe k ]
                                     newPart = Set.map (\p -> if not (p `Set.disjoint` curPsvs) then Set.union p curPsvs else p) curPart
          in kernel newPart ks'
        kernel curPart [] = curPart

preprocessSimple :: [DistDef] -> [[KExpr]] -> [([KExpr],[DistDef],Integer)]
preprocessSimple dists paths = map preprocessPath paths
  where preprocessPath :: [KExpr] -> ([KExpr],[DistDef],Integer)
        preprocessPath p = let probVarConjuncts = map (\d -> filter (\e -> (varName d) `elem` [s | VarC _ s <- universe e]) p) dists
                               simpleConjuncts = map (filter isSimple) probVarConjuncts
                               weightExprs = map (\(c,s) -> if (length c == length s) && (not $ null s) then Just (last s) else Nothing) $ zip probVarConjuncts simpleConjuncts
                               updateExprs = map (\(s,l) -> case l of Nothing -> s; (Just _) -> init s) $ zip simpleConjuncts weightExprs
                               newDists = map (\(es,d) -> DistDef (varName d) (foldl' updateDist (dist d) es) (ktype d)) $ zip updateExprs dists
                               weight = product $ map (uncurry calcWeight) $ zip weightExprs newDists
          in (p List.\\ (concat simpleConjuncts), concatMap (\(ws,ds) -> if isNothing ws then [ds] else []) $ zip weightExprs newDists, weight)

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
          
