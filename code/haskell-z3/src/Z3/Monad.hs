{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- |
-- Module    : Z3.Monad
-- Copyright : (c) Iago Abal, 2013-2015
--             (c) David Castro, 2013-2015
-- License   : BSD3
-- Maintainer: Iago Abal <mail@iagoabal.eu>,
--             David Castro <david.castro.dcp@gmail.com>
--
-- A simple monadic interface to Z3 API.
--
-- Examples: <https://bitbucket.org/iago/z3-haskell/src/tip/examples/Example/Monad>

module Z3.Monad
  ( -- * Z3 monad
    MonadZ3(..)
  , Z3
  , module Z3.Opts
  , Logic(..)
  , evalZ3
  , evalZ3With
    -- ** Z3 enviroments
  , Z3Env
  , newEnv
  , evalZ3WithEnv

  -- * Types
  , Symbol
  , AST
  , Sort
  , FuncDecl
  , App
  , Pattern
  , Constructor
  , Model
  , Base.Context
  , FuncInterp
  , FuncEntry
  , Params
  , Solver
  , SortKind(..)
  , ASTKind(..)
  -- ** Satisfiability result
  , Result(..)

  -- * Parameters
  , mkParams
  , paramsSetBool
  , paramsSetUInt
  , paramsSetDouble
  , paramsSetSymbol
  , paramsToString

  -- * Symbols
  , mkIntSymbol
  , mkStringSymbol

  -- * Sorts
  , mkUninterpretedSort
  , mkBoolSort
  , mkIntSort
  , mkRealSort
  , mkBvSort
  , mkFiniteDomainSort
  , mkArraySort
  , mkTupleSort
  , mkConstructor
  , mkDatatype
  , mkDatatypes
  , mkSetSort

  -- * Constants and Applications
  , mkFuncDecl
  , mkApp
  , mkConst
  , mkFreshConst
  , mkFreshFuncDecl
  , mkRecFuncDecl
  , addRecDef
  -- ** Helpers
  , mkVar
  , mkBoolVar
  , mkRealVar
  , mkIntVar
  , mkBvVar
  , mkFreshVar
  , mkFreshBoolVar
  , mkFreshRealVar
  , mkFreshIntVar
  , mkFreshBvVar

  -- * Propositional Logic and Equality
  , mkTrue
  , mkFalse
  , mkEq
  , mkNot
  , mkIte
  , mkIff
  , mkImplies
  , mkXor
  , mkAnd
  , mkOr
  , mkDistinct
  , mkDistinct1
  -- ** Helpers
  , mkBool

  -- * Arithmetic: Integers and Reals
  , mkAdd
  , mkMul
  , mkSub
  , mkSub1
  , mkUnaryMinus
  , mkDiv
  , mkMod
  , mkRem
  , mkPower
  , mkLt
  , mkLe
  , mkGt
  , mkGe
  , mkInt2Real
  , mkReal2Int
  , mkIsInt

  -- * Bit-vectors
  , mkBvnot
  , mkBvredand
  , mkBvredor
  , mkBvand
  , mkBvor
  , mkBvxor
  , mkBvnand
  , mkBvnor
  , mkBvxnor
  , mkBvneg
  , mkBvadd
  , mkBvsub
  , mkBvmul
  , mkBvudiv
  , mkBvsdiv
  , mkBvurem
  , mkBvsrem
  , mkBvsmod
  , mkBvult
  , mkBvslt
  , mkBvule
  , mkBvsle
  , mkBvuge
  , mkBvsge
  , mkBvugt
  , mkBvsgt
  , mkConcat
  , mkExtract
  , mkSignExt
  , mkZeroExt
  , mkRepeat
  , mkBvshl
  , mkBvlshr
  , mkBvashr
  , mkRotateLeft
  , mkRotateRight
  , mkExtRotateLeft
  , mkExtRotateRight
  , mkInt2bv
  , mkBv2int
  , mkBvnegNoOverflow
  , mkBvaddNoOverflow
  , mkBvaddNoUnderflow
  , mkBvsubNoOverflow
  , mkBvsubNoUnderflow
  , mkBvmulNoOverflow
  , mkBvmulNoUnderflow
  , mkBvsdivNoOverflow

  -- * Arrays
  , mkSelect
  , mkStore
  , mkConstArray
  , mkMap
  , mkArrayDefault

  -- * Sets
  , mkEmptySet
  , mkFullSet
  , mkSetAdd
  , mkSetDel
  , mkSetUnion
  , mkSetIntersect
  , mkSetDifference
  , mkSetComplement
  , mkSetMember
  , mkSetSubset

  -- * Numerals
  , mkNumeral
  , mkInt
  , mkReal
  , mkUnsignedInt
  , mkInt64
  , mkUnsignedInt64
  -- ** Helpers
  , mkIntegral
  , mkRational
  , mkFixed
  , mkRealNum
  , mkInteger
  , mkIntNum
  , mkBitvector
  , mkBvNum

  -- * Sequences and regular expressions
  , mkSeqSort
  , isSeqSort
  , mkReSort
  , isReSort
  , mkStringSort
  , isStringSort
  , mkString
  , isString
  , getString
  , mkSeqEmpty
  , mkSeqUnit
  , mkSeqConcat
  , mkSeqPrefix
  , mkSeqSuffix
  , mkSeqContains
  , mkSeqExtract
  , mkSeqReplace
  , mkSeqAt
  , mkSeqLength
  , mkSeqIndex
  , mkStrToInt
  , mkIntToStr
  , mkSeqToRe
  , mkSeqInRe
  , mkRePlus
  , mkReStar
  , mkReOption
  , mkReUnion
  , mkReConcat
  , mkReRange
  , mkReLoop
  , mkReIntersect
  , mkReComplement
  , mkReEmpty
  , mkReFull

  -- * Quantifiers
  , mkPattern
  , mkBound
  , mkForall
  , mkForallW
  , mkExists
  , mkExistsW
  , mkForallConst
  , mkForallWConst
  , mkExistsConst
  , mkExistsWConst

  -- * Accessors
  , getSymbolString
  , getSortName
  , getSortId
  , sortToAst
  , isEqSort
  , getSortKind
  , getBvSortSize
  , getTupleSortMkDecl
  , getTupleSortNumFields
  , getTupleSortFieldDecl
  , getDatatypeSortConstructors
  , getDatatypeSortRecognizers
  , getDatatypeSortConstructorAccessors
  , mkAtMost
  , mkAtLeast
  , getDeclName
  , getArity
  , getDomain
  , getRange
  , appToAst
  , getAppDecl
  , getAppNumArgs
  , getAppArg
  , getAppArgs
  , getSort
  , getArraySortDomain
  , getArraySortRange
  , getBoolValue
  , getAstKind
  , isApp
  , toApp
  , getNumeralString
  , getNumerator
  , getDenominator
  , simplify
  , simplifyEx
  , getIndexValue
  , isQuantifierForall
  , isQuantifierExists
  , getQuantifierWeight
  , getQuantifierNumPatterns
  , getQuantifierPatternAST
  , getQuantifierPatterns
  , getQuantifierNumNoPatterns
  , getQuantifierNoPatternAST
  , getQuantifierNoPatterns
  , getQuantifierNumBound
  , getQuantifierBoundName
  , getQuantifierBoundSort
  , getQuantifierBoundVars
  , getQuantifierBody
  -- ** Helpers
  , getBool
  , getInt
  , getReal

  -- * Modifiers
  , substituteVars
  , substitute

  -- * Models
  , modelEval
  , evalArray
  , getConstInterp
  , getFuncInterp
  , hasInterp
  , numConsts
  , numFuncs
  , getConstDecl
  , getFuncDecl
  , getConsts
  , getFuncs
  , isAsArray
  , isEqAST
  , addFuncInterp
  , addConstInterp
  , getAsArrayFuncDecl
  , funcInterpGetNumEntries
  , funcInterpGetEntry
  , funcInterpGetElse
  , funcInterpGetArity
  , funcEntryGetValue
  , funcEntryGetNumArgs
  , funcEntryGetArg
  , modelToString
  , showModel
  -- ** Helpers
  , EvalAst
  , eval
  , evalBool
  , evalInt
  , evalReal
  , evalBv
  , evalT
  , mapEval
  , FuncModel(..)
  , evalFunc

  -- * Tactics
  , mkTactic
  , andThenTactic
  , orElseTactic
  , skipTactic
  , tryForTactic
  , repeatTactic
  , mkQuantifierEliminationTactic
  , mkAndInverterGraphTactic
  , applyTactic
  , applyResultToString
  , getApplyResultNumSubgoals
  , getApplyResultSubgoal
  , getApplyResultSubgoals
  , mkGoal
  , goalAssert
  , getGoalSize
  , getGoalFormula
  , getGoalFormulas
  , goalToString

  -- * String Conversion
  , ASTPrintMode(..)
  , setASTPrintMode
  , astToString
  , patternToString
  , sortToString
  , funcDeclToString
  , benchmarkToSMTLibString

  -- * Parser interface
  , parseSMTLib2String
  , parseSMTLib2File

  -- * Error Handling
  , Base.Z3Error(..)
  , Base.Z3ErrorCode(..)

  -- * Miscellaneous
  , Version(..)
  , getVersion

  -- * Fixedpoint
  , MonadFixedpoint(..)
  , Fixedpoint
  , fixedpointAddRule
  , fixedpointSetParams
  , fixedpointRegisterRelation
  , fixedpointQueryRelations
  , fixedpointGetAnswer
  , fixedpointGetAssertions

  -- * Floating-Point Arithmetic
  , mkFpaRoundingModeSort
  , mkFpaRoundNearestTiesToEven
  , mkFpaRne
  , mkFpaRoundNearestTiesToAway
  , mkFpaRna
  , mkFpaRoundTowardPositive
  , mkFpaRtp
  , mkFpaRoundTowardNegative
  , mkFpaRtn
  , mkFpaRoundTowardZero
  , mkFpaRtz
  , mkFpaSort
  , mkFpaSortHalf
  , mkFpaSort16
  , mkFpaSortSingle
  , mkFpaSort32
  , mkFpaSortDouble
  , mkFpaSort64
  , mkFpaSortQuadruple
  , mkFpaSort128
  , mkFpaNaN
  , mkFpaInf
  , mkFpaZero
  , mkFpaFp
  , mkFpaNumeralFloat
  , mkFpaNumeralDouble
  , mkFpaNumeralInt
  , mkFpaNumeralIntUInt
  , mkFpaNumeralInt64UInt64
  , mkFpaAbs
  , mkFpaNeg
  , mkFpaAdd
  , mkFpaSub
  , mkFpaMul
  , mkFpaDiv
  , mkFpaFma
  , mkFpaSqrt
  , mkFpaRem
  , mkFpaRoundToIntegral
  , mkFpaMin
  , mkFpaMax
  , mkFpaLeq
  , mkFpaLt
  , mkFpaGeq
  , mkFpaGt
  , mkFpaEq
  , mkFpaIsNormal
  , mkFpaIsSubnormal
  , mkFpaIsZero
  , mkFpaIsInfinite
  , mkFpaIsNaN
  , mkFpaIsNegative
  , mkFpaIsPositive
  , mkFpaToFpBv
  , mkFpaToFpFloat
  , mkFpaToFpReal
  , mkFpaToFpSigned
  , mkFpaToFpUnsigned
  , mkFpaToUbv
  , mkFpaToSbv
  , mkFpaToReal

  -- * Z3-specific floating-point extensions
  , fpaGetEbits
  , fpaGetSbits
  , fpaIsNumeralNaN
  , fpaIsNumeralInf
  , fpaIsNumeralZero
  , fpaIsNumeralNormal
  , fpaIsNumeralSubnormal
  , fpaIsNumeralPositive
  , fpaIsNumeralNegative
  , fpaGetNumeralSignBv
  , fpaGetNumeralSignificandBv
  , fpaGetNumeralSignificandString
  , fpaGetNumeralExponentString
  , fpaGetNumeralExponentBv
  , mkFpaToIEEEBv
  , mkFpaToFpIntReal

  -- * Optimization
  , MonadOptimize(..)
  , Optimize
  , optimizeAssert
  , optimizeAssertAndTrack
  , optimizeAssertSoft
  , optimizeMaximize
  , optimizeMinimize
  , optimizePush
  , optimizePop
  , optimizeCheck
  , optimizeGetReasonUnknown
  , optimizeGetModel
  , optimizeGetUnsatCore
  , optimizeSetParams
  , optimizeGetLower
  , optimizeGetUpper
  , optimizeGetUpperAsVector
  , optimizeGetLowerAsVector
  , optimizeToString
  , optimizeFromString
  , optimizeFromFile
  , optimizeGetHelp
  , optimizeGetAssertions
  , optimizeGetObjectives

  -- * Solvers
  , solverGetHelp
  , solverSetParams
  , solverPush
  , solverPop
  , solverReset
  , solverGetNumScopes
  , solverAssertCnstr
  , solverAssertAndTrack
  , solverGetAssertions
  , solverCheck
  , solverCheckAssumptions
  , solverGetModel
  , solverGetProof
  , solverGetUnsatCore
  , solverGetReasonUnknown
  , solverToString
  -- ** Helpers
  , assert
  , check
  , checkAssumptions
  , solverCheckAndGetModel
  , getModel
  , withModel
  , getUnsatCore
  , push
  , pop
  , local
  , reset
  , getNumScopes
  )
  where

import Z3.Opts
import Z3.Base
  ( Symbol
  , AST
  , Sort
  , TupleType
  , FuncDecl
  , App
  , Pattern
  , Constructor
  , Model
  , FuncInterp
  , FuncEntry
  , FuncModel(..)
  , Result(..)
  , Logic(..)
  , ASTPrintMode(..)
  , Version(..)
  , Params
  , Solver
  , Fixedpoint
  , Optimize
  , SortKind(..)
  , ASTKind(..)
  , Tactic
  , ApplyResult
  , Goal
  )
import qualified Z3.Base as Base

import Control.Applicative ( Applicative )
import Data.Fixed ( Fixed, HasResolution )
import Control.Monad.Fail
import Control.Monad.IO.Class ( MonadIO, liftIO )
import Control.Monad.Trans.Class ( lift )
import Control.Monad.Trans.Reader ( ReaderT(..), runReaderT, asks )
import Control.Monad.Trans.State.Lazy as StLazy ( StateT(..) )
import Control.Monad.Trans.State.Strict as StStrict ( StateT(..) )
import Control.Monad.Fix ( MonadFix )
import Data.Int ( Int64 )
import Data.List.NonEmpty (NonEmpty)
import Data.Word ( Word, Word64 )
import Data.Traversable ( Traversable )
import qualified Data.Traversable as T

---------------------------------------------------------------------
-- The Z3 monad-class

class (Applicative m, Monad m, MonadIO m) => MonadZ3 m where
  getSolver  :: m Base.Solver
  getContext :: m Base.Context

instance MonadZ3 m => MonadZ3 (ReaderT r m) where
  getSolver = lift getSolver
  getContext = lift getContext

instance MonadZ3 m => MonadZ3 (StLazy.StateT s m) where
  getSolver = lift getSolver
  getContext = lift getContext

instance MonadZ3 m => MonadZ3 (StStrict.StateT s m) where
  getSolver = lift getSolver
  getContext = lift getContext

-------------------------------------------------
-- Lifting

-- TODO: Rename to liftFun0 for consistency
liftScalar :: MonadZ3 z3 => (Base.Context -> IO b) -> z3 b
liftScalar f = liftIO . f =<< getContext

liftFun1 :: MonadZ3 z3 => (Base.Context -> a -> IO b) -> a -> z3 b
liftFun1 f a = getContext >>= \ctx -> liftIO (f ctx a)

liftFun2 :: MonadZ3 z3 => (Base.Context -> a -> b -> IO c) -> a -> b -> z3 c
liftFun2 f a b = getContext >>= \ctx -> liftIO (f ctx a b)

liftFun3 :: MonadZ3 z3 => (Base.Context -> a -> b -> c -> IO d)
                              -> a -> b -> c -> z3 d
liftFun3 f a b c = getContext >>= \ctx -> liftIO (f ctx a b c)

liftFun4 :: MonadZ3 z3 => (Base.Context -> a -> b -> c -> d -> IO e)
                -> a -> b -> c -> d -> z3 e
liftFun4 f a b c d = getContext >>= \ctx -> liftIO (f ctx a b c d)

liftFun5 :: MonadZ3 z3 =>
              (Base.Context -> a1 -> a2 -> a3 -> a4 -> a5 -> IO b)
                -> a1 -> a2 -> a3 -> a4 -> a5-> z3 b
liftFun5 f x1 x2 x3 x4 x5 =
  getContext >>= \ctx -> liftIO (f ctx x1 x2 x3 x4 x5)

liftFun6 :: MonadZ3 z3 =>
              (Base.Context -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> IO b)
                -> a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> z3 b
liftFun6 f x1 x2 x3 x4 x5 x6 =
  getContext >>= \ctx -> liftIO (f ctx x1 x2 x3 x4 x5 x6)

liftSolver0 :: MonadZ3 z3 =>
       (Base.Context -> Base.Solver -> IO b)
    -> z3 b
liftSolver0 f_s =
  do ctx <- getContext
     liftIO . f_s ctx =<< getSolver

liftSolver1 :: MonadZ3 z3 =>
       (Base.Context -> Base.Solver -> a -> IO b)
    -> a -> z3 b
liftSolver1 f_s a =
  do ctx <- getContext
     liftIO . (\s -> f_s ctx s a) =<< getSolver

liftSolver2 :: MonadZ3 z3 => (Base.Context -> Base.Solver -> a -> b -> IO c)
                             -> a -> b -> z3 c
liftSolver2 f a b = do
  ctx <- getContext
  slv <- getSolver
  liftIO $ f ctx slv a b

liftFixedpoint0 :: MonadFixedpoint z3 =>
       (Base.Context -> Base.Fixedpoint -> IO b)
    -> z3 b
liftFixedpoint0 f_s =
  do ctx <- getContext
     liftIO . f_s ctx =<< getFixedpoint

liftFixedpoint1 :: MonadFixedpoint z3 =>
       (Base.Context -> Base.Fixedpoint -> a -> IO b)
    -> a -> z3 b
liftFixedpoint1 f_s a =
  do ctx <- getContext
     liftIO . (\s -> f_s ctx s a) =<< getFixedpoint

liftFixedpoint2 :: MonadFixedpoint z3 => (Base.Context -> Base.Fixedpoint -> a -> b -> IO c)
                             -> a -> b -> z3 c
liftFixedpoint2 f a b = do
  ctx <- getContext
  slv <- getFixedpoint
  liftIO $ f ctx slv a b

liftOptimize0 :: MonadOptimize z3 =>
       (Base.Context -> Base.Optimize -> IO b)
    -> z3 b
liftOptimize0 f_s =
  do ctx <- getContext
     liftIO . f_s ctx =<< getOptimize

liftOptimize1 :: MonadOptimize z3 =>
       (Base.Context -> Base.Optimize -> a -> IO b)
    -> a -> z3 b
liftOptimize1 f_s a =
  do ctx <- getContext
     liftIO . (\s -> f_s ctx s a) =<< getOptimize

liftOptimize2 :: MonadOptimize z3 => (Base.Context -> Base.Optimize -> a -> b -> IO c)
                             -> a -> b -> z3 c
liftOptimize2 f a b = do
  ctx <- getContext
  slv <- getOptimize
  liftIO $ f ctx slv a b

liftOptimize3 :: MonadOptimize z3 => (Base.Context -> Base.Optimize -> a -> b -> c -> IO d)
                             -> a -> b -> c -> z3 d
liftOptimize3 f a b c = do
  ctx <- getContext
  slv <- getOptimize
  liftIO $ f ctx slv a b c

-------------------------------------------------
-- A simple Z3 monad.

newtype Z3 a = Z3 { _unZ3 :: ReaderT Z3Env IO a }
    deriving (Functor, Applicative, Monad, MonadIO, MonadFix, MonadFail)

-- | Z3 environment.
data Z3Env
  = Z3Env {
      envSolver     :: Base.Solver
    , envContext    :: Base.Context
    , envFixedpoint :: Base.Fixedpoint
    , envOptimize   :: Base.Optimize
    }

instance MonadZ3 Z3 where
  getSolver  = Z3 $ asks envSolver
  getContext = Z3 $ asks envContext

instance MonadFixedpoint Z3 where
  getFixedpoint = Z3 $ asks envFixedpoint

instance MonadOptimize Z3 where
  getOptimize = Z3 $ asks envOptimize

-- | Eval a Z3 script.
evalZ3With :: Maybe Logic -> Opts -> Z3 a -> IO a
evalZ3With mbLogic opts (Z3 s) = do
  env <- newEnv mbLogic opts
  runReaderT s env

-- | Eval a Z3 script with default configuration options.
evalZ3 :: Z3 a -> IO a
evalZ3 = evalZ3With Nothing stdOpts


newEnvWith :: (Base.Config -> IO Base.Context) -> Maybe Logic -> Opts -> IO Z3Env
newEnvWith mkContext mbLogic opts =
  Base.withConfig $ \cfg -> do
    setOpts cfg opts
    ctx <- mkContext cfg
    solver <- maybe (Base.mkSolver ctx) (Base.mkSolverForLogic ctx) mbLogic
    fixedpoint <- Base.mkFixedpoint ctx
    optimize <- Base.mkOptimize ctx
    return $ Z3Env solver ctx fixedpoint optimize

-- | Create a new Z3 environment.
newEnv :: Maybe Logic -> Opts -> IO Z3Env
newEnv = newEnvWith Base.mkContext

-- | Eval a Z3 script with a given environment.
--
-- Environments may facilitate running many queries under the same
-- logical context.
--
-- Note that an environment may change after each query.
-- If you want to preserve the same environment then use 'local', as in
-- @evalZ3WithEnv /env/ (local /query/)@.
evalZ3WithEnv :: Z3 a
              -> Z3Env
              -> IO a
evalZ3WithEnv (Z3 s) = runReaderT s

---------------------------------------------------------------------
-- * Parameters

-- | Create a Z3 (empty) parameter set.
--
-- Starting at Z3 4.0, parameter sets are used to configure many components
-- such as: simplifiers, tactics, solvers, etc.
mkParams :: MonadZ3 z3 => z3 Params
mkParams = liftScalar Base.mkParams

-- | Add a Boolean parameter /k/ with value /v/ to the parameter set /p/.
paramsSetBool :: MonadZ3 z3 => Params -> Symbol -> Bool -> z3 ()
paramsSetBool = liftFun3 Base.paramsSetBool

-- | Add a unsigned parameter /k/ with value /v/ to the parameter set /p/.
paramsSetUInt :: MonadZ3 z3 => Params -> Symbol -> Word -> z3 ()
paramsSetUInt = liftFun3 Base.paramsSetUInt

-- | Add a double parameter /k/ with value /v/ to the parameter set /p/.
paramsSetDouble :: MonadZ3 z3 => Params -> Symbol -> Double -> z3 ()
paramsSetDouble = liftFun3 Base.paramsSetDouble

-- | Add a symbol parameter /k/ with value /v/ to the parameter set /p/.
paramsSetSymbol :: MonadZ3 z3 => Params -> Symbol -> Symbol -> z3 ()
paramsSetSymbol = liftFun3 Base.paramsSetSymbol

-- | Convert a parameter set into a string.
--
-- This function is mainly used for printing the contents of a parameter set.
paramsToString :: MonadZ3 z3 => Params -> z3 String
paramsToString = liftFun1 Base.paramsToString

-- TODO: Z3_params_validate

---------------------------------------------------------------------
-- Symbols

-- | Create a Z3 symbol using an integer.
mkIntSymbol :: (MonadZ3 z3, Integral i) => i -> z3 Symbol
mkIntSymbol = liftFun1 Base.mkIntSymbol

-- | Create a Z3 symbol using a string.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gafebb0d3c212927cf7834c3a20a84ecae>
mkStringSymbol :: MonadZ3 z3 => String -> z3 Symbol
mkStringSymbol = liftFun1 Base.mkStringSymbol

---------------------------------------------------------------------
-- Sorts

-- | Create a free (uninterpreted) type using the given name (symbol).
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga736e88741af1c178cbebf94c49aa42de>
mkUninterpretedSort :: MonadZ3 z3 => Symbol -> z3 Sort
mkUninterpretedSort = liftFun1 Base.mkUninterpretedSort

-- | Create the /boolean/ type.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gacdc73510b69a010b71793d429015f342>
mkBoolSort :: MonadZ3 z3 => z3 Sort
mkBoolSort = liftScalar Base.mkBoolSort

-- | Create the /integer/ type.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga6cd426ab5748653b77d389fd3eac1015>
mkIntSort :: MonadZ3 z3 => z3 Sort
mkIntSort = liftScalar Base.mkIntSort

-- | Create the /real/ type.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga40ef93b9738485caed6dc84631c3c1a0>
mkRealSort :: MonadZ3 z3 => z3 Sort
mkRealSort = liftScalar Base.mkRealSort

-- | Create a bit-vector type of the given size.
--
-- This type can also be seen as a machine integer.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaeed000a1bbb84b6ca6fdaac6cf0c1688>
mkBvSort :: MonadZ3 z3 => Int -> z3 Sort
mkBvSort = liftFun1 Base.mkBvSort

-- | Create a finite-domain type.
mkFiniteDomainSort :: MonadZ3 z3 => Symbol -> Word64 -> z3 Sort
mkFiniteDomainSort = liftFun2 Base.mkFiniteDomainSort

-- | Create an array type
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gafe617994cce1b516f46128e448c84445>
--
mkArraySort :: MonadZ3 z3 => Sort -> Sort -> z3 Sort
mkArraySort = liftFun2 Base.mkArraySort

-- | Create a tuple type
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga7156b9c0a76a28fae46c81f8e3cdf0f1>
mkTupleSort :: MonadZ3 z3
            => Symbol                          -- ^ Name of the sort
            -> [(Symbol, Sort)]                -- ^ Name and sort of each field
            -> z3 (Sort, FuncDecl, [FuncDecl]) -- ^ Resulting sort, and function
                                               -- declarations for the
                                               -- constructor and projections.
mkTupleSort = liftFun2 Base.mkTupleSort

-- | Create a constructor
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaa779e39f7050b9d51857887954b5f9b0>
mkConstructor :: MonadZ3 z3
              => Symbol                       -- ^ Name of the constructor
              -> Symbol                       -- ^ Name of recognizer function
              -> [(Symbol, Maybe Sort, Int)]  -- ^ Name, sort option, and sortRefs
              -> z3 Constructor
mkConstructor = liftFun3 Base.mkConstructor

-- | Create datatype, such as lists, trees, records, enumerations or unions of
--   records. The datatype may be recursive. Return the datatype sort.
--
-- Reference <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gab6809d53327d807da9158abdf75df387>
mkDatatype :: MonadZ3 z3
           => Symbol
           -> [Constructor]
           -> z3 Sort
mkDatatype = liftFun2 Base.mkDatatype

-- | Create mutually recursive datatypes, such as a tree and forest.
--
-- Returns the datatype sorts
mkDatatypes :: MonadZ3 z3
            => [Symbol]
            -> [[Constructor]]
            -> z3 [Sort]
mkDatatypes = liftFun2 Base.mkDatatypes

-- | Create a set type
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga6865879523e7e882d7e50a2d8445ac8b>
--
mkSetSort :: MonadZ3 z3 => Sort -> z3 Sort
mkSetSort = liftFun1 Base.mkSetSort

---------------------------------------------------------------------
-- Constants and Applications

-- | A Z3 function
mkFuncDecl :: MonadZ3 z3 => Symbol -> [Sort] -> Sort -> z3 FuncDecl
mkFuncDecl = liftFun3 Base.mkFuncDecl

-- | Create a constant or function application.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga33a202d86bf628bfab9b6f437536cebe>
mkApp :: MonadZ3 z3 => FuncDecl -> [AST] -> z3 AST
mkApp = liftFun2 Base.mkApp

-- | Declare and create a constant.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga093c9703393f33ae282ec5e8729354ef>
mkConst :: MonadZ3 z3 => Symbol -> Sort -> z3 AST
mkConst = liftFun2 Base.mkConst

-- | Declare and create a constant.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga093c9703393f33ae282ec5e8729354ef>
mkFreshConst :: MonadZ3 z3 => String -> Sort -> z3 AST
mkFreshConst = liftFun2 Base.mkFreshConst

-- | Declare a fresh constant or function.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga1f60c7eb41c5603e55a188a14dc929ec>
mkFreshFuncDecl :: MonadZ3 z3 => String -> [Sort] -> Sort -> z3 FuncDecl
mkFreshFuncDecl = liftFun3 Base.mkFreshFuncDecl

-- | A recursive Z3 function
mkRecFuncDecl :: MonadZ3 z3 => Symbol -> [Sort] -> Sort -> z3 FuncDecl
mkRecFuncDecl = liftFun3 Base.mkRecFuncDecl

-- | Define the body of a recursive Z3 function
addRecDef :: MonadZ3 z3 => FuncDecl -> [AST] -> AST -> z3 ()
addRecDef = liftFun3 Base.addRecDef

-------------------------------------------------
-- ** Helpers

-- | Declare and create a variable (aka /constant/).
--
-- An alias for 'mkConst'.
mkVar :: MonadZ3 z3 => Symbol -> Sort -> z3 AST
mkVar = liftFun2 Base.mkVar

-- | Declarate and create a variable of sort /bool/.
--
-- See 'mkVar'.
mkBoolVar :: MonadZ3 z3 => Symbol -> z3 AST
mkBoolVar = liftFun1 Base.mkBoolVar

-- | Declarate and create a variable of sort /real/.
--
-- See 'mkVar'.
mkRealVar :: MonadZ3 z3 => Symbol -> z3 AST
mkRealVar = liftFun1 Base.mkRealVar

-- | Declarate and create a variable of sort /int/.
--
-- See 'mkVar'.
mkIntVar :: MonadZ3 z3 => Symbol -> z3 AST
mkIntVar = liftFun1 Base.mkIntVar

-- | Declarate and create a variable of sort /bit-vector/.
--
-- See 'mkVar'.
mkBvVar :: MonadZ3 z3 => Symbol
                   -> Int     -- ^ bit-width
                   -> z3 AST
mkBvVar = liftFun2 Base.mkBvVar

-- | Declare and create a /fresh/ variable (aka /constant/).
--
-- An alias for 'mkFreshConst'.
mkFreshVar :: MonadZ3 z3 => String -> Sort -> z3 AST
mkFreshVar = liftFun2 Base.mkFreshConst

-- | Declarate and create a /fresh/ variable of sort /bool/.
--
-- See 'mkFreshVar'.
mkFreshBoolVar :: MonadZ3 z3 => String -> z3 AST
mkFreshBoolVar = liftFun1 Base.mkFreshBoolVar

-- | Declarate and create a /fresh/ variable of sort /real/.
--
-- See 'mkFreshVar'.
mkFreshRealVar :: MonadZ3 z3 => String -> z3 AST
mkFreshRealVar = liftFun1 Base.mkFreshRealVar

-- | Declarate and create a /fresh/ variable of sort /int/.
--
-- See 'mkFreshVar'.
mkFreshIntVar :: MonadZ3 z3 => String -> z3 AST
mkFreshIntVar = liftFun1 Base.mkFreshIntVar

-- | Declarate and create a /fresh/ variable of sort /bit-vector/.
--
-- See 'mkFreshVar'.
mkFreshBvVar :: MonadZ3 z3 => String
                        -> Int     -- ^ bit-width
                        -> z3 AST
mkFreshBvVar = liftFun2 Base.mkFreshBvVar

---------------------------------------------------------------------
-- Propositional Logic and Equality

-- | Create an AST node representing /true/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gae898e7380409bbc57b56cc5205ef1db7>
mkTrue :: MonadZ3 z3 => z3 AST
mkTrue = liftScalar Base.mkTrue

-- | Create an AST node representing /false/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga5952ac17671117a02001fed6575c778d>
mkFalse :: MonadZ3 z3 => z3 AST
mkFalse = liftScalar Base.mkFalse

-- | Create an AST node representing /l = r/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga95a19ce675b70e22bb0401f7137af37c>
mkEq :: MonadZ3 z3 => AST -> AST -> z3 AST
mkEq = liftFun2 Base.mkEq

-- | The distinct construct is used for declaring the arguments pairwise
-- distinct.
--
-- Requires a non-empty list.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaa076d3a668e0ec97d61744403153ecf7>
mkDistinct :: MonadZ3 z3 => [AST] -> z3 AST
mkDistinct = liftFun1 Base.mkDistinct

-- | Same as 'mkDistinct' but type-safe.
mkDistinct1 :: MonadZ3 z3 => NonEmpty AST -> z3 AST
mkDistinct1 = liftFun1 Base.mkDistinct1

-- | Create an AST node representing /not(a)/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga3329538091996eb7b3dc677760a61072>
mkNot :: MonadZ3 z3 => AST -> z3 AST
mkNot = liftFun1 Base.mkNot

-- | Create an AST node representing an if-then-else: /ite(t1, t2, t3)/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga94417eed5c36e1ad48bcfc8ad6e83547>
mkIte :: MonadZ3 z3 => AST -> AST -> AST -> z3 AST
mkIte = liftFun3 Base.mkIte

-- | Create an AST node representing /t1 iff t2/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga930a8e844d345fbebc498ac43a696042>
mkIff :: MonadZ3 z3 => AST -> AST -> z3 AST
mkIff = liftFun2 Base.mkIff

-- | Create an AST node representing /t1 implies t2/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac829c0e25bbbd30343bf073f7b524517>
mkImplies :: MonadZ3 z3 => AST -> AST -> z3 AST
mkImplies = liftFun2 Base.mkImplies

-- | Create an AST node representing /t1 xor t2/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gacc6d1b848032dec0c4617b594d4229ec>
mkXor :: MonadZ3 z3 => AST -> AST -> z3 AST
mkXor = liftFun2 Base.mkXor

-- | Create an AST node representing args[0] and ... and args[num_args-1].
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gacde98ce4a8ed1dde50b9669db4838c61>
mkAnd :: MonadZ3 z3 => [AST] -> z3 AST
mkAnd = liftFun1 Base.mkAnd

-- | Create an AST node representing args[0] or ... or args[num_args-1].
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga00866d16331d505620a6c515302021f9>
mkOr :: MonadZ3 z3 => [AST] -> z3 AST
mkOr = liftFun1 Base.mkOr

-------------------------------------------------
-- ** Helpers

-- | Create an AST node representing the given boolean.
mkBool :: MonadZ3 z3 => Bool -> z3 AST
mkBool = liftFun1 Base.mkBool

---------------------------------------------------------------------
-- Arithmetic: Integers and Reals

-- | Create an AST node representing args[0] + ... + args[num_args-1].
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4e4ac0a4e53eee0b4b0ef159ed7d0cd5>
mkAdd :: MonadZ3 z3 => [AST] -> z3 AST
mkAdd = liftFun1 Base.mkAdd

-- | Create an AST node representing args[0] * ... * args[num_args-1].
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gab9affbf8401a18eea474b59ad4adc890>
mkMul :: MonadZ3 z3 => [AST] -> z3 AST
mkMul = liftFun1 Base.mkMul

-- | Create an AST node representing args[0] - ... - args[num_args - 1].
--
-- Requires a non-empty list.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4f5fea9b683f9e674fd8f14d676cc9a9>
mkSub :: MonadZ3 z3 => [AST] -> z3 AST
mkSub = liftFun1 Base.mkSub

-- | Same as 'mkSub' but type-safe.
mkSub1 :: MonadZ3 z3 => NonEmpty AST -> z3 AST
mkSub1 = liftFun1 Base.mkSub1

-- | Create an AST node representing -arg.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gadcd2929ad732937e25f34277ce4988ea>
mkUnaryMinus :: MonadZ3 z3 => AST -> z3 AST
mkUnaryMinus = liftFun1 Base.mkUnaryMinus

-- | Create an AST node representing arg1 div arg2.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga1ac60ee8307af8d0b900375914194ff3>
mkDiv :: MonadZ3 z3 => AST -> AST -> z3 AST
mkDiv = liftFun2 Base.mkDiv

-- | Create an AST node representing arg1 mod arg2.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga8e350ac77e6b8fe805f57efe196e7713>
mkMod :: MonadZ3 z3 => AST -> AST -> z3 AST
mkMod = liftFun2 Base.mkMod

-- | Create an AST node representing arg1 rem arg2.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga2fcdb17f9039bbdaddf8a30d037bd9ff>
mkRem :: MonadZ3 z3 => AST -> AST -> z3 AST
mkRem = liftFun2 Base.mkRem

-- | Create an AST node representing arg1 ^ arg2.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga8414506c805caa171f0c1fe29f9f9612>
mkPower :: MonadZ3 z3 => AST -> AST -> z3 AST
mkPower = liftFun2 Base.mkPower

-- | Create less than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga58a3dc67c5de52cf599c346803ba1534>
mkLt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkLt = liftFun2 Base.mkLt

-- | Create less than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaa9a33d11096841f4e8c407f1578bc0bf>
mkLe :: MonadZ3 z3 => AST -> AST -> z3 AST
mkLe = liftFun2 Base.mkLe

-- | Create greater than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga46167b86067586bb742c0557d7babfd3>
mkGt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkGt = liftFun2 Base.mkGt

-- | Create greater than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gad9245cbadb80b192323d01a8360fb942>
mkGe :: MonadZ3 z3 => AST -> AST -> z3 AST
mkGe = liftFun2 Base.mkGe

-- | Coerce an integer to a real.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga7130641e614c7ebafd28ae16a7681a21>
mkInt2Real :: MonadZ3 z3 => AST -> z3 AST
mkInt2Real = liftFun1 Base.mkInt2Real

-- | Coerce a real to an integer.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga759b6563ba1204aae55289009a3fdc6d>
mkReal2Int :: MonadZ3 z3 => AST -> z3 AST
mkReal2Int = liftFun1 Base.mkReal2Int

-- | Check if a real number is an integer.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaac2ad0fb04e4900fdb4add438d137ad3>
mkIsInt :: MonadZ3 z3 => AST -> z3 AST
mkIsInt = liftFun1 Base.mkIsInt

---------------------------------------------------------------------
-- Bit-vectors

-- | Bitwise negation.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga36cf75c92c54c1ca633a230344f23080>
mkBvnot :: MonadZ3 z3 => AST -> z3 AST
mkBvnot = liftFun1 Base.mkBvnot

-- | Take conjunction of bits in vector, return vector of length 1.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaccc04f2b58903279b1b3be589b00a7d8>
mkBvredand :: MonadZ3 z3 => AST -> z3 AST
mkBvredand = liftFun1 Base.mkBvredand

-- | Take disjunction of bits in vector, return vector of length 1.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gafd18e127c0586abf47ad9cd96895f7d2>
mkBvredor :: MonadZ3 z3 => AST -> z3 AST
mkBvredor = liftFun1 Base.mkBvredor

-- | Bitwise and.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gab96e0ea55334cbcd5a0e79323b57615d>
mkBvand :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvand  = liftFun2 Base.mkBvand

-- | Bitwise or.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga77a6ae233fb3371d187c6d559b2843f5>
mkBvor :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvor = liftFun2 Base.mkBvor

-- | Bitwise exclusive-or.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga0a3821ea00b1c762205f73e4bc29e7d8>
mkBvxor :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvxor = liftFun2 Base.mkBvxor

-- | Bitwise nand.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga96dc37d36efd658fff5b2b4df49b0e61>
mkBvnand :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvnand = liftFun2 Base.mkBvnand

-- | Bitwise nor.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gabf15059e9e8a2eafe4929fdfd259aadb>
mkBvnor :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvnor = liftFun2 Base.mkBvnor

-- | Bitwise xnor.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga784f5ca36a4b03b93c67242cc94b21d6>
mkBvxnor :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvxnor = liftFun2 Base.mkBvxnor

-- | Standard two's complement unary minus.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga0c78be00c03eda4ed6a983224ed5c7b7
mkBvneg :: MonadZ3 z3 => AST -> z3 AST
mkBvneg = liftFun1 Base.mkBvneg

-- | Standard two's complement addition.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga819814e33573f3f9948b32fdc5311158>
mkBvadd :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvadd = liftFun2 Base.mkBvadd

-- | Standard two's complement subtraction.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga688c9aa1347888c7a51be4e46c19178e>
mkBvsub :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsub = liftFun2 Base.mkBvsub

-- | Standard two's complement multiplication.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga6abd3dde2a1ceff1704cf7221a72258c>
mkBvmul :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvmul = liftFun2 Base.mkBvmul

-- | Unsigned division.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga56ce0cd61666c6f8cf5777286f590544>
mkBvudiv :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvudiv = liftFun2 Base.mkBvudiv

-- | Two's complement signed division.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gad240fedb2fda1c1005b8e9d3c7f3d5a0>
mkBvsdiv :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsdiv = liftFun2 Base.mkBvsdiv

-- | Unsigned remainder.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga5df4298ec835e43ddc9e3e0bae690c8d>
mkBvurem :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvurem = liftFun2 Base.mkBvurem

-- | Two's complement signed remainder (sign follows dividend).
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga46c18a3042fca174fe659d3185693db1>
mkBvsrem :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsrem = liftFun2 Base.mkBvsrem

-- | Two's complement signed remainder (sign follows divisor).
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga95dac8e6eecb50f63cb82038560e0879>
mkBvsmod :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsmod = liftFun2 Base.mkBvsmod

-- | Unsigned less than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga5774b22e93abcaf9b594672af6c7c3c4>
mkBvult :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvult = liftFun2 Base.mkBvult

-- | Two's complement signed less than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga8ce08af4ed1fbdf08d4d6e63d171663a>
mkBvslt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvslt = liftFun2 Base.mkBvslt

-- | Unsigned less than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gab738b89de0410e70c089d3ac9e696e87>
mkBvule :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvule = liftFun2 Base.mkBvule

-- | Two's complement signed less than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gab7c026feb93e7d2eab180e96f1e6255d>
mkBvsle :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsle = liftFun2 Base.mkBvsle

-- | Unsigned greater than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gade58fbfcf61b67bf8c4a441490d3c4df>
mkBvuge :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvuge = liftFun2 Base.mkBvuge

-- | Two's complement signed greater than or equal to.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaeec3414c0e8a90a6aa5a23af36bf6dc5>
mkBvsge :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsge = liftFun2 Base.mkBvsge

-- | Unsigned greater than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga063ab9f16246c99e5c1c893613927ee3>
mkBvugt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvugt = liftFun2 Base.mkBvugt

-- | Two's complement signed greater than.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4e93a985aa2a7812c7c11a2c65d7c5f0>
mkBvsgt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsgt = liftFun2 Base.mkBvsgt

-- | Concatenate the given bit-vectors.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gae774128fa5e9ff7458a36bd10e6ca0fa>
mkConcat :: MonadZ3 z3 => AST -> AST -> z3 AST
mkConcat = liftFun2 Base.mkConcat

-- | Extract the bits high down to low from a bitvector of size m to yield a new
-- bitvector of size /n/, where /n = high - low + 1/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga32d2fe7563f3e6b114c1b97b205d4317>
mkExtract :: MonadZ3 z3 => Int -> Int -> AST -> z3 AST
mkExtract = liftFun3 Base.mkExtract

-- | Sign-extend of the given bit-vector to the (signed) equivalent bitvector
-- of size /m+i/, where /m/ is the size of the given bit-vector.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gad29099270b36d0680bb54b560353c10e>
mkSignExt :: MonadZ3 z3 => Int -> AST -> z3 AST
mkSignExt = liftFun2 Base.mkSignExt

-- | Extend the given bit-vector with zeros to the (unsigned) equivalent
-- bitvector of size /m+i/, where /m/ is the size of the given bit-vector.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac9322fae11365a78640baf9078c428b3>
mkZeroExt :: MonadZ3 z3 => Int -> AST -> z3 AST
mkZeroExt = liftFun2 Base.mkZeroExt

-- | Repeat the given bit-vector up length /i/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga03e81721502ea225c264d1f556c9119d>
mkRepeat :: MonadZ3 z3 => Int -> AST -> z3 AST
mkRepeat = liftFun2 Base.mkRepeat

-- | Shift left.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac8d5e776c786c1172fa0d7dfede454e1>
mkBvshl :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvshl = liftFun2 Base.mkBvshl

-- | Logical shift right.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac59645a6edadad79a201f417e4e0c512>
mkBvlshr :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvlshr = liftFun2 Base.mkBvlshr

-- | Arithmetic shift right.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga674b580ad605ba1c2c9f9d3748be87c4>
mkBvashr :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvashr = liftFun2 Base.mkBvashr

-- | Rotate bits of /t1/ to the left /i/ times.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4932b7d08fea079dd903cd857a52dcda>
mkRotateLeft :: MonadZ3 z3 => Int -> AST -> z3 AST
mkRotateLeft = liftFun2 Base.mkRotateLeft

-- | Rotate bits of /t1/ to the right /i/ times.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga3b94e1bf87ecd1a1858af8ebc1da4a1c>
mkRotateRight :: MonadZ3 z3 => Int -> AST -> z3 AST
mkRotateRight = liftFun2 Base.mkRotateRight

-- | Rotate bits of /t1/ to the left /t2/ times.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaf46f1cb80e5a56044591a76e7c89e5e7>
mkExtRotateLeft :: MonadZ3 z3 => AST -> AST -> z3 AST
mkExtRotateLeft = liftFun2 Base.mkExtRotateLeft

-- | Rotate bits of /t1/ to the right /t2/ times.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gabb227526c592b523879083f12aab281f>
mkExtRotateRight :: MonadZ3 z3 => AST -> AST -> z3 AST
mkExtRotateRight = liftFun2 Base.mkExtRotateRight

-- | Create an /n/ bit bit-vector from the integer argument /t1/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga35f89eb05df43fbd9cce7200cc1f30b5>
mkInt2bv :: MonadZ3 z3 => Int -> AST -> z3 AST
mkInt2bv = liftFun2 Base.mkInt2bv

-- | Create an integer from the bit-vector argument /t1/. If /is_signed/ is false,
-- then the bit-vector /t1/ is treated as unsigned. So the result is non-negative
-- and in the range [0..2^/N/-1], where /N/ are the number of bits in /t1/.
-- If /is_signed/ is true, /t1/ is treated as a signed bit-vector.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac87b227dc3821d57258d7f53a28323d4>
mkBv2int :: MonadZ3 z3 => AST -> Bool -> z3 AST
mkBv2int = liftFun2 Base.mkBv2int

-- | Create a predicate that checks that the bit-wise addition of /t1/ and /t2/
-- does not overflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga88f6b5ec876f05e0d7ba51e96c4b077f>
mkBvaddNoOverflow :: MonadZ3 z3 => AST -> AST -> Bool -> z3 AST
mkBvaddNoOverflow = liftFun3 Base.mkBvaddNoOverflow

-- | Create a predicate that checks that the bit-wise signed addition of /t1/
-- and /t2/ does not underflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga1e2b1927cf4e50000c1600d47a152947>
mkBvaddNoUnderflow :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvaddNoUnderflow = liftFun2 Base.mkBvaddNoUnderflow

-- | Create a predicate that checks that the bit-wise signed subtraction of /t1/
-- and /t2/ does not overflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga785f8127b87e0b42130e6d8f52167d7c>
mkBvsubNoOverflow :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsubNoOverflow = liftFun2 Base.mkBvsubNoOverflow

-- | Create a predicate that checks that the bit-wise subtraction of /t1/ and
-- /t2/ does not underflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga6480850f9fa01e14aea936c88ff184c4>
mkBvsubNoUnderflow :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsubNoUnderflow = liftFun2 Base.mkBvsubNoUnderflow

-- | Create a predicate that checks that the bit-wise signed division of /t1/
-- and /t2/ does not overflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaa17e7b2c33dfe2abbd74d390927ae83e>
mkBvsdivNoOverflow :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvsdivNoOverflow = liftFun2 Base.mkBvsdivNoOverflow

-- | Check that bit-wise negation does not overflow when /t1/ is interpreted as
-- a signed bit-vector.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gae9c5d72605ddcd0e76657341eaccb6c7>
mkBvnegNoOverflow :: MonadZ3 z3 => AST -> z3 AST
mkBvnegNoOverflow = liftFun1 Base.mkBvnegNoOverflow

-- | Create a predicate that checks that the bit-wise multiplication of /t1/ and
-- /t2/ does not overflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga86f4415719d295a2f6845c70b3aaa1df>
mkBvmulNoOverflow :: MonadZ3 z3 => AST -> AST -> Bool -> z3 AST
mkBvmulNoOverflow = liftFun3 Base.mkBvmulNoOverflow

-- | Create a predicate that checks that the bit-wise signed multiplication of
-- /t1/ and /t2/ does not underflow.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga501ccc01d737aad3ede5699741717fda>
mkBvmulNoUnderflow :: MonadZ3 z3 => AST -> AST -> z3 AST
mkBvmulNoUnderflow = liftFun2 Base.mkBvmulNoUnderflow

---------------------------------------------------------------------
-- Arrays

-- | Array read. The argument a is the array and i is the index of the array
-- that gets read.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga38f423f3683379e7f597a7fe59eccb67>
mkSelect :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSelect = liftFun2 Base.mkSelect

-- | Array update.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gae305a4f54b4a64f7e5973ae6ccb13593>
mkStore :: MonadZ3 z3 => AST -> AST -> AST -> z3 AST
mkStore = liftFun3 Base.mkStore

-- | Create the constant array.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga84ea6f0c32b99c70033feaa8f00e8f2d>
mkConstArray :: MonadZ3 z3 => Sort -> AST -> z3 AST
mkConstArray = liftFun2 Base.mkConstArray

-- | map f on the the argument arrays.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga9150242d9430a8c3d55d2ca3b9a4362d>
mkMap :: MonadZ3 z3 => FuncDecl -> [AST] -> z3 AST
mkMap = liftFun2 Base.mkMap

-- | Access the array default value. Produces the default range value, for
-- arrays that can be represented as finite maps with a default range value.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga78e89cca82f0ab4d5f4e662e5e5fba7d>
mkArrayDefault :: MonadZ3 z3 => AST -> z3 AST
mkArrayDefault = liftFun1 Base.mkArrayDefault

---------------------------------------------------------------------
-- Sets

-- | Create the empty set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga358b6b80509a567148f1c0ca9252118c>
mkEmptySet :: MonadZ3 z3 => Sort -> z3 AST
mkEmptySet = liftFun1 Base.mkEmptySet

-- | Create the full set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga5e92662c657374f7332aa32ce4503dd2>
mkFullSet :: MonadZ3 z3 => Sort -> z3 AST
mkFullSet = liftFun1 Base.mkFullSet

-- | Add an element to a set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga856c3d0e28ce720f53912c2bbdd76175>
mkSetAdd :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSetAdd = liftFun2 Base.mkSetAdd

-- | Remove an element from a set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga80e883f39dd3b88f9d0745c8a5b91d1d>
mkSetDel :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSetDel = liftFun2 Base.mkSetDel

-- | Take the union of a list of sets.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4050162a13d539b8913200963bb4743c>
mkSetUnion :: MonadZ3 z3 => [AST] -> z3 AST
mkSetUnion = liftFun1 Base.mkSetUnion

-- | Take the intersection of a list of sets.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga8a8abff0ebe6aeeaa6c919eaa013049d>
mkSetIntersect :: MonadZ3 z3 => [AST] -> z3 AST
mkSetIntersect = liftFun1 Base.mkSetIntersect

-- | Take the set difference between two sets.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gabb49c62f70b8198362e1a29ba6d8bde1>
mkSetDifference :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSetDifference = liftFun2 Base.mkSetDifference

-- | Take the complement of a set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga5c57143c9229cdf730c5103ff696590f>
mkSetComplement :: MonadZ3 z3 => AST -> z3 AST
mkSetComplement = liftFun1 Base.mkSetComplement

-- | Check for set membership.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac6e516f3dce0bdd41095c6d6daf56063>
mkSetMember :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSetMember = liftFun2 Base.mkSetMember

-- | Check if the first set is a subset of the second set.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga139c5803af0e86464adc7cedc53e7f3a>
mkSetSubset :: MonadZ3 z3 => AST -> AST -> z3 AST
mkSetSubset = liftFun2 Base.mkSetSubset

---------------------------------------------------------------------
-- * Numerals

-- | Create a numeral of a given sort.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gac8aca397e32ca33618d8024bff32948c>
mkNumeral :: MonadZ3 z3 => String -> Sort -> z3 AST
mkNumeral = liftFun2 Base.mkNumeral

-- | Create a numeral of sort /real/.
mkReal :: MonadZ3 z3 => Int -> Int -> z3 AST
mkReal = liftFun2 Base.mkReal

-- | Create a numeral of an int, bit-vector, or finite-domain sort.
--
-- This function can be use to create numerals that fit in a
-- /machine integer/.
-- It is slightly faster than 'mkNumeral' since it is not necessary
-- to parse a string.
mkInt :: MonadZ3 z3 => Int -> Sort -> z3 AST
mkInt = liftFun2 Base.mkInt

-- | Create a numeral of an int, bit-vector, or finite-domain sort.
--
-- This function can be use to create numerals that fit in a
-- /machine unsigned integer/.
-- It is slightly faster than 'mkNumeral' since it is not necessary
-- to parse a string.
mkUnsignedInt :: MonadZ3 z3 => Word -> Sort -> z3 AST
mkUnsignedInt = liftFun2 Base.mkUnsignedInt

-- | Create a numeral of an int, bit-vector, or finite-domain sort.
--
-- This function can be use to create numerals that fit in a
-- /machine 64-bit integer/.
-- It is slightly faster than 'mkNumeral' since it is not necessary
-- to parse a string.
mkInt64 :: MonadZ3 z3 => Int64 -> Sort -> z3 AST
mkInt64 = liftFun2 Base.mkInt64

-- | Create a numeral of an int, bit-vector, or finite-domain sort.
--
-- This function can be use to create numerals that fit in a
-- /machine unsigned 64-bit integer/.
-- It is slightly faster than 'mkNumeral' since it is not necessary
-- to parse a string.
mkUnsignedInt64 :: MonadZ3 z3 => Word64 -> Sort -> z3 AST
mkUnsignedInt64 = liftFun2 Base.mkUnsignedInt64

-------------------------------------------------
-- ** Helpers

-- | Create a numeral of an int, bit-vector, or finite-domain sort.
mkIntegral :: (MonadZ3 z3, Integral a) => a -> Sort -> z3 AST
mkIntegral = liftFun2 Base.mkIntegral

-- | Create a numeral of sort /real/ from a 'Rational'.
mkRational :: MonadZ3 z3 => Rational -> z3 AST
mkRational = liftFun1 Base.mkRational

-- | Create a numeral of sort /real/ from a 'Fixed'.
mkFixed :: (MonadZ3 z3, HasResolution a) => Fixed a -> z3 AST
mkFixed = liftFun1 Base.mkFixed

-- | Create a numeral of sort /real/ from a 'Real'.
mkRealNum :: (MonadZ3 z3, Real r) => r -> z3 AST
mkRealNum = liftFun1 Base.mkRealNum

-- | Create a numeral of sort /int/ from an 'Integer'.
mkInteger :: MonadZ3 z3 => Integer -> z3 AST
mkInteger = liftFun1 Base.mkInteger

-- | Create a numeral of sort /int/ from an 'Integral'.
mkIntNum :: (MonadZ3 z3, Integral a) => a -> z3 AST
mkIntNum = liftFun1 Base.mkIntNum

-- | Create a numeral of sort /Bit-vector/ from an 'Integer'.
mkBitvector :: MonadZ3 z3 => Int      -- ^ bit-width
                          -> Integer  -- ^ integer value
                          -> z3 AST
mkBitvector = liftFun2 Base.mkBitvector

-- | Create a numeral of sort /Bit-vector/ from an 'Integral'.
mkBvNum :: (MonadZ3 z3, Integral i) => Int    -- ^ bit-width
                                    -> i      -- ^ integer value
                                    -> z3 AST
mkBvNum = liftFun2 Base.mkBvNum

---------------------------------------------------------------------
-- Sequences and regular expressions

-- | Create a sequence sort out of the sort for the elements.
mkSeqSort :: MonadZ3 z3 => Sort -> z3 Sort
mkSeqSort = liftFun1 Base.mkSeqSort

-- | Check if s is a sequence sort.
isSeqSort :: MonadZ3 z3 => Sort -> z3 Bool
isSeqSort = liftFun1 Base.isSeqSort

-- | Create a regular expression sort out of a sequence sort.
mkReSort :: MonadZ3 z3 => Sort -> z3 Sort
mkReSort = liftFun1 Base.mkReSort

-- | Check if s is a regular expression sort.
isReSort :: MonadZ3 z3 => Sort -> z3 Bool
isReSort = liftFun1 Base.isReSort

-- | Create a sort for 8 bit strings. This function creates a sort for ASCII
-- strings. Each character is 8 bits.
mkStringSort :: MonadZ3 z3 => z3 Sort
mkStringSort = liftScalar Base.mkStringSort

-- | Check if s is a string sort.
isStringSort :: MonadZ3 z3 => Sort -> z3 Bool
isStringSort = liftFun1 Base.isStringSort

-- | Create a string constant out of the string that is passed in.
mkString :: MonadZ3 z3 => String -> z3 AST
mkString = liftFun1 Base.mkString

-- | Determine if s is a string constant.
isString :: MonadZ3 z3 => AST -> z3 Bool
isString = liftFun1 Base.isString

-- | Retrieve the string constant stored in s.
getString :: MonadZ3 z3 => AST -> z3 String
getString = liftFun1 Base.getString

-- | Create an empty sequence of the sequence sort seq.
mkSeqEmpty :: MonadZ3 z3 => Sort -> z3 AST
mkSeqEmpty = liftFun1 Base.mkSeqEmpty

-- | Create a unit sequence of a.
mkSeqUnit :: MonadZ3 z3 => AST -> z3 AST
mkSeqUnit = liftFun1 Base.mkSeqUnit

-- | Concatenate sequences.
mkSeqConcat :: MonadZ3 z3 => [AST] -> z3 AST
mkSeqConcat = liftFun1 Base.mkSeqConcat

-- | Check if prefix is a prefix of s.
mkSeqPrefix :: MonadZ3 z3
            => AST -- ^ prefix
            -> AST -- ^ s
            -> z3 AST
mkSeqPrefix = liftFun2 Base.mkSeqPrefix

-- | Check if suffix is a suffix of s.
mkSeqSuffix :: MonadZ3 z3
            => AST -- ^ suffix
            -> AST -- ^ s
            -> z3 AST
mkSeqSuffix = liftFun2 Base.mkSeqSuffix

-- | Check if container contains containee.
mkSeqContains :: MonadZ3 z3
              => AST -- ^ container
              -> AST -- ^ containee
              -> z3 AST
mkSeqContains = liftFun2 Base.mkSeqContains

-- | Extract subsequence starting at offset of length.
mkSeqExtract :: MonadZ3 z3
             => AST -- ^ s
             -> AST -- ^ offset
             -> AST -- ^ length
             -> z3 AST
mkSeqExtract = liftFun3 Base.mkSeqExtract

-- | Replace the first occurrence of src with dst in s.
mkSeqReplace :: MonadZ3 z3
             => AST -- ^ s
             -> AST -- ^ src
             -> AST -- ^ dst
             -> z3 AST
mkSeqReplace = liftFun3 Base.mkSeqReplace

-- | Retrieve from s the unit sequence positioned at position index.
mkSeqAt :: MonadZ3 z3
        => AST -- ^ s
        -> AST -- ^ index
        -> z3 AST
mkSeqAt = liftFun2 Base.mkSeqAt

-- | Return the length of the sequence s.
mkSeqLength :: MonadZ3 z3 => AST -> z3 AST
mkSeqLength = liftFun1 Base.mkSeqLength

-- | Return index of first occurrence of substr in s starting from offset
-- offset. If s does not contain substr, then the value is -1, if offset is the
-- length of s, then the value is -1 as well. The function is under-specified if
-- offset is negative or larger than the length of s.
mkSeqIndex :: MonadZ3 z3
           => AST -- ^ s
           -> AST -- ^ substr
           -> AST -- ^ offset
           -> z3 AST
mkSeqIndex = liftFun3 Base.mkSeqIndex

-- | Convert string to integer.
mkStrToInt :: MonadZ3 z3 => AST -> z3 AST
mkStrToInt = liftFun1 Base.mkStrToInt

-- | Integer to string conversion.
mkIntToStr :: MonadZ3 z3 => AST -> z3 AST
mkIntToStr = liftFun1 Base.mkIntToStr

-- | Create a regular expression that accepts the sequence.
mkSeqToRe :: MonadZ3 z3 => AST -> z3 AST
mkSeqToRe = liftFun1 Base.mkSeqToRe

-- | Check if seq is in the language generated by the regular expression re.
mkSeqInRe :: MonadZ3 z3
          => AST -- ^ seq
          -> AST -- ^ re
          -> z3 AST
mkSeqInRe = liftFun2 Base.mkSeqInRe

-- | Create the regular language re+.
mkRePlus :: MonadZ3 z3 => AST -> z3 AST
mkRePlus = liftFun1 Base.mkRePlus

-- | Create the regular language re*.
mkReStar :: MonadZ3 z3 => AST -> z3 AST
mkReStar = liftFun1 Base.mkReStar

-- | Create the regular language [re].
mkReOption :: MonadZ3 z3 => AST -> z3 AST
mkReOption = liftFun1 Base.mkReOption

-- | Create the union of the regular languages.
mkReUnion :: (Integral int, MonadZ3 z3) => int -> [AST] -> z3 AST
mkReUnion = liftFun2 Base.mkReUnion

-- | Create the concatenation of the regular languages.
mkReConcat :: (Integral int, MonadZ3 z3) => int -> [AST] -> z3 AST
mkReConcat = liftFun2 Base.mkReConcat

-- | Create the range regular expression over two sequences of length 1.
mkReRange :: MonadZ3 z3
          => AST -- ^ lo
          -> AST -- ^ hi
          -> z3 AST
mkReRange = liftFun2 Base.mkReRange

-- | Create a regular expression loop. The supplied regular expression r is
-- repeated between lo and hi times. The lo should be below hi with one
-- exception: when supplying the value hi as 0, the meaning is to repeat the
-- argument r at least lo number of times, and with an unbounded upper bound.
mkReLoop :: (Integral int, MonadZ3 z3)
         => AST -- ^ r
         -> int -- ^ lo
         -> int -- ^ hi
         -> z3 AST
mkReLoop = liftFun3 Base.mkReLoop

-- | Create the intersection of the regular languages.
mkReIntersect :: (Integral int, MonadZ3 z3) => int -> [AST] -> z3 AST
mkReIntersect = liftFun2 Base.mkReIntersect

-- | Create the complement of the regular language.
mkReComplement :: MonadZ3 z3 => AST -> z3 AST
mkReComplement = liftFun1 Base.mkReComplement

-- | Create an empty regular expression of sort re.
mkReEmpty :: MonadZ3 z3 => Sort -> z3 AST
mkReEmpty = liftFun1 Base.mkReEmpty

-- | Create an universal regular expression of sort re.
mkReFull :: MonadZ3 z3 => Sort -> z3 AST
mkReFull = liftFun1 Base.mkReFull


---------------------------------------------------------------------
-- Quantifiers

mkPattern :: MonadZ3 z3 => [AST] -> z3 Pattern
mkPattern = liftFun1 Base.mkPattern

mkBound :: MonadZ3 z3 => Int -> Sort -> z3 AST
mkBound = liftFun2 Base.mkBound

mkForallW :: MonadZ3 z3 => Int -> [Pattern] -> [Symbol] -> [Sort] -> AST -> z3 AST
mkForallW = liftFun5 Base.mkForallW

mkForall :: MonadZ3 z3 => [Pattern] -> [Symbol] -> [Sort] -> AST -> z3 AST
mkForall = liftFun4 Base.mkForall

mkForallConst :: MonadZ3 z3 => [Pattern] -> [App] -> AST -> z3 AST
mkForallConst = liftFun3 Base.mkForallConst

mkForallWConst :: MonadZ3 z3 => Int -> [Pattern] -> [App] -> AST -> z3 AST
mkForallWConst = liftFun4 Base.mkForallWConst

mkExistsConst :: MonadZ3 z3 => [Pattern] -> [App] -> AST -> z3 AST
mkExistsConst = liftFun3 Base.mkExistsConst

mkExistsWConst :: MonadZ3 z3 => Int -> [Pattern] -> [App] -> AST -> z3 AST
mkExistsWConst = liftFun4 Base.mkExistsWConst

mkExistsW :: MonadZ3 z3 => Int -> [Pattern] -> [Symbol] -> [Sort] -> AST -> z3 AST
mkExistsW = liftFun5 Base.mkExistsW

mkExists :: MonadZ3 z3 => [Pattern] -> [Symbol] -> [Sort] -> AST -> z3 AST
mkExists = liftFun4 Base.mkExists

---------------------------------------------------------------------
-- Accessors

-- | Return the symbol name.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaf1683d9464f377e5089ce6ebf2a9bd31>
getSymbolString :: MonadZ3 z3 => Symbol -> z3 String
getSymbolString = liftFun1 Base.getSymbolString

-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gacc77e9b5ce5ada28c5af4ddb67d6702a>
getSortId :: MonadZ3 z3 => Sort -> z3 Int
getSortId = liftFun1 Base.getSortId

-- | Return the sort name as a symbol.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gab66884f00730c61cf3a5e6814aa2ebd0>
getSortName :: MonadZ3 z3 => Sort -> z3 Symbol
getSortName = liftFun1 Base.getSortName

-- | Convert a Z3_sort into Z3_ast. This is just type casting.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gac68cabaff75abfbf3d99f1f66d2e39a5>
sortToAst :: MonadZ3 z3 => Sort -> z3 AST
sortToAst = liftFun1 Base.sortToAst

-- | Compare sorts.
--
-- | Reference: <https://z3prover.github.io/api/html/group__capi.html#gaf260f3b5bc786cd0552e1ed4f8232a4b>
isEqSort :: MonadZ3 z3 => Sort -> Sort -> z3 Bool
isEqSort = liftFun2 Base.isEqSort

-- | Return the sort kind.
--
-- Reference: <http://z3prover.github.io/api/html/group__capi.html#gacd85d48842c7bfaa696596d16875681a>
getSortKind :: MonadZ3 z3 => Sort -> z3 SortKind
getSortKind = liftFun1 Base.getSortKind

-- | Return the size of the given bit-vector sort.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga8fc3550edace7bc046e16d1f96ddb419>
getBvSortSize :: MonadZ3 z3 => Sort -> z3 Int
getBvSortSize = liftFun1 Base.getBvSortSize


getTupleSortMkDecl :: MonadZ3 z3 => Sort -> z3 FuncDecl
getTupleSortMkDecl = liftFun1 Base.getTupleSortMkDecl

getTupleSortNumFields :: MonadZ3 z3 => Sort -> z3 Int
getTupleSortNumFields = liftFun1 Base.getTupleSortNumFields

getTupleSortFieldDecl :: MonadZ3 z3 => Sort -> Int -> z3 FuncDecl
getTupleSortFieldDecl = liftFun2 Base.getTupleSortFieldDecl

-- | Get list of constructors for datatype.
getDatatypeSortConstructors :: MonadZ3 z3
                            => Sort           -- ^ Datatype sort.
                            -> z3 [FuncDecl]  -- ^ Constructor declarations.
getDatatypeSortConstructors = liftFun1 Base.getDatatypeSortConstructors

-- | Get list of recognizers for datatype.
getDatatypeSortRecognizers :: MonadZ3 z3
                           => Sort           -- ^ Datatype sort.
                           -> z3 [FuncDecl]  -- ^ Constructor recognizers.
getDatatypeSortRecognizers = liftFun1 Base.getDatatypeSortRecognizers

-- | Get list of accessors for datatype.
getDatatypeSortConstructorAccessors :: MonadZ3 z3
                           => Sort           -- ^ Datatype sort.
                           -> z3 [[FuncDecl]]  -- ^ Constructor recognizers.
getDatatypeSortConstructorAccessors = liftFun1 Base.getDatatypeSortConstructorAccessors

-- | At most @k@ of the arguments @ps@ may be true, i.e. encode @p1 + p2
-- + ... + pn <= k@.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gaf2501779266a6dc2738a8928d1fc858c>
mkAtMost :: MonadZ3 z3 => [AST] -> Int -> z3 AST
mkAtMost = liftFun2 Base.mkAtMost

-- | At least @k@ of the arguments @ps@ may be true, i.e. encode @p1 +
-- p2 + ... + pn >= k@.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#gaaa996ab58cf979d5849178f1d2963efb>
mkAtLeast :: MonadZ3 z3 => [AST] -> Int -> z3 AST
mkAtLeast = liftFun2 Base.mkAtLeast

-- | Return the constant declaration name as a symbol.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga741b1bf11cb92aa2ec9ef2fef73ff129>
getDeclName :: MonadZ3 z3 => FuncDecl -> z3 Symbol
getDeclName = liftFun1 Base.getDeclName

-- | Returns the number of parameters of the given declaration
getArity :: MonadZ3 z3 => FuncDecl -> z3 Int
getArity = liftFun1 Base.getArity

-- | Returns the sort of the i-th parameter of the given function declaration
getDomain :: MonadZ3 z3
             => FuncDecl         -- ^ A function declaration
             -> Int              -- ^ i
             -> z3 Sort
getDomain = liftFun2 Base.getDomain

-- | Returns the range of the given declaration.
getRange :: MonadZ3 z3 => FuncDecl -> z3 Sort
getRange = liftFun1 Base.getRange

-- | Convert an app into AST. This is just type casting.
appToAst :: MonadZ3 z3 => App -> z3 AST
appToAst = liftFun1 Base.appToAst

-- | Return the declaration of a constant or function application.
getAppDecl :: MonadZ3 z3 => App -> z3 FuncDecl
getAppDecl = liftFun1 Base.getAppDecl

-- | Return the number of argument of an application. If t is an constant, then the number of arguments is 0.
getAppNumArgs :: MonadZ3 z3 => App -> z3 Int
getAppNumArgs = liftFun1 Base.getAppNumArgs

-- | Return the i-th argument of the given application.
getAppArg :: MonadZ3 z3 => App -> Int -> z3 AST
getAppArg = liftFun2 Base.getAppArg

-- | Return a list of all the arguments of the given application.
getAppArgs :: MonadZ3 z3 => App -> z3 [AST]
getAppArgs = liftFun1 Base.getAppArgs

-- | Return the sort of an AST node.
getSort :: MonadZ3 z3 => AST -> z3 Sort
getSort = liftFun1 Base.getSort

getArraySortDomain :: MonadZ3 z3 => Sort -> z3 Sort
getArraySortDomain = liftFun1 Base.getArraySortDomain

getArraySortRange :: MonadZ3 z3 => Sort -> z3 Sort
getArraySortRange = liftFun1 Base.getArraySortRange

-- | Returns @Just True@, @Just False@, or @Nothing@ for /undefined/.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga133aaa1ec31af9b570ed7627a3c8c5a4>
getBoolValue :: MonadZ3 z3 => AST -> z3 (Maybe Bool)
getBoolValue = liftFun1 Base.getBoolValue

-- | Return the kind of the given AST.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4c43608feea4cae363ef9c520c239a5c>
getAstKind :: MonadZ3 z3 => AST -> z3 ASTKind
getAstKind = liftFun1 Base.getAstKind

-- | Return True if an ast is APP_AST, False otherwise.
isApp :: MonadZ3 z3 => AST -> z3 Bool
isApp = liftFun1 Base.isApp

-- | Cast AST into an App.
toApp :: MonadZ3 z3 => AST -> z3 App
toApp = liftFun1 Base.toApp

-- | Return numeral value, as a string of a numeric constant term.
getNumeralString :: MonadZ3 z3 => AST -> z3 String
getNumeralString = liftFun1 Base.getNumeralString

-- | Return the numerator (as a numeral AST) of a numeral AST of sort Real.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga2d37084eb47ea0ab19638a3407ce610b>
getNumerator :: MonadZ3 z3 => AST -> z3 AST
getNumerator = liftFun1 Base.getNumerator

-- | Return the denominator (as a numeral AST) of a numeral AST of sort Real.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga07549939888e8fdfc8e0fde1776c31a7>
getDenominator :: MonadZ3 z3 => AST -> z3 AST
getDenominator = liftFun1 Base.getDenominator

getIndexValue :: MonadZ3 z3 => AST -> z3 Int
getIndexValue = liftFun1 Base.getIndexValue

isQuantifierForall :: MonadZ3 z3 => AST -> z3 Bool
isQuantifierForall = liftFun1 Base.isQuantifierForall

isQuantifierExists :: MonadZ3 z3 => AST -> z3 Bool
isQuantifierExists = liftFun1 Base.isQuantifierExists

getQuantifierWeight :: MonadZ3 z3 => AST -> z3 Int
getQuantifierWeight = liftFun1 Base.getQuantifierWeight

getQuantifierNumPatterns :: MonadZ3 z3 => AST -> z3 Int
getQuantifierNumPatterns = liftFun1 Base.getQuantifierNumPatterns

getQuantifierPatternAST :: MonadZ3 z3 => AST -> Int -> z3 AST
getQuantifierPatternAST = liftFun2 Base.getQuantifierPatternAST

getQuantifierPatterns :: MonadZ3 z3 => AST -> z3 [AST]
getQuantifierPatterns = liftFun1 Base.getQuantifierPatterns

getQuantifierNumNoPatterns :: MonadZ3 z3 => AST -> z3 Int
getQuantifierNumNoPatterns = liftFun1 Base.getQuantifierNumNoPatterns

getQuantifierNoPatternAST :: MonadZ3 z3 => AST -> Int -> z3 AST
getQuantifierNoPatternAST = liftFun2 Base.getQuantifierNoPatternAST

getQuantifierNoPatterns :: MonadZ3 z3 => AST -> z3 [AST]
getQuantifierNoPatterns = liftFun1 Base.getQuantifierNoPatterns

getQuantifierNumBound :: MonadZ3 z3 => AST -> z3 Int
getQuantifierNumBound = liftFun1 Base.getQuantifierNumBound

getQuantifierBoundName :: MonadZ3 z3 => AST -> Int -> z3 Symbol
getQuantifierBoundName = liftFun2 Base.getQuantifierBoundName

getQuantifierBoundSort :: MonadZ3 z3 => AST -> Int -> z3 Sort
getQuantifierBoundSort = liftFun2 Base.getQuantifierBoundSort

getQuantifierBoundVars :: MonadZ3 z3 => AST -> z3 [AST]
getQuantifierBoundVars = liftFun1 Base.getQuantifierBoundVars

getQuantifierBody :: MonadZ3 z3 => AST -> z3 AST
getQuantifierBody = liftFun1 Base.getQuantifierBody

-- | Simplify the expression.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gada433553406475e5dd6a494ea957844c>
simplify :: MonadZ3 z3 => AST -> z3 AST
simplify = liftFun1 Base.simplify

-- | Simplify the expression using the given parameters.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga34329d4c83ca8c98e18b2884b679008c>
simplifyEx :: MonadZ3 z3 => AST -> Params -> z3 AST
simplifyEx = liftFun2 Base.simplifyEx

-------------------------------------------------
-- ** Helpers

-- | Read a 'Bool' value from an 'AST'
getBool :: MonadZ3 z3 => AST -> z3 Bool
getBool = liftFun1 Base.getBool

-- | Return the integer value
getInt :: MonadZ3 z3 => AST -> z3 Integer
getInt = liftFun1 Base.getInt

-- | Return rational value
getReal :: MonadZ3 z3 => AST -> z3 Rational
getReal = liftFun1 Base.getReal

---------------------------------------------------------------------
-- Modifiers

substituteVars :: MonadZ3 z3 => AST -> [AST] -> z3 AST
substituteVars = liftFun2 Base.substituteVars

substitute :: MonadZ3 z3 => AST -> [(AST, AST)] -> z3 AST
substitute = liftFun2 Base.substitute

---------------------------------------------------------------------
-- Models

-- | Evaluate an AST node in the given model.
--
-- The evaluation may fail for the following reasons:
--
--     * /t/ contains a quantifier.
--     * the model /m/ is partial.
--     * /t/ is type incorrect.
modelEval :: MonadZ3 z3 => Model -> AST
             -> Bool  -- ^ Model completion?
             -> z3 (Maybe AST)
modelEval = liftFun3 Base.modelEval

-- | Get array as a list of argument/value pairs, if it is
-- represented as a function (ie, using as-array).
evalArray :: MonadZ3 z3 => Model -> AST -> z3 (Maybe FuncModel)
evalArray = liftFun2 Base.evalArray

getConstInterp :: MonadZ3 z3 => Model -> FuncDecl -> z3 (Maybe AST)
getConstInterp = liftFun2 Base.getConstInterp

-- | Return the interpretation of the function f in the model m.
-- Return NULL, if the model does not assign an interpretation for f.
-- That should be interpreted as: the f does not matter.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gafb9cc5eca9564d8a849c154c5a4a8633>
getFuncInterp :: MonadZ3 z3 => Model -> FuncDecl -> z3 (Maybe FuncInterp)
getFuncInterp = liftFun2 Base.getFuncInterp

hasInterp :: MonadZ3 z3 => Model -> FuncDecl -> z3 Bool
hasInterp = liftFun2 Base.hasInterp

numConsts :: MonadZ3 z3 => Model -> z3 Word
numConsts = liftFun1 Base.numConsts

numFuncs :: MonadZ3 z3 => Model -> z3 Word
numFuncs = liftFun1 Base.numFuncs

getConstDecl :: MonadZ3 z3 => Model -> Word -> z3 FuncDecl
getConstDecl = liftFun2 Base.getConstDecl

getFuncDecl :: MonadZ3 z3 => Model -> Word -> z3 FuncDecl
getFuncDecl = liftFun2 Base.getFuncDecl

getConsts :: MonadZ3 z3 => Model -> z3 [FuncDecl]
getConsts = liftFun1 Base.getConsts

getFuncs :: MonadZ3 z3 => Model -> z3 [FuncDecl]
getFuncs = liftFun1 Base.getFuncs

-- | The (_ as-array f) AST node is a construct for assigning interpretations
-- for arrays in Z3. It is the array such that forall indices i we have that
-- (select (_ as-array f) i) is equal to (f i). This procedure returns Z3_TRUE
-- if the a is an as-array AST node.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga4674da67d226bfb16861829b9f129cfa>
isAsArray :: MonadZ3 z3 => AST -> z3 Bool
isAsArray = liftFun1 Base.isAsArray

isEqAST :: MonadZ3 z3 => AST -> AST -> z3 Bool
isEqAST = liftFun2 Base.isEqAST

addFuncInterp :: MonadZ3 z3 => Model -> FuncDecl -> AST -> z3 FuncInterp
addFuncInterp = liftFun3 Base.addFuncInterp

addConstInterp :: MonadZ3 z3 => Model -> FuncDecl -> AST -> z3 ()
addConstInterp = liftFun3 Base.addConstInterp


-- | Return the function declaration f associated with a (_ as_array f) node.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga7d9262dc6e79f2aeb23fd4a383589dda>
getAsArrayFuncDecl :: MonadZ3 z3 => AST -> z3 FuncDecl
getAsArrayFuncDecl = liftFun1 Base.getAsArrayFuncDecl

-- | Return the number of entries in the given function interpretation.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga2bab9ae1444940e7593729beec279844>
funcInterpGetNumEntries :: MonadZ3 z3 => FuncInterp -> z3 Int
funcInterpGetNumEntries = liftFun1 Base.funcInterpGetNumEntries

-- | Return a "point" of the given function intepretation.
-- It represents the value of f in a particular point.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaf157e1e1cd8c0cfe6a21be6370f659da>
funcInterpGetEntry :: MonadZ3 z3 => FuncInterp -> Int -> z3 FuncEntry
funcInterpGetEntry = liftFun2 Base.funcInterpGetEntry

-- | Return the 'else' value of the given function interpretation.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga46de7559826ba71b8488d727cba1fb64>
funcInterpGetElse :: MonadZ3 z3 => FuncInterp -> z3 AST
funcInterpGetElse = liftFun1 Base.funcInterpGetElse

-- | Return the arity (number of arguments) of the given function
-- interpretation.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#gaca22cbdb6f7787aaae5d814f2ab383d8>
funcInterpGetArity :: MonadZ3 z3 => FuncInterp -> z3 Int
funcInterpGetArity = liftFun1 Base.funcInterpGetArity

-- | Return the value of this point.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga9fd65e2ab039aa8e40608c2ecf7084da>
funcEntryGetValue :: MonadZ3 z3 => FuncEntry -> z3 AST
funcEntryGetValue = liftFun1 Base.funcEntryGetValue

-- | Return the number of arguments in a Z3_func_entry object.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga51aed8c5bc4b1f53f0c371312de3ce1a>
funcEntryGetNumArgs :: MonadZ3 z3 => FuncEntry -> z3 Int
funcEntryGetNumArgs = liftFun1 Base.funcEntryGetNumArgs

-- | Return an argument of a Z3_func_entry object.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga6fe03fe3c824fceb52766a4d8c2cbeab>
funcEntryGetArg :: MonadZ3 z3 => FuncEntry -> Int -> z3 AST
funcEntryGetArg = liftFun2 Base.funcEntryGetArg

-- | Convert the given model into a string.
modelToString :: MonadZ3 z3 => Model -> z3 String
modelToString = liftFun1 Base.modelToString

-- | Alias for 'modelToString'.
showModel :: MonadZ3 z3 => Model -> z3 String
showModel = modelToString

-------------------------------------------------
-- ** Helpers

-- | Type of an evaluation function for 'AST'.
--
-- Evaluation may fail (i.e. return 'Nothing') for a few
-- reasons, see 'modelEval'.
type EvalAst m a = Model -> AST -> m (Maybe a)

-- | An alias for 'modelEval' with model completion enabled.
eval :: MonadZ3 z3 => EvalAst z3 AST
eval = liftFun2 Base.eval

-- | Evaluate an AST node of sort /bool/ in the given model.
--
-- See 'modelEval' and 'getBool'.
evalBool :: MonadZ3 z3 => EvalAst z3 Bool
evalBool = liftFun2 Base.evalBool

-- | Evaluate an AST node of sort /int/ in the given model.
--
-- See 'modelEval' and 'getInt'.
evalInt :: MonadZ3 z3 => EvalAst z3 Integer
evalInt = liftFun2 Base.evalInt

-- | Evaluate an AST node of sort /real/ in the given model.
--
-- See 'modelEval' and 'getReal'.
evalReal :: MonadZ3 z3 => EvalAst z3 Rational
evalReal = liftFun2 Base.evalReal

-- | Evaluate an AST node of sort /bit-vector/ in the given model.
--
-- The flag /signed/ decides whether the bit-vector value is
-- interpreted as a signed or unsigned integer.
--
-- See 'modelEval' and 'mkBv2int'.
evalBv :: MonadZ3 z3 => Bool -- ^ signed?
                     -> EvalAst z3 Integer
evalBv = liftFun3 Base.evalBv

-- | Evaluate a collection of AST nodes in the given model.
evalT :: (MonadZ3 z3,Traversable t) => Model -> t AST -> z3 (Maybe (t AST))
evalT = liftFun2 Base.evalT

-- | Run a evaluation function on a 'Traversable' data structure of 'AST's
-- (e.g. @[AST]@, @Vector AST@, @Maybe AST@, etc).
--
-- This a generic version of 'evalT' which can be used in combination with
-- other helpers. For instance, @mapEval evalInt@ can be used to obtain
-- the 'Integer' interpretation of a list of 'AST' of sort /int/.
mapEval :: (MonadZ3 z3, Traversable t) => EvalAst z3 a
                                       -> Model
                                       -> t AST
                                       -> z3 (Maybe (t a))
mapEval f m = fmap T.sequence . T.mapM (f m)

-- | Get function as a list of argument/value pairs.
evalFunc :: MonadZ3 z3 => Model -> FuncDecl -> z3 (Maybe FuncModel)
evalFunc = liftFun2 Base.evalFunc

---------------------------------------------------------------------
-- Tactics

mkTactic :: MonadZ3 z3 => String -> z3 Tactic
mkTactic = liftFun1 Base.mkTactic

andThenTactic :: MonadZ3 z3 => Tactic -> Tactic -> z3 Tactic
andThenTactic = liftFun2 Base.andThenTactic

orElseTactic :: MonadZ3 z3 => Tactic -> Tactic -> z3 Tactic
orElseTactic = liftFun2 Base.andThenTactic

skipTactic :: MonadZ3 z3 => z3 Tactic
skipTactic = liftScalar Base.skipTactic

tryForTactic :: MonadZ3 z3 => Tactic -> Int -> z3 Tactic
tryForTactic = liftFun2 Base.tryForTactic

repeatTactic :: MonadZ3 z3 => Tactic -> Int -> z3 Tactic
repeatTactic = liftFun2 Base.repeatTactic

mkQuantifierEliminationTactic :: MonadZ3 z3 => z3 Tactic
mkQuantifierEliminationTactic = liftScalar Base.mkQuantifierEliminationTactic

mkAndInverterGraphTactic :: MonadZ3 z3 => z3 Tactic
mkAndInverterGraphTactic = liftScalar Base.mkAndInverterGraphTactic

applyTactic :: MonadZ3 z3 => Tactic -> Goal -> z3 ApplyResult
applyTactic = liftFun2 Base.applyTactic

applyResultToString :: MonadZ3 z3 => ApplyResult -> z3 String
applyResultToString = liftFun1 Base.applyResultToString

getApplyResultNumSubgoals :: MonadZ3 z3 => ApplyResult -> z3 Int
getApplyResultNumSubgoals = liftFun1 Base.getApplyResultNumSubgoals

getApplyResultSubgoal :: MonadZ3 z3 => ApplyResult -> Int -> z3 Goal
getApplyResultSubgoal = liftFun2 Base.getApplyResultSubgoal

getApplyResultSubgoals :: MonadZ3 z3 => ApplyResult -> z3 [Goal]
getApplyResultSubgoals = liftFun1 Base.getApplyResultSubgoals

mkGoal :: MonadZ3 z3 => Bool -> Bool -> Bool -> z3 Goal
mkGoal = liftFun3 Base.mkGoal

goalAssert :: MonadZ3 z3 => Goal -> AST -> z3 ()
goalAssert = liftFun2 Base.goalAssert

getGoalSize :: MonadZ3 z3 => Goal -> z3 Int
getGoalSize = liftFun1 Base.getGoalSize

getGoalFormula :: MonadZ3 z3 => Goal -> Int -> z3 AST
getGoalFormula = liftFun2 Base.getGoalFormula

getGoalFormulas :: MonadZ3 z3 => Goal -> z3 [AST]
getGoalFormulas = liftFun1 Base.getGoalFormulas

goalToString :: MonadZ3 z3 => Goal -> z3 String
goalToString = liftFun1 Base.goalToString

---------------------------------------------------------------------
-- String Conversion

-- | Set the mode for converting expressions to strings.
setASTPrintMode :: MonadZ3 z3 => ASTPrintMode -> z3 ()
setASTPrintMode = liftFun1 Base.setASTPrintMode

-- | Convert an AST to a string.
astToString :: MonadZ3 z3 => AST -> z3 String
astToString = liftFun1 Base.astToString

-- | Convert a pattern to a string.
patternToString :: MonadZ3 z3 => Pattern -> z3 String
patternToString = liftFun1 Base.patternToString

-- | Convert a sort to a string.
sortToString :: MonadZ3 z3 => Sort -> z3 String
sortToString = liftFun1 Base.sortToString

-- | Convert a FuncDecl to a string.
funcDeclToString :: MonadZ3 z3 => FuncDecl -> z3 String
funcDeclToString = liftFun1 Base.funcDeclToString

-- | Convert the given benchmark into SMT-LIB formatted string.
--
-- The output format can be configured via 'setASTPrintMode'.
benchmarkToSMTLibString :: MonadZ3 z3 =>
                               String   -- ^ name
                            -> String   -- ^ logic
                            -> String   -- ^ status
                            -> String   -- ^ attributes
                            -> [AST]    -- ^ assumptions1
                            -> AST      -- ^ formula
                            -> z3 String
benchmarkToSMTLibString = liftFun6 Base.benchmarkToSMTLibString


---------------------------------------------------------------------
-- Parser interface

-- | Parse SMT expressions from a string
--
-- The sort and declaration arguments allow parsing in a context in which variables and functions have already been declared. They are almost never used.
parseSMTLib2String :: MonadZ3 z3 =>
                      String     -- ^ string to parse
                   -> [Symbol]   -- ^ sort names
                   -> [Sort]     -- ^ sorts
                   -> [Symbol]   -- ^ declaration names
                   -> [FuncDecl] -- ^ declarations
                   -> z3 [AST]
parseSMTLib2String = liftFun5 Base.parseSMTLib2String

-- | Parse SMT expressions from a file
--
-- The sort and declaration arguments allow parsing in a context in which variables and functions have already been declared. They are almost never used.
parseSMTLib2File :: MonadZ3 z3 =>
                    String     -- ^ string to parse
                 -> [Symbol]   -- ^ sort names
                 -> [Sort]     -- ^ sorts
                 -> [Symbol]   -- ^ declaration names
                 -> [FuncDecl] -- ^ declarations
                 -> z3 [AST]
parseSMTLib2File = liftFun5 Base.parseSMTLib2File

---------------------------------------------------------------------
-- Miscellaneous

-- | Return Z3 version number information.
getVersion :: MonadZ3 z3 => z3 Version
getVersion = liftIO Base.getVersion

---------------------------------------------------------------------
-- Fixedpoint

class MonadZ3 m => MonadFixedpoint m where
  getFixedpoint :: m Base.Fixedpoint

fixedpointAddRule :: MonadFixedpoint z3 => AST -> Symbol -> z3 ()
fixedpointAddRule = liftFixedpoint2 Base.fixedpointAddRule

fixedpointSetParams :: MonadFixedpoint z3 => Params -> z3 ()
fixedpointSetParams = liftFixedpoint1 Base.fixedpointSetParams

fixedpointRegisterRelation :: MonadFixedpoint z3 => FuncDecl -> z3 ()
fixedpointRegisterRelation = liftFixedpoint1 Base.fixedpointRegisterRelation

fixedpointQueryRelations :: MonadFixedpoint z3 => [FuncDecl] -> z3 Result
fixedpointQueryRelations = liftFixedpoint1 Base.fixedpointQueryRelations

fixedpointGetAnswer :: MonadFixedpoint z3 => z3 AST
fixedpointGetAnswer = liftFixedpoint0 Base.fixedpointGetAnswer

fixedpointGetAssertions :: MonadFixedpoint z3 => z3 [AST]
fixedpointGetAssertions = liftFixedpoint0 Base.fixedpointGetAssertions

---------------------------------------------------------------------
-- Floating-Point Arithmetic

-- | Create the RoundingMode sort.
mkFpaRoundingModeSort :: MonadZ3 z3 => z3 Sort
mkFpaRoundingModeSort = liftScalar Base.mkFpaRoundingModeSort

-- | Create a numeral of RoundingMode sort which represents the
-- NearestTiesToEven rounding mode.
mkFpaRoundNearestTiesToEven :: MonadZ3 z3 => z3 AST
mkFpaRoundNearestTiesToEven = liftScalar Base.mkFpaRoundNearestTiesToEven

-- | Create a numeral of RoundingMode sort which represents the
-- NearestTiesToEven rounding mode.
mkFpaRne :: MonadZ3 z3 => z3 AST
mkFpaRne = liftScalar Base.mkFpaRne

-- | Create a numeral of RoundingMode sort which represents the
-- NearestTiesToAway rounding mode.
mkFpaRoundNearestTiesToAway :: MonadZ3 z3 => z3 AST
mkFpaRoundNearestTiesToAway = liftScalar Base.mkFpaRoundNearestTiesToAway

-- | Create a numeral of RoundingMode sort which represents the
-- NearestTiesToAway rounding mode.
mkFpaRna :: MonadZ3 z3 => z3 AST
mkFpaRna = liftScalar Base.mkFpaRna

-- | Create a numeral of RoundingMode sort which represents the
-- TowardPositive rounding mode.
mkFpaRoundTowardPositive :: MonadZ3 z3 => z3 AST
mkFpaRoundTowardPositive = liftScalar Base.mkFpaRoundTowardPositive

-- | Create a numeral of RoundingMode sort which represents the
-- TowardPositive rounding mode.
mkFpaRtp :: MonadZ3 z3 => z3 AST
mkFpaRtp = liftScalar Base.mkFpaRtp

-- | Create a numeral of RoundingMode sort which represents the
-- TowardNegative rounding mode.
mkFpaRoundTowardNegative :: MonadZ3 z3 => z3 AST
mkFpaRoundTowardNegative = liftScalar Base.mkFpaRoundTowardNegative

-- | Create a numeral of RoundingMode sort which represents the
-- TowardNegative rounding mode.
mkFpaRtn :: MonadZ3 z3 => z3 AST
mkFpaRtn = liftScalar Base.mkFpaRtn

-- | Create a numeral of RoundingMode sort which represents the
-- TowardZero rounding mode.
mkFpaRoundTowardZero :: MonadZ3 z3 => z3 AST
mkFpaRoundTowardZero = liftScalar Base.mkFpaRoundTowardZero

-- | Create a numeral of RoundingMode sort which represents the
-- TowardZero rounding mode.
mkFpaRtz :: MonadZ3 z3 => z3 AST
mkFpaRtz = liftScalar Base.mkFpaRtz

-- | Create a FloatingPoint sort.
mkFpaSort :: (MonadZ3 z3, Integral int)
          => int -- ^ Number of exponent bits
          -> int -- ^ Number of significand bits
          -> z3 Sort
mkFpaSort = liftFun2 Base.mkFpaSort

-- | Create the half-precision (16-bit) FloatingPoint sort.
mkFpaSortHalf :: MonadZ3 z3 => z3 Sort
mkFpaSortHalf = liftScalar Base.mkFpaSortHalf

-- | Create the half-precision (16-bit) FloatingPoint sort.
mkFpaSort16 :: MonadZ3 z3 => z3 Sort
mkFpaSort16 = liftScalar Base.mkFpaSort16

-- | Create the single-precision (32-bit) FloatingPoint sort.
mkFpaSortSingle :: MonadZ3 z3 => z3 Sort
mkFpaSortSingle = liftScalar Base.mkFpaSortSingle

-- | Create the single-precision (32-bit) FloatingPoint sort.
mkFpaSort32 :: MonadZ3 z3 => z3 Sort
mkFpaSort32 = liftScalar Base.mkFpaSort32

-- | Create the double-precision (64-bit) FloatingPoint sort.
mkFpaSortDouble :: MonadZ3 z3 => z3 Sort
mkFpaSortDouble = liftScalar Base.mkFpaSortDouble

-- | Create the double-precision (64-bit) FloatingPoint sort.
mkFpaSort64 :: MonadZ3 z3 => z3 Sort
mkFpaSort64 = liftScalar Base.mkFpaSort64

-- | Create the quadruple-precision (128-bit) FloatingPoint sort.
mkFpaSortQuadruple :: MonadZ3 z3 => z3 Sort
mkFpaSortQuadruple = liftScalar Base.mkFpaSortQuadruple

-- | Create the quadruple-precision (128-bit) FloatingPoint sort.
mkFpaSort128 :: MonadZ3 z3 => z3 Sort
mkFpaSort128 = liftScalar Base.mkFpaSort128

-- | Create a floating-point NaN of sort @s@.
mkFpaNaN :: MonadZ3 z3 => Sort -> z3 AST
mkFpaNaN = liftFun1 Base.mkFpaNaN

-- | Create a floating-point infinity of sort @s@.
mkFpaInf :: MonadZ3 z3
         => Sort    -- ^ Target sort
         -> Bool    -- ^ Indicates whether the result should be negative
         -> z3 AST
mkFpaInf = liftFun2 Base.mkFpaInf

-- | Create a floating-point zero of sort @s@.
mkFpaZero :: MonadZ3 z3 
          => Sort    -- ^ Target sort
          -> Bool    -- ^ Indicates whether the result should be negative
          -> z3 AST
mkFpaZero = liftFun2 Base.mkFpaZero

-- | Create an expression of FloatingPoint sort from three bit-vector
-- expressions.
--
-- This is the operator named `fp' in the SMT FP theory definition.
-- Note that @sgn@ is required to be a bit-vector of size 1.
-- Significand and exponent are required to be longer than 1 and 2
-- respectively. The FloatingPoint sort of the resulting expression
-- is automatically determined from the bit-vector sizes of the
-- arguments. The exponent is assumed to be in IEEE-754 biased
-- representation.
mkFpaFp :: MonadZ3 z3
        => AST     -- ^ Sign
        -> AST     -- ^ Exponent
        -> AST     -- ^ Significand
        -> z3 AST
mkFpaFp = liftFun3 Base.mkFpaFp

-- | Create a numeral of FloatingPoint sort from a float.
mkFpaNumeralFloat :: MonadZ3 z3 => Float -> Sort -> z3 AST
mkFpaNumeralFloat = liftFun2 Base.mkFpaNumeralFloat

-- | Create a numeral of FloatingPoint sort from a double.
mkFpaNumeralDouble :: MonadZ3 z3 => Double -> Sort -> z3 AST
mkFpaNumeralDouble = liftFun2 Base.mkFpaNumeralDouble

-- | Create a numeral of FloatingPoint sort from a signed integer.
mkFpaNumeralInt :: (MonadZ3 z3, Integral int) => int -> Sort -> z3 AST
mkFpaNumeralInt = liftFun2 Base.mkFpaNumeralInt

-- | Create a numeral of FLoatingPoint sort from a sign bit and
-- two integers.
mkFpaNumeralIntUInt :: (MonadZ3 z3, Integral int)
                    => Bool    -- ^ Sign bit (true == negative)
                    -> int     -- ^ Significand
                    -> int     -- ^ Exponent
                    -> Sort    -- ^ Result sort
                    -> z3 AST
mkFpaNumeralIntUInt = liftFun4 Base.mkFpaNumeralIntUInt

-- | Create a numeral of FloatingPoint sort from a sign bit and
-- two 64-bit integers.
mkFpaNumeralInt64UInt64 :: (MonadZ3 z3, Integral int)
                        => Bool    -- ^ Sign bit (true == negative)
                        -> int     -- ^ Significand
                        -> int     -- ^ Exponent
                        -> Sort    -- ^ Result sort
                        -> z3 AST
mkFpaNumeralInt64UInt64 = liftFun4 Base.mkFpaNumeralInt64UInt64

-- | Floating-point absolute value.
mkFpaAbs :: MonadZ3 z3 => AST -> z3 AST
mkFpaAbs = liftFun1 Base.mkFpaAbs

-- | Floating-point negation.
mkFpaNeg :: MonadZ3 z3 => AST -> z3 AST
mkFpaNeg = liftFun1 Base.mkFpaNeg

-- | Floating-point addition.
mkFpaAdd :: MonadZ3 z3
         => AST     -- ^ Rounding Mode
         -> AST     -- ^ FloatingPoint sort term
         -> AST     -- ^ FloatingPoint sort term
         -> z3 AST
mkFpaAdd = liftFun3 Base.mkFpaAdd

-- | Floating-point subtraction.
mkFpaSub :: MonadZ3 z3
         => AST     -- ^ Rounding Mode
         -> AST     -- ^ FloatingPoint sort term
         -> AST     -- ^ FloatingPoint sort term
         -> z3 AST
mkFpaSub = liftFun3 Base.mkFpaSub

-- | Floating-point multiplication.
mkFpaMul :: MonadZ3 z3
         => AST     -- ^ Rounding Mode
         -> AST     -- ^ FloatingPoint sort term
         -> AST     -- ^ FloatingPoint sort term
         -> z3 AST
mkFpaMul = liftFun3 Base.mkFpaMul

-- | Floating-point division.
mkFpaDiv :: MonadZ3 z3
         => AST     -- ^ Rounding Mode
         -> AST     -- ^ FloatingPoint sort term
         -> AST     -- ^ FloatingPoint sort term
         -> z3 AST
mkFpaDiv = liftFun3 Base.mkFpaDiv

-- | Floating-point fused multiply-add.
--
-- The result is @round((t1 * t2) + t3)@.
mkFpaFma :: MonadZ3 z3 => AST -> AST -> AST -> AST -> z3 AST
mkFpaFma = liftFun4 Base.mkFpaFma

-- | Floating-point square root.
mkFpaSqrt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaSqrt = liftFun2 Base.mkFpaSqrt

-- | Floating-point remainder.
mkFpaRem :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaRem = liftFun2 Base.mkFpaRem

-- | Floating-point roundToIntegral. Rounds a floating-point number
-- to the closest integer, again represented as a floating-point
-- number.
mkFpaRoundToIntegral :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaRoundToIntegral = liftFun2 Base.mkFpaRoundToIntegral

-- | Minimum of floating-point numbers.
mkFpaMin :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaMin = liftFun2 Base.mkFpaMin

-- | Maximum of floating-point numbers.
mkFpaMax :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaMax = liftFun2 Base.mkFpaMax

-- | Floating-point less than or equal.
mkFpaLeq :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaLeq = liftFun2 Base.mkFpaLeq

-- | Floating-point less than.
mkFpaLt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaLt = liftFun2 Base.mkFpaLt

-- | Floating-point greater than or equal.
mkFpaGeq :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaGeq = liftFun2 Base.mkFpaGeq

-- | Floating-point greater than.
mkFpaGt :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaGt = liftFun2 Base.mkFpaGt

-- | Floating-point equality.
mkFpaEq :: MonadZ3 z3 => AST -> AST -> z3 AST
mkFpaEq = liftFun2 Base.mkFpaEq

-- | Predicate indicating whether @t@ is a normal floating-point
-- number.
mkFpaIsNormal :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsNormal = liftFun1 Base.mkFpaIsNormal

-- | Predicate indicating whether @t@ is a subnormal floating-point
-- number.
mkFpaIsSubnormal :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsSubnormal = liftFun1 Base.mkFpaIsSubnormal

-- | Predicate indicating whether @t@ is a floating-point number
-- with zero value, i.e., +zero or -zero.
mkFpaIsZero :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsZero = liftFun1 Base.mkFpaIsZero

-- | Predicate indicating whether @t@ is a floating-point number
-- representing infinity, i.e., +oo or -oo.
mkFpaIsInfinite :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsInfinite = liftFun1 Base.mkFpaIsInfinite

-- | Predicate indicating whether @t@ is NaN.
mkFpaIsNaN :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsNaN = liftFun1 Base.mkFpaIsNaN

-- | Predicate indicating whether @t@ is a negative floating-point
-- number.
mkFpaIsNegative :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsNegative = liftFun1 Base.mkFpaIsNegative

-- | Predicate indicating whether @t@ is a positive floating-point
-- number.
mkFpaIsPositive :: MonadZ3 z3 => AST -> z3 AST
mkFpaIsPositive = liftFun1 Base.mkFpaIsPositive

-- | Conversion of a single IEEE 754-2008 bit-vector into a
-- floating-point number.
mkFpaToFpBv :: MonadZ3 z3 => AST -> Sort -> z3 AST
mkFpaToFpBv = liftFun2 Base.mkFpaToFpBv

-- | Conversion of a FloatingPoint term into another term of
-- different FloatingPoint sort.
mkFpaToFpFloat :: MonadZ3 z3 => AST -> AST -> Sort -> z3 AST
mkFpaToFpFloat = liftFun3 Base.mkFpaToFpFloat

-- | Conversion of a term of real sort into a term of
-- FloatingPoint sort.
mkFpaToFpReal :: MonadZ3 z3 => AST -> AST -> Sort -> z3 AST
mkFpaToFpReal = liftFun3 Base.mkFpaToFpReal

-- | Conversion of a 2's complement signed bit-vector term into
-- a term of FloatingPoint sort.
mkFpaToFpSigned :: MonadZ3 z3 => AST -> AST -> Sort -> z3 AST
mkFpaToFpSigned = liftFun3 Base.mkFpaToFpSigned

-- | Conversion of a 2's complement unsigned bit-vector term into
-- a term of FloatingPoint sort.
mkFpaToFpUnsigned :: MonadZ3 z3 => AST -> AST -> Sort -> z3 AST
mkFpaToFpUnsigned = liftFun3 Base.mkFpaToFpUnsigned

-- | Conversion of a floating-point term into an unsigned bit-vector.
mkFpaToUbv :: (MonadZ3 z3, Integral int) => AST -> AST -> int -> z3 AST
mkFpaToUbv = liftFun3 Base.mkFpaToUbv

-- | Conversion of a floating-point term into a signed bit-vector.
mkFpaToSbv :: (MonadZ3 z3, Integral int) => AST -> AST -> int -> z3 AST
mkFpaToSbv = liftFun3 Base.mkFpaToSbv

-- | Conversion of a floating-point term into an real-numbered
-- term.
mkFpaToReal :: MonadZ3 z3 => AST -> z3 AST
mkFpaToReal = liftFun1 Base.mkFpaToReal

---------------------------------------------------------------------
-- Z3-specific floating-point extensions

-- | Retrieves the number of bits reserved for the exponent in a
-- FloatingPoint sort.
fpaGetEbits :: (MonadZ3 z3, Integral int) => Sort -> z3 int
fpaGetEbits = liftFun1 Base.fpaGetEbits

-- | Retrieves the number of bits reserved for the significand in
-- a FloatingPoint sort.
fpaGetSbits :: (MonadZ3 z3, Integral int) => Sort -> z3 int
fpaGetSbits = liftFun1 Base.fpaGetSbits

-- | Checks whether a given floating-point numeral is a NaN.
fpaIsNumeralNaN :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralNaN = liftFun1 Base.fpaIsNumeralNaN

-- | Checks whether a given floating-point numeral is a +oo or -oo.
fpaIsNumeralInf :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralInf = liftFun1 Base.fpaIsNumeralInf

-- | Checks whether a given floating-point numeral is a +zero or
-- -zero.
fpaIsNumeralZero :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralZero = liftFun1 Base.fpaIsNumeralZero

-- | Checks whether a given floating-point numeral is normal.
fpaIsNumeralNormal :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralNormal = liftFun1 Base.fpaIsNumeralNormal

-- | Checks whether a given floating-point numeral is subnormal.
fpaIsNumeralSubnormal :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralSubnormal = liftFun1 Base.fpaIsNumeralSubnormal

-- | Checks whether a given floating-point numeral is positive.
fpaIsNumeralPositive :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralPositive = liftFun1 Base.fpaIsNumeralPositive

-- | Checks whether a given floating-point numeral is negative.
fpaIsNumeralNegative :: MonadZ3 z3 => AST -> z3 Bool
fpaIsNumeralNegative = liftFun1 Base.fpaIsNumeralNegative

-- | Retrieves the sign of a floating-point literal as a bit-vector
-- expression.
fpaGetNumeralSignBv :: MonadZ3 z3 => AST -> z3 AST
fpaGetNumeralSignBv = liftFun1 Base.fpaGetNumeralSignBv

-- | Retrieves the significand of a floating-point literal as a
-- bit-vector expression.
fpaGetNumeralSignificandBv :: MonadZ3 z3 => AST -> z3 AST
fpaGetNumeralSignificandBv = liftFun1 Base.fpaGetNumeralSignificandBv

-- | Return the significand value of a floating-point numeral as a
-- string.
fpaGetNumeralSignificandString :: MonadZ3 z3 => AST -> z3 String
fpaGetNumeralSignificandString = liftFun1 Base.fpaGetNumeralSignificandString

-- | Return the exponent value of a floating-point numeral as a
-- string.
fpaGetNumeralExponentString :: MonadZ3 z3 => AST -> Bool -> z3 String
fpaGetNumeralExponentString = liftFun2 Base.fpaGetNumeralExponentString

-- | Retrieves the exponent of a floating-point literal as a
-- bit-vector expression.
fpaGetNumeralExponentBv :: MonadZ3 z3 => AST -> Bool -> z3 AST
fpaGetNumeralExponentBv = liftFun2 Base.fpaGetNumeralExponentBv

-- | Conversion of a floating-point term into a bit-vector term
-- in IEEE 754-2008 format.
mkFpaToIEEEBv :: MonadZ3 z3 => AST -> z3 AST
mkFpaToIEEEBv = liftFun1 Base.mkFpaToIEEEBv

-- | Conversion of a real-sorted significand and an integer-sorted
-- exponent into a term of FloatingPoint sort.
mkFpaToFpIntReal :: MonadZ3 z3 => AST -> AST -> AST -> Sort -> z3 AST
mkFpaToFpIntReal = liftFun4 Base.mkFpaToFpIntReal

---------------------------------------------------------------------
-- Optimization

class MonadZ3 m => MonadOptimize m where
  getOptimize :: m Base.Optimize

optimizeAssert :: MonadOptimize z3 => AST -> z3 ()
optimizeAssert = liftOptimize1 Base.optimizeAssert

optimizeAssertAndTrack :: MonadOptimize z3 => AST -> AST -> z3 ()
optimizeAssertAndTrack = liftOptimize2 Base.optimizeAssertAndTrack

optimizeAssertSoft :: MonadOptimize z3 => AST -> String -> Symbol -> z3 Int
optimizeAssertSoft = liftOptimize3 Base.optimizeAssertSoft

optimizeMaximize :: MonadOptimize z3 => AST -> z3 Int
optimizeMaximize = liftOptimize1 Base.optimizeMaximize

optimizeMinimize :: MonadOptimize z3 => AST -> z3 Int
optimizeMinimize = liftOptimize1 Base.optimizeMinimize

optimizePush :: MonadOptimize z3 => z3 ()
optimizePush = liftOptimize0 Base.optimizePush

optimizePop :: MonadOptimize z3 => z3 ()
optimizePop = liftOptimize0 Base.optimizePop

optimizeCheck :: MonadOptimize z3 => [AST] -> z3 Result
optimizeCheck = liftOptimize1 Base.optimizeCheck

optimizeGetReasonUnknown :: MonadOptimize z3 => z3 String
optimizeGetReasonUnknown = liftOptimize0 Base.optimizeGetReasonUnknown

optimizeGetModel :: MonadOptimize z3 => z3 Model
optimizeGetModel = liftOptimize0 Base.optimizeGetModel

optimizeGetUnsatCore :: MonadOptimize z3 => z3 [AST]
optimizeGetUnsatCore = liftOptimize0 Base.optimizeGetUnsatCore

optimizeSetParams :: MonadOptimize z3 => Params -> z3 ()
optimizeSetParams = liftOptimize1 Base.optimizeSetParams

optimizeGetLower :: MonadOptimize z3 => Int -> z3 AST
optimizeGetLower = liftOptimize1 Base.optimizeGetLower

optimizeGetUpper :: MonadOptimize z3 => Int -> z3 AST
optimizeGetUpper = liftOptimize1 Base.optimizeGetLower

optimizeGetUpperAsVector :: MonadOptimize z3 => Int -> z3 [AST]
optimizeGetUpperAsVector = liftOptimize1 Base.optimizeGetUpperAsVector

optimizeGetLowerAsVector :: MonadOptimize z3 => Int -> z3 [AST]
optimizeGetLowerAsVector = liftOptimize1 Base.optimizeGetLowerAsVector

optimizeToString :: MonadOptimize z3 => z3 String
optimizeToString = liftOptimize0 Base.optimizeToString

optimizeFromString :: MonadOptimize z3 => String -> z3 ()
optimizeFromString = liftOptimize1 Base.optimizeFromString

optimizeFromFile :: MonadOptimize z3 => String -> z3 ()
optimizeFromFile = liftOptimize1 Base.optimizeFromFile

optimizeGetHelp :: MonadOptimize z3 => z3 String
optimizeGetHelp = liftOptimize0 Base.optimizeGetHelp

optimizeGetAssertions :: MonadOptimize z3 => z3 [AST]
optimizeGetAssertions = liftOptimize0 Base.optimizeGetAssertions

optimizeGetObjectives :: MonadOptimize z3 => z3 [AST]
optimizeGetObjectives = liftOptimize0 Base.optimizeGetObjectives

---------------------------------------------------------------------
-- * Solvers

-- mkSolver :: Context -> IO Solver
-- mkSolver = liftFun0 z3_mk_solver

-- mkSimpleSolver :: Context -> IO Solver
-- mkSimpleSolver = liftFun0 z3_mk_simple_solver

-- mkSolverForLogic :: Context -> Logic -> IO Solver
-- mkSolverForLogic c logic = withContextError c $ \cPtr ->
--   do sym <- mkStringSymbol c (show logic)
--      c2h c =<< z3_mk_solver_for_logic cPtr (unSymbol sym)

-- | Return a string describing all solver available parameters.
solverGetHelp :: MonadZ3 z3 => z3 String
solverGetHelp = liftSolver0 Base.solverGetHelp

-- | Set the solver using the given parameters.
solverSetParams :: MonadZ3 z3 => Params -> z3 ()
solverSetParams = liftSolver1 Base.solverSetParams

-- | Create a backtracking point.
solverPush :: MonadZ3 z3 => z3 ()
solverPush = liftSolver0 Base.solverPush

-- | Backtrack /n/ backtracking points.
solverPop :: MonadZ3 z3 => Int -> z3 ()
solverPop = liftSolver1 Base.solverPop

solverReset :: MonadZ3 z3 => z3 ()
solverReset = liftSolver0 Base.solverReset

-- | Number of backtracking points.
solverGetNumScopes :: MonadZ3 z3 => z3 Int
solverGetNumScopes = liftSolver0 Base.solverGetNumScopes

-- | Assert a constraing into the logical context.
--
-- Reference: <http://research.microsoft.com/en-us/um/redmond/projects/z3/group__capi.html#ga1a05ff73a564ae7256a2257048a4680a>
solverAssertCnstr :: MonadZ3 z3 => AST -> z3 ()
solverAssertCnstr = liftSolver1 Base.solverAssertCnstr

-- | Assert a constraint a into the solver, and track it
-- (in the unsat) core using the Boolean constant /p/.
--
-- This API is an alternative to Z3_solver_check_assumptions
-- for extracting unsat cores. Both APIs can be used in the same
-- solver. The unsat core will contain a combination of the Boolean
-- variables provided using Z3_solver_assert_and_track and the
-- Boolean literals provided using Z3_solver_check_assumptions.
solverAssertAndTrack :: MonadZ3 z3 => AST -> AST -> z3 ()
solverAssertAndTrack = liftSolver2 Base.solverAssertAndTrack

-- | Return the set of asserted formulas on the solver.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga3b3d6d8c5bafd5be707cda2d144073db>
solverGetAssertions :: MonadZ3 z3 => z3 [AST]
solverGetAssertions = liftSolver0 Base.solverGetAssertions

-- | Check whether the assertions in a given solver are consistent or not.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga3570e58a8c3d493da4109568b1eca2ce>
solverCheck :: MonadZ3 z3 => z3 Result
solverCheck = liftSolver0 Base.solverCheck

-- | Check whether the assertions in the given solver and optional assumptions are consistent or not.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga65b2bd980519c0e873d328edcc5f9317>
solverCheckAssumptions :: MonadZ3 z3 => [AST] -> z3 Result
solverCheckAssumptions = liftSolver1 Base.solverCheckAssumptions

-- | Retrieve the model for the last 'solverCheck' or 'solverCheckAssumptions'.
--
-- The error handler is invoked if a model is not available because
-- the commands above were not invoked for the given solver,
-- or if the result was 'Unsat'.
--
-- Reference: <https://z3prover.github.io/api/html/group__capi.html#ga6342b4260e9c92b11cb3eea3a145dff4>
solverGetModel :: MonadZ3 z3 => z3 Model
solverGetModel = liftSolver0 Base.solverGetModel
--
-- | Retrieve the proof for the last 'solverCheck' or 'solverCheckAssumptions'.
--
-- The error handler is invoked if a proof is not available because
-- the commands above were not invoked for the given solver,
-- or if the result was different from 'Unsat' (so 'Sat' does not have a proof).
solverGetProof :: MonadZ3 z3 => z3 AST
solverGetProof = liftSolver0 Base.solverGetProof

-- | Retrieve the unsat core for the last 'solverCheckAssumptions'; the unsat core is a subset of the assumptions
solverGetUnsatCore :: MonadZ3 z3 => z3 [AST]
solverGetUnsatCore = liftSolver0 Base.solverGetUnsatCore

-- | Return a brief justification for an 'Unknown' result for the commands 'solverCheck' and 'solverCheckAssumptions'.
solverGetReasonUnknown :: MonadZ3 z3 => z3 String
solverGetReasonUnknown = liftSolver0 Base.solverGetReasonUnknown

-- | Convert the given solver into a string.
solverToString :: MonadZ3 z3 => z3 String
solverToString = liftSolver0 Base.solverToString

-------------------------------------------------
-- ** Helpers

-- | Create a backtracking point.
--
-- For @push; m; pop 1@ see 'local'.
--
-- Alias for 'solverPush'
push :: MonadZ3 z3 => z3 ()
push = solverPush

-- | Backtrack /n/ backtracking points.
--
-- Contrary to 'solverPop' this funtion checks whether /n/ is within
-- the size of the solver scope stack.
pop :: MonadZ3 z3 => Int -> z3 ()
pop n = do
  scopes <- solverGetNumScopes
  if n <= scopes
    then solverPop n
    else error "Z3.Monad.safePop: too many scopes to backtrack"

-- | Run a query and restore the initial logical context.
--
-- This is a shorthand for 'push', run the query, and 'pop'.
local :: MonadZ3 z3 => z3 a -> z3 a
local q = do
  push
  r <- q
  pop 1
  return r

-- | Backtrack all the way.
--
-- Alias for 'solverReset'
reset :: MonadZ3 z3 => z3 ()
reset = solverReset

-- | Get number of backtracking points.
getNumScopes :: MonadZ3 z3 => z3 Int
getNumScopes = liftSolver0 Base.solverGetNumScopes

-- | Alias for 'solverAssertCnstr'
assert :: MonadZ3 z3 => AST -> z3 ()
assert = solverAssertCnstr

-- | Check whether the given logical context is consistent or not.
--
-- Alias for 'solverCheck'
check :: MonadZ3 z3 => z3 Result
check = solverCheck

-- | Check whether the assertions in the given solver and optional assumptions are consistent or not.
--
-- Alias for 'solverCheckAssumptions'
checkAssumptions :: MonadZ3 z3 => [AST] -> z3 Result
checkAssumptions = solverCheckAssumptions

-- | Call 'solverCheck' and based on the result also call 'solverGetModel'.
solverCheckAndGetModel :: MonadZ3 z3 => z3 (Result, Maybe Model)
solverCheckAndGetModel = liftSolver0 Base.solverCheckAndGetModel

-- | Check and get model.
--
-- Alias for 'solverCheckAndGetModel'
getModel :: MonadZ3 z3 => z3 (Result, Maybe Model)
getModel = solverCheckAndGetModel

-- | Check satisfiability and, if /sat/, compute a value from the given model.
--
-- E.g.
-- @
-- withModel $ \\m ->
--   fromJust \<$\> evalInt m x
-- @
withModel :: (Applicative z3, MonadZ3 z3) =>
                (Base.Model -> z3 a) -> z3 (Result, Maybe a)
withModel f = do
 (r,mb_m) <- getModel
 mb_e <- T.traverse f mb_m
 return (r, mb_e)

-- | Retrieve the unsat core for the last 'checkAssumptions'; the unsat core is a subset of the assumptions.
--
-- Alias for 'solverGetUnsatCore'
getUnsatCore :: MonadZ3 z3 => z3 [AST]
getUnsatCore = solverGetUnsatCore
