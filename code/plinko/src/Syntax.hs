{-# LANGUAGE DeriveGeneric  #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Syntax where

import GHC.Generics
import qualified Data.HashMap.Lazy as Map
import qualified Data.HashSet as Set
import Data.Aeson
import Data.Data
import Text.ParserCombinators.Parsec
import Data.Hashable

-- A local context is a mapping from KQuery identifiers to expressions
type Context = Map.HashMap String KExpr

-- type = "w[0-9]+"
data KType = BitVec {-# UNPACK #-} !Int
           | Boolean
           | Arr KType KType
           | FP {-# UNPACK #-} !Int
           | Unknown
  deriving (Show, Eq, Ord, Data, Typeable, Generic)

instance Hashable KType

data KExpr = VarC !KType !String
           | NumC {-# UNPACK #-} !Int
           | BoolC !Bool
           | Add !KType !KExpr !KExpr
           | Sub !KType !KExpr !KExpr
           | Mul !KType !KExpr !KExpr
           | UDiv !KType !KExpr !KExpr
           | URem !KType !KExpr !KExpr
           | SDiv !KType !KExpr !KExpr
           | SRem !KType !KExpr !KExpr
           | Not !KType !KExpr
           | And !KType !KExpr !KExpr
           | Or !KType !KExpr !KExpr
           | Xor !KType !KExpr !KExpr
           | Shl !KType !KExpr !KExpr
           | LShr !KType !KExpr !KExpr
           | AShr !KType !KExpr !KExpr
           | Eq !KExpr !KExpr
           | Ne !KExpr !KExpr
           | Ult !KExpr !KExpr
           | Ule !KExpr !KExpr
           | Ugt !KExpr !KExpr
           | Uge !KExpr !KExpr
           | Slt !KExpr !KExpr
           | Sle !KExpr !KExpr
           | Sgt !KExpr !KExpr
           | Sge !KExpr !KExpr
           | Concat !KType !KExpr !KExpr
           | Extract !KType {-# UNPACK #-} !Int !KExpr
           | ZExt !KType !KExpr
           | SExt !KType !KExpr
           | ReadLSB !KType !KExpr !KExpr
           | ReadMSB !KType !KExpr !KExpr
           | Read !KType !KExpr !KExpr
           | KArrayUpdate ![(KExpr,KExpr)] !KExpr
           | KArray ![Integer]
           | Select !KType !KExpr !KExpr !KExpr
           | FPExt !KType !KExpr -- mkFpaToFpFloat rmNearestTiesToEven
           | FPTrunc !KType !KExpr -- mkFpaToFpFloat
           | FPToUI !KType !KExpr -- mkFPAToFPUbv
           | FPToSI !KType !KExpr -- mkFPAToFPSbv
           | UIToFP !KType !KExpr -- mkFpaToFpUnsigned
           | SIToFP !KType !KExpr -- mkFpaToFpSigned
           | FSqrt !KExpr 
           | FAbs !KType !KExpr
           | FNeg !KExpr
           | FRint !KExpr -- mkFpaRoundToIntegral
           | IsNaN !KExpr
           | IsInfinite !KExpr
           | IsNormal !KExpr
           | IsSubnormal !KExpr
           | FAdd !KType !KExpr !KExpr
           | FSub !KType !KExpr !KExpr
           | FMul !KType !KExpr !KExpr
           | FDiv !KType !KExpr !KExpr
           | FRem !KType !KExpr !KExpr 
           | FMax !KExpr !KExpr
           | FMin !KExpr !KExpr
           | FOEq !KExpr !KExpr
           | FOLt !KExpr !KExpr 
           | FOLe !KExpr !KExpr
           | FOGt !KExpr !KExpr
           | FOGe !KExpr !KExpr
           deriving (Show, Eq, Ord, Data, Typeable, Generic)

instance Hashable KExpr

newtype JSONPathList = PathList [Path]

data Path = Path { pathNum :: {-# UNPACK #-} !Int
                 , branches :: [Branch]
                 } deriving (Show, Generic)

data Branch = Branch { predicate :: !(Either ParseError KExpr)
                     , nodeTrueQuery :: ![Either ParseError KExpr]
                     , nodeFalseQuery :: ![Either ParseError KExpr]
                     } deriving (Show, Generic)

data WinningPath = WinningPath { winPathNum :: !Int
                               , var :: !(Maybe String)
                               , varVal :: !(Maybe (Either ParseError KExpr))
                               } deriving (Show, Generic)


data DistDef = DistDef { varName :: !String
                       , dist :: Dist
                       , ktype :: !KType
                       } deriving (Show, Generic)

type DistMap = Map.HashMap String (Dist, KType)

data Dist = UniformInt (Either Int String) (Either Int String)
          | Bernoulli (Either Rational String)
          deriving (Show, Eq, Data, Typeable)

type IndPartition = Set.HashSet String
