{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}

module Main where

import Simplify (extractArrayUpdate)
import Syntax (JSONPathList(..), WinningPath(..), winPathNum, pathNum, branches, predicate, KType(..), KExpr(..), DistDef(..), DistMap)
import Parser (parseDistDefs)
import Convert
import Util
import Probability
import ParseArgs (Args(..), runArgsParser, Benchmark(..))
import Queries (askZ3, laplaceMechanismEval)

import Data.Either
import Control.Lens (sequenceOf, each)
import Data.List
import qualified Data.HashMap.Lazy as Map
import Z3.Monad
import Text.Parsec (parse)
import qualified Data.ByteString as B
import System.FilePath.Posix ((</>))
import Data.Generics.Uniplate.Operations
import System.Directory (listDirectory)
import Data.Aeson
import Debug.Trace
import System.TimeIt

import qualified Data.Map as Map()

getRequiredFiles :: FilePath -> IO (B.ByteString, B.ByteString, B.ByteString)
getRequiredFiles dir = do
  files <- listDirectory dir
  case find (isSuffixOf "_paths.json") files of
    Just pathsFile -> case find (isSuffixOf "_winning.json") files of
      Just winningFile -> case find (isSuffixOf "_dists.txt") files of
        Just distsFile -> sequenceOf each (B.readFile $ dir </> pathsFile, B.readFile $ dir </> winningFile, B.readFile $ dir </> distsFile)
        Nothing -> error $ "Cannot locate \"*_dists.txt\" file in " ++ dir
      Nothing -> error $ "Cannot locate \"*_winning.json\" file in " ++ dir
    Nothing -> error $ "Cannot locate \"*_paths.json\" file in " ++ dir

laplaceManualConversion :: ([KExpr], [DistDef], Integer) -> ([([KExpr], [DistDef], Integer)], [([KExpr], [DistDef], Integer)])
laplaceManualConversion ([Or _ e1 e2], dists, w) = ([([e1], dists, w)],[([e2], dists, w)])

getProbFormula :: Bool -> Bool -> [([KExpr],[DistDef],Integer)] -> [DistDef] -> DistMap -> (Z3 [AST], Z3 [AST])
getProbFormula True False paths dists distMap = dynProgNoSimplify paths dists distMap
getProbFormula True True _ _ _ = error "Cannot support both algebraic simplifications and dynamic programming"
getProbFormula False simplify' paths dists distMap
  | simplify' = (return [], simplifyAndCombine dists distMap $ constructRawProbFormula paths)
  | otherwise = (return [], constructProbsNoIndep dists distMap paths)

main :: IO ()
main = main' =<< runArgsParser

main' :: Args -> IO ()
main' (Args dir threads' simplify' dynamic' arrayAssert' benchmark') = do
  (text, winPathsText, readDists) <- getRequiredFiles dir
  case (eitherDecodeStrict text, eitherDecodeStrict winPathsText) :: (Either String JSONPathList, Either String [WinningPath]) of
    (Left err, _) -> print err
    (_, Left err) -> print err
    (Right (PathList bs), Right wps) -> case parse parseDistDefs "" readDists of
      Left err -> print err
      Right origDists -> let onlyWinningPaths = filter (flip elem (map winPathNum wps) . pathNum) bs
                             onlyWinningBranches = map branches onlyWinningPaths
                             eitherErrorsPaths = map (map predicate . tail) onlyWinningBranches
                             pathsErrors = lefts (concat eitherErrorsPaths)
                         in if null pathsErrors
                            then let paths = map rights eitherErrorsPaths
                                     dists = collectPSVs origDists paths
                                     distMap = distsToDistMap (trace ("Num PSVs: " ++ show (length dists)) dists)
                                     foralls = collectForallSizes distMap onlyWinningBranches
                                     (univAssume, pathAssumes) = collectAssumes foralls distMap onlyWinningBranches
                                     (updatedPaths, observedVals) = (case benchmark' of
                                                                       CalcWorstCase -> convertObservedVals True
                                                                       _ -> convertObservedVals False) foralls distMap onlyWinningPaths paths
                                 in processAndEvaluatePaths updatedPaths dists distMap foralls observedVals univAssume pathAssumes
                            else print pathsErrors
    where processAndEvaluatePaths :: [[KExpr]] -> [DistDef] -> DistMap -> Map.HashMap String KType -> Maybe (Z3 [AST]) -> Z3 AST -> Z3 [AST] -> IO ()
          processAndEvaluatePaths paths dists distMap foralls observedVals univAssume pathAssumes = let
            (transformedPaths, arrMap) = (if arrayAssert' then extractArrayUpdate distMap else (,Map.empty)) $ map (map (transform (removeReads foralls . negateComparison))) paths
--            transformedPaths = map (map (transform (removeReads foralls . negateComparison))) paths
            processedPaths = preprocessSimple dists transformedPaths
            arrayAsserts = if arrayAssert' then createArrayAsserts distMap arrMap else return []
            (dynProgAsserts,probs) = getProbFormula dynamic' simplify' processedPaths dists distMap
--                                     (pxPaths,pyPaths) = laplaceManualConversion (processedPaths !! 0)
--                                     probsPx = timeItNamed "constructProbs" (constructProbsNoIndep dists distMap pxPaths)
--                                     probsPy = timeItNamed "constructProbs" (constructProbsNoIndep dists distMap pyPaths)
            allPathProbs = (case benchmark' of
                              Montyhall -> mkAdd =<< probs
                              _ -> mergePathsWithProbs probs observedVals pathAssumes)
--                                     allPathProbsPx = timeItNamed "mergePathsWithProbs" (mergePathsWithProbs probsPx expectVals pathAssumes)
--                                     allPathProbsPy = timeItNamed "mergePathsWithProbs" (mergePathsWithProbs probsPy expectVals pathAssumes)
--            in putStrLn (show $ length arrays)
            in timeItNamed "Z3 evaluation" $ askZ3 threads' benchmark' allPathProbs univAssume arrayAsserts dynProgAsserts >>= putStrLn
--            in timeItNamed "Z3 evaluation" $ askZ3 threads' benchmark' allPathProbs univAssume (return []) dynProgAsserts >>= putStrLn
--                                 in timeItNamed "Z3 evaluation" $ (laplaceMechanismEval threads allPathProbsPx allPathProbsPy univAssume) >>= putStrLn

{-
laplaceManualConversion :: [KExpr] -> ([[KExpr]], [[KExpr]])
laplaceManualConversion ((Or _ e1 e2):[]) = ([[e1]],[[e2]])

main' :: Args -> IO ()
main' (Args dir threads benchmark) = do
  (text, winPathsText, readDists) <- getRequiredFiles dir
  case (eitherDecode text, eitherDecode winPathsText) :: (Either String JSONPathList, Either String [WinningPath]) of
    (Left err, _) -> print err
    (_, Left err) -> print err
    (Right (PathList bs), Right wps) -> case readDists of
      Left err -> print err
      Right origDists -> let onlyWinning = filter (filterWinning (checkWinning wps)) bs
                             eitherErrorsPaths = map (map predicate . tail) onlyWinning
                             pathsErrors = lefts (concat eitherErrorsPaths)
                             -- (pxPaths,pyPaths) = laplaceManualConversion (paths !! 0)
                         in if null pathsErrors
                            then let paths = map rights eitherErrorsPaths
                                     dists = collectPSVs origDists paths
                                     distMap = distsToDistMap (trace ("Num PSVs: " ++ show (length dists)) dists)
                                     foralls = collectForallSizes distMap onlyWinning
                                     transformedPaths = map (map (transform (removeReads foralls . negateComparison))) paths
                                     (univAssume, pathAssumes) = collectAssumes foralls distMap onlyWinning
                                     processedPaths = preprocessSimple dists transformedPaths
--                                     probs = timeItNamed "constructProbs" (indepOptimize dists distMap processedPaths $ map (calcIMap distMap) paths)
                                     probs = timeItNamed "constructProbs" (constructProbsNoIndep dists distMap processedPaths)-- (trace (show (processedPaths !! 0)) processedPaths))
                                     -- probsPx = timeItNamed "constructProbs" (constructProbs dists distMap pxPaths)
                                     -- probsPy = timeItNamed "constructProbs" (constructProbs dists distMap pyPaths)
                                     expectVals = getVarVals foralls distMap wps
                                     allPathProbs = timeItNamed "mergePathsWithProbs" (mergePathsWithProbs probs expectVals pathAssumes)
                                 in timeItNamed "Z3 evaluation" $ (askZ3 threads benchmark allPathProbs univAssume) >>= putStrLn
                                     -- allPathProbsPx = timeItNamed "mergePathsWithProbs" (mergePathsWithProbs probsPx expectVals pathAssumes)
                                     -- allPathProbsPy = timeItNamed "mergePathsWithProbs" (mergePathsWithProbs probsPy expectVals pathAssumes)
--                                 in print ((preprocessSimple dists paths) !! 1) 
--                                 in do printZ3AST allPathProbs
--                                             in print concrExprs
--                                 in printTest expectVals
--                                 in print paths -- >> print (encode (distsToSymIntervals remainDists))
--                                 in evalZ3 (floatingPointTest allPathProbs univAssume) >>= putStrLn
                                 -- in evalZ3 (laplaceMechanism allPathProbsPx allPathProbsPy univAssume) >>= putStrLn
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (montyhall allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (quickPartition allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (bloomFilter allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (countMinSketch allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (monotone allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (reservoir allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (schwartzZippel allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (monotone allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (randomizedResponseFairNotEqual allPathProbs univAssume) >>= putStrLn)
--                                 in timeItNamed "Z3 evaluation" (evalZ3 (testOpt allPathProbs) >>= putStrLn)
--                                 in putStrLn "Starting Z3" >> evalZ3 (monotone allPathProbs forallAssumes) >>= putStrLn
--                             in putStrLn "Starting Z3" >> evalZ3 (schwartzZippel allPathProbs forallAssumes) >>= putStrLn
--                                 in print $ (map (calcIMap distMap) paths) !! 0
--                                in exportProbs allPathProbs "probs.txt" >> encodeFile "sym_ints.json" (distsToSymIntervals remainDists)
                            else print pathsErrors
-}
