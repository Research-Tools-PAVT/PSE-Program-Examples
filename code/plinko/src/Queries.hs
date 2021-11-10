module Queries where

import ParseArgs (Benchmark(..))
import Convert
import Syntax

import Z3.Monad

import qualified Data.Map as Map
import qualified Data.Traversable as T

--------------------------------------
exportProbs :: Z3 AST -> FilePath -> IO ()
exportProbs probsAST fpath = do
--  probs <- evalZ3 (astToString =<< ((setASTPrintMode Z3_PRINT_SMTLIB2_COMPLIANT) >> probsAST))concr
  probs <- evalZ3 (astToString =<< probsAST)
  writeFile fpath probs

laplaceMechanism :: Z3 AST -> Z3 AST -> Z3 AST -> Z3 String
laplaceMechanism pxProbs pyProbs assumes = do
  -- Create empty set of parameters
  params <- mkParams
  threads <- mkStringSymbol "threads"
  paramsSetUInt params threads 10
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  
  rawProbsX <- pxProbs
  rawProbsY <- pyProbs

  -- lhs <- mkDiv rawProbsX rawProbsY

  -- _epsilonReal <- mkFpaToReal =<< convertToZ3' Map.empty (FP 32) (ReadLSB (BitVec 32) (NumC 0) (VarC "epsilon_sym"))
  e <- mkRealNum 2.718281
  -- bound <- mkPower e _epsilonReal

  body <- mkAnd =<< T.sequence
    [ assumes,
      -- mkEq rawProbsX sum_probs
      mkLe rawProbsX rawProbsY
      -- mkEq sum_probs rawProbsX
    ]

  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"  
      
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
       Nothing    -> return "Couldn't construct model"
  
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
       Nothing    -> return "Couldn't construct model"

randomizedResponseFairNotEqual :: Z3 AST -> Z3 AST -> Z3 String
randomizedResponseFairNotEqual probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _one_quarter <- mkRealNum (1 / 4::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< (mkEq sum_probs _one_quarter)
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

randomizedResponseFairEqual :: Z3 AST -> Z3 AST -> Z3 String
randomizedResponseFairEqual probs assumes = do
  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _three_quarters <- mkRealNum (3 / 4::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< (mkEq sum_probs _three_quarters)
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"



bloomFilter :: Z3 AST -> Z3 AST -> Z3 String
bloomFilter probs assumes = do
  params <- mkParams
  threads <- mkStringSymbol "threads"
  paramsSetUInt params threads 2
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _bound <- mkRealNum (40 / 100::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkLe sum_probs _bound
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

countMinSketch :: Z3 AST -> Z3 AST -> Z3 String
countMinSketch probs assumes = do
  params <- mkParams
  threads <- mkStringSymbol "threads"
  paramsSetUInt params threads 2
  solverSetParams params


  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _bound <- mkRealNum (25 / 100::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _bound
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"


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
       Nothing    -> return "Couldn't construct model"

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

montyhall :: Word -> Z3 AST -> Z3 AST -> Z3 String
montyhall threads probs assumes = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"
  rawProbs <- probs
  _third <- mkRealNum (1 / 3::Double)

  body <- mkAnd =<< T.sequence
    [
      mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _third
    ]
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

reservoir :: Word -> Z3 AST -> Z3 AST -> Double -> Double -> Z3 String
reservoir threads probs assumes n k = do
  params <- mkParams
  threadsName <- mkStringSymbol "threads"
  paramsSetUInt params threadsName threads
  solverSetParams params

  sum_probs <- mkFreshRealVar "sum_probs"

  rawProbs <- probs
  _bound <- mkRealNum (k / n::Double)
  body <- mkAnd =<< T.sequence
    [ mkEq sum_probs rawProbs,
      assumes,
      mkNot =<< mkEq sum_probs _bound
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

expectedValue :: Word -> Z3 AST -> Z3 AST -> Z3 String
expectedValue threads probs assumes = do
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
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> do curMax <- modelEval model sum_probs True
                        case curMax of
                          Just curMaxAST -> z3Maximize assumes curMaxAST rawProbs >>= astToString
                          Nothing -> return "Error in evaluating model"
       Nothing    -> return "Couldn't construct model"
  where z3Maximize :: Z3 AST -> AST -> AST -> Z3 AST
        z3Maximize assumes curMax toMaximize = do
          newConstr <- mkGt toMaximize curMax
          assert newConstr
          assumes >>= assert
          (_res, newModel) <- solverCheckAndGetModel
          case newModel of
            Just mod -> do newMod <- modelEval mod toMaximize True
                           case newMod of
                             Just newMax -> z3Maximize assumes newMax toMaximize
                             Nothing -> return curMax
            Nothing -> return curMax

monotone :: Word -> Z3 AST -> Z3 AST -> Double -> Z3 String
monotone threads probs assumes n = do
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
  body <- mkAnd =<< T.sequence
    [ 
      mkEq sum_probs rawProbs,
      assumes,
      mkGt sum_probs _1_minus_delta
    ]
  
  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

freivalds :: Word -> Z3 AST -> Z3 AST -> Int -> Z3 String
freivalds threads probs assumes k = do
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
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"

calcProb :: Word -> Z3 AST -> Z3 AST -> Z3 String
calcProb threads probs assumes = do
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
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
       Just model -> showModel model
       Nothing    -> return "Couldn't construct model"


askZ3 :: Word -> Benchmark -> Z3 AST -> Z3 AST -> IO String
askZ3 threads benchmark probs assumes = evalZ3 $ case benchmark of
  Montyhall -> montyhall threads probs assumes
  ReservoirSample n k -> reservoir threads probs assumes n k
  ExpectedValue -> expectedValue threads probs assumes
  Monotone n -> monotone threads probs assumes n
  Freivalds k -> freivalds threads probs assumes k
  CalcProb -> calcProb threads probs assumes
    
  
