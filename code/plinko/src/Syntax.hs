{-# LANGUAGE DeriveGeneric  #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Syntax where

import GHC.Generics
import qualified Data.HashMap.Lazy as Map
import qualified Data.HashSet as Set
import Data.Data (Data,Typeable)
import Text.ParserCombinators.Parsec
import Data.Hashable
import Data.Generics.Uniplate.Direct

-- A local context is a mapping from KQuery identifiers to expressions
type Context = Map.HashMap String KExpr

-- type = "w[0-9]+"
data KType = BitVec {-# UNPACK #-} !Int
           | Boolean
           | Arr KType KType
           | FP {-# UNPACK #-} !Int
           | Real
           | Unknown
  deriving (Show, Eq, Ord, Data, Typeable, Generic)

instance Hashable KType

data KExpr = VarC !KType !String
           | NumC !Integer
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
           | Extract !KType !Integer !KExpr
           | ZExt !KType !KExpr
           | SExt !KType !KExpr
           | ReadLSB !KType !KExpr !KExpr
           | ReadMSB !KType !KExpr !KExpr
           | Read !KType !KExpr !KExpr
           | KArrayUpdate ![KExpr] !KExpr
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
           | Iverson !KExpr
           deriving (Show, Eq, Ord, Generic)

instance Hashable KExpr

--plateUnaryWType :: (item -> to -> from) -> item -> to -> Data.Generics.Direct.Type from to
plateUnaryWType cnstr t e = plate cnstr |- t |* e

--plateBinaryWType :: (item -> to -> to -> from) -> item -> to -> to -> Data.Generics.Uniplate.Direct.Type from to
plateBinaryWType cnstr t e1 e2 = plate cnstr |- t |* e1 |* e2

--plateBinary :: (to -> to -> from) -> to -> to -> Data.Generics.Uniplate.Direct.Type from to
plateBinary cnstr e1 e2 = plate cnstr |* e1 |* e2

instance Uniplate KExpr where
  uniplate (VarC t s) = plate VarC |- t |- s
  uniplate (NumC n) = plate NumC |- n
  uniplate (BoolC b) = plate BoolC |- b
  uniplate (Add t e1 e2) = plateBinaryWType Add t e1 e2
  uniplate (Sub t e1 e2) = plateBinaryWType Sub t e1 e2
  uniplate (Mul t e1 e2) = plateBinaryWType Mul t e1 e2
  uniplate (UDiv t e1 e2) = plateBinaryWType UDiv t e1 e2
  uniplate (URem t e1 e2) = plateBinaryWType URem t e1 e2
  uniplate (SDiv t e1 e2) = plateBinaryWType SDiv t e1 e2
  uniplate (SRem t e1 e2) = plateBinaryWType SRem t e1 e2
  uniplate (Not t e) = plateUnaryWType Not t e
  uniplate (And t e1 e2) = plateBinaryWType And t e1 e2
  uniplate (Or t e1 e2) = plateBinaryWType Or t e1 e2
  uniplate (Xor t e1 e2) = plateBinaryWType Xor t e1 e2   
  uniplate (Shl t e1 e2) = plateBinaryWType Shl t e1 e2   
  uniplate (LShr t e1 e2) = plateBinaryWType LShr t e1 e2   
  uniplate (AShr t e1 e2) = plateBinaryWType AShr t e1 e2
  uniplate (Eq e1 e2) = plateBinary Eq e1 e2
  uniplate (Ne e1 e2) = plateBinary Ne e1 e2
  uniplate (Ult e1 e2) = plateBinary Ult e1 e2
  uniplate (Ule e1 e2) = plateBinary Ule e1 e2
  uniplate (Ugt e1 e2) = plateBinary Ugt e1 e2
  uniplate (Uge e1 e2) = plateBinary Uge e1 e2
  uniplate (Slt e1 e2) = plateBinary Slt e1 e2
  uniplate (Sle e1 e2) = plateBinary Sle e1 e2
  uniplate (Sgt e1 e2) = plateBinary Sgt e1 e2
  uniplate (Sge e1 e2) = plateBinary Sge e1 e2
  uniplate (Concat t e1 e2) = plateBinaryWType Concat t e1 e2
  uniplate (Extract t n e) = plate Extract |- t |- n |* e
  uniplate (ZExt t e) = plateUnaryWType ZExt t e
  uniplate (SExt t e) = plateUnaryWType SExt t e
  uniplate (ReadLSB t e1 e2) = plateBinaryWType ReadLSB t e1 e2
  uniplate (ReadMSB t e1 e2) = plateBinaryWType ReadMSB t e1 e2
  uniplate (Read t e1 e2) = plateBinaryWType Read t e1 e2
  uniplate (KArrayUpdate es e) = plate KArrayUpdate ||* es |* e
  uniplate (KArray xs) = plate KArray |- xs
  uniplate (Select t e1 e2 e3) = plate Select |- t |* e1 |* e2 |* e3
  uniplate (FPExt t e) = plateUnaryWType FPExt t e
  uniplate (FPTrunc t e) = plateUnaryWType FPTrunc t e
  uniplate (FPToUI t e) = plateUnaryWType FPToUI t e
  uniplate (FPToSI t e) = plateUnaryWType FPToSI t e
  uniplate (UIToFP t e) = plateUnaryWType UIToFP t e
  uniplate (SIToFP t e) = plateUnaryWType SIToFP t e
  uniplate (FSqrt e) = plate FSqrt |* e
  uniplate (FAbs t e) = plateUnaryWType FAbs t e
  uniplate (FNeg e) = plate FNeg |* e
  uniplate (FRint e) = plate FRint |* e
  uniplate (IsNaN e) = plate IsNaN |* e
  uniplate (IsInfinite e) = plate IsInfinite |* e
  uniplate (IsNormal e) = plate IsNormal |* e
  uniplate (IsSubnormal e) = plate IsSubnormal |* e
  uniplate (FAdd t e1 e2) = plateBinaryWType FAdd t e1 e2
  uniplate (FSub t e1 e2) = plateBinaryWType FSub t e1 e2
  uniplate (FMul t e1 e2) = plateBinaryWType FMul t e1 e2
  uniplate (FDiv t e1 e2) = plateBinaryWType FDiv t e1 e2
  uniplate (FRem t e1 e2) = plateBinaryWType FRem t e1 e2
  uniplate (FMax e1 e2) = plateBinary FMax e1 e2
  uniplate (FMin e1 e2) = plateBinary FMin e1 e2
  uniplate (FOEq e1 e2) = plateBinary FOEq e1 e2
  uniplate (FOLt e1 e2) = plateBinary FOLt e1 e2
  uniplate (FOLe e1 e2) = plateBinary FOLe e1 e2
  uniplate (FOGt e1 e2) = plateBinary FOGt e1 e2
  uniplate (FOGe e1 e2) = plateBinary FOGe e1 e2
  uniplate (Iverson e) = plate Iverson |* e
newtype JSONPathList = PathList [Path]

data Path = Path { pathNum :: {-# UNPACK #-} !Int
                 , branches :: [Branch]
                 , obsVal :: Maybe ObservedValue
                 } deriving (Show, Generic)

data Branch = Branch { predicate :: !(Either ParseError KExpr)
                     , nodeTrueQuery :: ![Either ParseError KExpr]
                     , nodeFalseQuery :: ![Either ParseError KExpr]
                     } deriving (Show, Generic)

data ObservedValue = ObservedValue { var :: !String
                                   , varVal :: Either ParseError KExpr
                                   } deriving (Show, Eq, Generic)

newtype WinningPath = WinningPath { winPathNum :: Int
                                  } deriving (Show, Generic)


data DistDef = DistDef { varName :: !String
                       , dist :: Dist
                       , ktype :: !KType
                       } deriving (Show, Eq, Generic)

instance Hashable DistDef

type DistMap = Map.HashMap String (Dist, KType)

data Dist = UniformInt (Either Integer String) (Either Integer String)
          | Bernoulli (Either Rational String)
          deriving (Show, Eq, Data, Typeable, Generic)

instance Hashable Dist

type IndPartition = Set.HashSet String
