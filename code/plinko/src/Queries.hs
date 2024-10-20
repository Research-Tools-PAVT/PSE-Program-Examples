module Queries where

import ParseArgs (Benchmark(..))
import Convert
import Syntax
import Data.Ratio

import Z3.Monad
import Z3.Opts

import qualified Data.HashMap.Lazy as Map
import qualified Data.Traversable as T

--------------------------------------
exportProbs :: Z3 AST -> FilePath -> IO ()
exportProbs probsAST fpath = do
--  probs <- evalZ3 (astToString =<< ((setASTPrintMode Z3_PRINT_SMTLIB2_COMPLIANT) >> probsAST))concr
  probs <- evalZ3 (astToString =<< probsAST)
  writeFile fpath probs


      
floatingPointTest :: Z3 AST -> Z3 AST -> Z3 String
floatingPointTest probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"

  rawProbs <- probs
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes
    ]

  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"
  
schwartzZippel :: Z3 AST -> Z3 AST -> Z3 String
schwartzZippel probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"
  _schwartz <- mkRealNum (3 / 12 :: Double)

  rawProbs <- probs
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkLe sum_probs _schwartz
    ]

  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

randomizedResponseFairNotEqual :: Z3 AST -> Z3 AST -> Z3 String
randomizedResponseFairNotEqual probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _one_quarter <- mkRealNum (1 / 4::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkEq sum_probs _one_quarter
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

randomizedResponseFairEqual :: Z3 AST -> Z3 AST -> Z3 String
randomizedResponseFairEqual probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _three_quarters <- mkRealNum (3 / 4::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkEq sum_probs _three_quarters
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"




z3Script :: Z3 AST -> Z3 String
z3Script probs = do
  sum_probs <- mkFreshRealVar "sum_probs"
  retval_sym <- mkStringSymbol "retval" >>= flip mkBvVar 32

  choice_symbol <- mkStringSymbol "choice_sym"
  choice_sym <- mkBvVar choice_symbol 32

--  car_door_sym <- mkStringSymbol "car_door_sym" >>= flip mkBvVar 32

  door_switch_symbol <- mkStringSymbol "door_switch_sym"
  door_switch_sym <- mkBvVar door_switch_symbol 32

  _0 <- mkBvNum 32 (0::Integer)
  _1 <- mkBvNum 32 (1::Integer)
  _2 <- mkBvNum 32 (2::Integer)
  _3 <- mkBvNum 32 (3::Integer)
  _0int <- mkIntNum (0::Integer)
  _half <- mkRealNum (1 / 2::Double)
  _third <- mkRealNum (1 / 3::Double)
  _two_thirds <- mkRealNum (2 / 3::Double)
  _four_nine <- mkRealNum (4 / 9::Double)
  rawProbs <- probs
  body <- mkAnd =<< T.sequence
    [mkGt rawProbs _four_nine,
    mkEq sum_probs rawProbs
--    , mkEq retval_sym _0
--    , mkEq choice_sym _2
--    , mkEq door_switch_sym _1
--    , mkBvsle _0 door_switch_sym, mkBvsle door_switch_sym _1
--    , mkBvsle _1 choice_sym, mkBvsle choice_sym _3
    ]
  
--  bvIntSort <- mkBvSort 32
--  assert =<< mkExists [] [door_switch_symbol] [bvIntSort] =<< mkForall [] [choice_symbol] [bvIntSort] body
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

printZ3AST :: Z3 AST -> IO ()
printZ3AST ast = do
  str <- evalZ3 (astToString =<< ast)
  putStrLn str

printTest :: Maybe (Z3 [AST]) -> IO ()
printTest (Just expects) = do
  str <- evalZ3 (mapM astToString =<< expects )
  print str
printTest Nothing = putStrLn "It's nothing?"

printZ3ASTs :: Z3 [AST] -> IO ()
printZ3ASTs asts = do
  str <- evalZ3 (mapM astToString =<< asts)
  print str

----------------------------------------------------------
mironov :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Z3 String
mironov threads probs assumes arrayAsserts dynProgAsserts = do
  -- Create empty set of parameters
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  raw_probs <- probs
  sum_probs <- mkFreshRealVar "sum_probs"

  forall <- do symb <- mkStringSymbol "forall_sym"
               sort <- mkBvSort 32
               mkVar symb sort
  _0 <- mkRealNum (0 :: Double)
  _1 <- mkRealNum (1 :: Double)
  lower <- mkBitvector 32 0
  upper <- mkBitvector 32 65535

  body <- mkAnd =<< T.sequence
    [ assumes,
      mkBvule lower forall,
      mkBvule forall upper,
      mkEq sum_probs raw_probs,
      mkLt sum_probs _1
    ]

  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"  
  

laplaceMechanismEval :: Word -> Z3 AST -> Z3 AST -> Z3 AST -> IO String
laplaceMechanismEval threads pxProbs pyProbs assumes =  evalZ3 $ laplaceMechanism threads pxProbs pyProbs assumes

laplaceMechanism :: Word -> Z3 AST -> Z3 AST -> Z3 AST -> Z3 String
laplaceMechanism threads pxProbs pyProbs assumes = do
  -- Create empty set of parameters
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  
  rawProbsX <- pxProbs
  rawProbsY <- pyProbs

  lhs <- mkDiv rawProbsX rawProbsY

  -- _epsilonReal <- mkFpaToReal =<< do symb <- mkStringSymbol "epsilon_sym"
  --                                    sort <- convertBitsizeToFP 32
  --                                    mkVar symb sort
  _e <- mkRealNum (2.718281 :: Double)
  -- bound <- mkPower _e _epsilonReal

  body <- mkAnd =<< T.sequence
    [ assumes,
      mkGt lhs _e
    ]

  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"  

countMinSketch :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Double -> Z3 String
countMinSketch threads probs assumes arrayAsserts dynProgAsserts gamma = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _bound <- mkRealNum gamma
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _bound
    ]
  
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"


bloomFilter :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Double -> Z3 String
bloomFilter threads probs assumes arrayAsserts dynProgAsserts eps = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _bound <- mkRealNum eps
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _bound
    ]
  
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"


montyhall :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Z3 String
montyhall threads probs assumes arrayAsserts dynProgAsserts = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _third <- mkRational (2 % 3)

  body <- mkAnd =<< T.sequence
    [
      mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkEq sum_probs _third
    ]
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

reservoir :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Integer -> Integer -> Z3 String
reservoir threads probs assumes arrayAsserts dynProgAsserts n k = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"

  rawProbs <- probs
  _bound <- mkRational (k % n)
--  _error <- mkRational (0 % 13)
--  upper <- mkAdd [_error,_bound]
--  lower <- mkSub [_bound,_error]
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
--      mkGt sum_probs upper,
--      mkLt sum_probs lower
      mkNot =<< mkEq sum_probs _bound
    ]
  
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

expectedValue :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Z3 String
expectedValue threads probs assumes arrayAsserts dynProgAsserts = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes
    ]

  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  ret <- case mbModel of
    Just model -> do curMax <- modelEval model sum_probs True
                     case curMax of
                       Just curMaxAST -> z3Maximize assumes curMaxAST sum_probs model
                       Nothing -> return "Error in evaluating model"
    Nothing    -> return "Property verified!"
  return "Quicksort number of comparisons verified!"
  where z3Maximize :: Z3 AST -> AST -> AST -> Model -> Z3 String
        z3Maximize assumes curMax toMaximize oldMod = do
          newConstr <- mkGt toMaximize curMax
          assert newConstr
--          assumes >>= assert
          (_res, newModel) <- solverCheckAndGetModel
          case newModel of
            Just mod -> do newMod <- modelEval mod toMaximize True
                           case newMod of
                             Just newMax -> z3Maximize assumes newMax toMaximize mod
                             Nothing -> showModel oldMod
            Nothing -> showModel oldMod

-- expectedValue :: Word -> Z3 AST -> Z3 AST -> Z3 String
-- expectedValue threads probs assumes = do
--   params <- mkParams
--   threadsName <- mkStringSymbol "threads"
--   paramsSetUInt params threadsName threads
--   solverSetParams params

--   sum_probs <- mkFreshRealVar "sum_probs"
--   --upper_bound <- mkRealNum (2 * 5 * log 5)

--   rawProbs <- probs
--   body <- mkAnd =<< T.sequence
--     [ mkEq sum_probs rawProbs,
--       assumes
-- --      mkGt sum_probs upper_bound
--     ]

--   assert body
--   (_res, mbModel) <- solverCheckAndGetModel
--   case mbModel of
--     Just model -> showModel model
--     Nothing    -> return "Property verified!"

monotone :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Double -> Z3 String
monotone threads probs assumes arrayAsserts dynProgAsserts n = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"

  _xReal <- mkInt2Real =<< (flip mkBv2int False =<< convertToZ3' Map.empty (BitVec 64) (VarC (BitVec 64) "x"))
  _N <- mkRealNum (n :: Double)
  _delta <- mkDiv _xReal _N
  _1 <- mkRealNum (1 :: Double)
  _1_minus_delta <- mkSub [_1,_delta]

  rawProbs <- probs
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts
  body <- mkAnd =<< T.sequence
    [ 
      mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _1_minus_delta
    ]
  assert body
  
  --solverToString
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

freivalds :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Int -> Z3 String
freivalds threads probs assumes arrayAsserts dynProgAsserts k = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params
  
  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  bound <- mkRealNum (1 / (2^k)::Double)
  body <- mkAnd =<< T.sequence
    [ 
      mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs bound
    ]
  
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

calcProb :: Word -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> Z3 String
calcProb threads probs assumes arrayAsserts dynProgAsserts = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  body <- mkAnd =<< T.sequence
    [
      mkEq sum_probs rawProbs,
      assumes
    ]
  
  assert body
  mapM_ assert =<< arrayAsserts
  mapM_ assert =<< dynProgAsserts

  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"

check1 :: Word -> Z3 AST -> Z3 AST -> Z3 String
check1 threads probs assumes = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _1 <- mkRealNum (1.5 :: Double)
  body <- mkAnd =<< T.sequence
    [
      mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _1
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Property verified!"  

askZ3 :: Word -> Benchmark -> Z3 AST -> Z3 AST -> Z3 [AST] -> Z3 [AST] -> IO String
askZ3 threads benchmark probs assumes arrayAsserts dynProgAsserts = evalZ3 $ case benchmark of
  Montyhall -> montyhall threads probs assumes arrayAsserts dynProgAsserts
  ReservoirSample n k -> reservoir threads probs assumes arrayAsserts dynProgAsserts n k
  ExpectedValue -> expectedValue threads probs assumes arrayAsserts dynProgAsserts
  Monotone n -> monotone threads probs assumes arrayAsserts dynProgAsserts n
  Freivalds k -> freivalds threads probs assumes arrayAsserts dynProgAsserts k
  BloomFilter eps -> bloomFilter threads probs assumes arrayAsserts dynProgAsserts eps
  CountMinSketch gamma -> countMinSketch threads probs assumes arrayAsserts dynProgAsserts gamma
  Mironov -> mironov threads probs assumes arrayAsserts dynProgAsserts
  CalcProb -> calcProb threads probs assumes arrayAsserts dynProgAsserts
  PrintProb -> astToString =<< probs
  CalcWorstCase -> expectedValue threads probs assumes arrayAsserts dynProgAsserts
