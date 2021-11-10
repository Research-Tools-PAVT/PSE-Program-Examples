module Convert where

import Syntax

--import Data.Bifunctor ( bimap )
import Control.Monad ( foldM, (>=>) )
import Z3.Monad
--import Data.Either
import qualified Data.Map as Map
import qualified Data.Binary as Bin
import qualified Data.ByteString.Lazy as BS
import GHC.Stack
import Debug.Trace

mergePathsWithProbs :: Z3 [AST] -> Maybe (Z3 [AST]) -> Z3 [AST] -> Z3 AST
mergePathsWithProbs probs (Just expect) pathAssumes = do
  probsAsASTs <- probs
  expectAsASTs <- expect
  valsAsInts <- mapM (\v -> mkBv2int v True >>= mkInt2Real) expectAsASTs
  eachExpect <- mapM (\(prob,val) -> mkMul [prob,val]) $ zip probsAsASTs valsAsInts

  pathAssumesASTs <- pathAssumes
  _0 <- mkRealNum (0 :: Double)
  (mapM (\(cond,val) -> mkIte cond val _0) $ zip pathAssumesASTs eachExpect) >>= mkAdd
mergePathsWithProbs probs Nothing pathAssumes = do
  probsAsASTs <- probs
  pathAssumesASTs <- pathAssumes
  _0 <- mkRealNum (0 :: Double)
  (mapM (\(cond,prob) -> mkIte cond prob _0) $ zip pathAssumesASTs probsAsASTs) >>= mkAdd

valsToZ3 :: (KType, [Integer]) -> Z3 [AST]
valsToZ3 (BitVec n, xs) = mapM (mkBvNum n) xs
valsToZ3 (Boolean, _) = error $ "Type Error: Cannot convert Integers into boolean values"
valsToZ3 (Arr (BitVec domSize) (BitVec rangeSize), xs) = mapM intToZ3Arr xs
  where intToZ3Arr :: Integer -> Z3 AST
        intToZ3Arr i = do
          iAsBytes <- mapM (mkBvNum rangeSize) (dropWhile ((==) 0) $ BS.unpack $ Bin.encode i)
          inds <- mapM (mkBvNum domSize) (reverse [ 8*x | x <- [0..length iAsBytes - 1]])
          domSort <- mkBvSort domSize
          _0 <- mkBvNum rangeSize (0 :: Integer)
          constArr <- mkConstArray domSort _0
          simplify =<< (foldM (\a -> \(i',v) -> mkStore a i' v) constArr (zip inds iAsBytes))
valsToZ3 (t,_) = error $ "Type Error: Unsupported PSV type: " ++ show t
                           
varToSort :: DistDef -> Z3 AST
varToSort d = case ktype d of
  (BitVec n) -> (mkStringSymbol >=> flip mkBvVar n) $ varName d
  Boolean -> (mkStringSymbol >=> mkBoolVar) $ varName d
  (Arr (BitVec domSize) (BitVec rangeSize)) -> do
    domSort <- mkBvSort domSize
    rangeSort <- mkBvSort rangeSize
    arrSort <- mkArraySort domSort rangeSort
    funcDec <- mkStringSymbol (varName d) >>= (\s -> mkFuncDecl s [] arrSort)
    mkApp funcDec []
  t -> error $ "Type Error: Unsupported P.S.V. type: " ++ show t

convertToZ3 :: MonadZ3 z3 => DistMap -> KExpr -> z3 AST
convertToZ3 dists k = convertToZ3' dists Boolean k

binaryConvert :: MonadZ3 z3 => DistMap -> KType -> (AST -> AST -> z3 AST) -> KExpr -> KExpr -> z3 AST
binaryConvert dists t z3fun e1 e2 = do
  z1 <- convertToZ3'' dists t e1
  z2 <- convertToZ3'' dists t e2
  z3fun z1 z2

fpBinaryConvert :: MonadZ3 z3 => DistMap -> KType -> (AST -> AST -> AST -> z3 AST) -> KExpr -> KExpr -> z3 AST
fpBinaryConvert dists t z3fun e1 e2 = do
  rm <- mkFpaRoundNearestTiesToEven
  z1 <- convertToZ3'' dists t e1
  z2 <- convertToZ3'' dists t e2
  z3fun rm z1 z2

convertToZ3'' :: MonadZ3 z3 => DistMap -> KType -> KExpr -> z3 AST
convertToZ3'' dists m ke = convertToZ3' dists m ke

convertToZ3' :: MonadZ3 z3 => DistMap -> KType -> KExpr -> z3 AST
convertToZ3' dists t1 (VarC t2 s) 
  | t1 == t2 || t1 == Unknown = case Map.lookup s dists of
      (Just (_,actualT)) -> if actualT == t2 
        then case actualT of
               (BitVec n) -> mkStringSymbol s >>= flip mkBvVar n
               Boolean -> mkStringSymbol s >>= mkBoolVar
               (Arr (BitVec domSize) (BitVec rangeSize)) -> do
                 domSort <- mkBvSort domSize
                 rangeSort <- mkBvSort rangeSize
                 arrSort <- mkArraySort domSort rangeSort
                 funcDec <- mkStringSymbol s >>= (\s' -> mkFuncDecl s' [] arrSort)
                 mkApp funcDec []
               (Arr dom range) -> error $ "Unsupported domain or range type(s):\nDomain: " ++ show dom ++ "\nRange: " ++ show range
               _ -> error $ "Unsupported variable type: " ++ show actualT
        else error ("Distribution types do not match: " ++ show actualT ++ " != " ++ show t2)
      Nothing -> case t2 of
        (BitVec n) -> mkStringSymbol s >>= flip mkBvVar n
        Boolean -> mkStringSymbol s >>= mkBoolVar
        (Arr (BitVec domSize) (BitVec rangeSize)) -> do
          domSort <- mkBvSort domSize
          rangeSort <- mkBvSort rangeSize
          arrSort <- mkArraySort domSort rangeSort
          funcDec <- mkStringSymbol s >>= (\s' -> mkFuncDecl s' [] arrSort)
          mkApp funcDec []
        (Arr dom range) -> error $ "Unsupported domain or range type(s):\nDomain: " ++ show dom ++ "\nRange: " ++ show range
        _ -> error $ "Unsupported variable type: " ++ show t2
  | t2 == Unknown =  case Map.lookup s dists of
      (Just (_,actualT)) -> if actualT == t2 
        then case actualT of
               (BitVec n) -> mkStringSymbol s >>= flip mkBvVar n
               Boolean -> mkStringSymbol s >>= mkBoolVar
               (Arr (BitVec domSize) (BitVec rangeSize)) -> do
                 domSort <- mkBvSort domSize
                 rangeSort <- mkBvSort rangeSize
                 arrSort <- mkArraySort domSort rangeSort
                 funcDec <- mkStringSymbol s >>= (\s' -> mkFuncDecl s' [] arrSort)
                 mkApp funcDec []
               (Arr dom range) -> error $ "Unsupported domain or range type(s):\nDomain: " ++ show dom ++ "\nRange: " ++ show range
               _ -> error $ "Unsupported variable type: " ++ show actualT
        else error ("Distribution types do not match: " ++ show actualT ++ " != " ++ show t2)
      Nothing -> mkStringSymbol s >>= flip mkBvVar 32
  | otherwise = error ("Variable type mismatch: Expected = " ++ show t1 ++ ", Actual = " ++ show t2 ++ " in, " ++ show (VarC t2 s))
convertToZ3' _ (BitVec s) (NumC n) = mkBvNum s n
convertToZ3' _ (FP s) (NumC n) = do
--  rm <- mkFpaRoundNearestTiesToEven
  sort <- convertBitsizeToFP s
  bv <- mkBvNum s n
  mkFpaToFpBv bv sort
convertToZ3' _ Unknown (NumC n) = mkBvNum 8 n
convertToZ3' _ t (NumC n) = error $ "Type Error: Cannot cast a " ++ show (NumC n) ++ " to " ++ show t
convertToZ3' _ Boolean (BoolC b) = mkBool b
convertToZ3' _ t (BoolC b) = error $ "Type Error: Cannot cast a " ++ show (BoolC b) ++ " to " ++ show t
convertToZ3' dists t1 e@(Add t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvadd e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1@(BitVec _) e@(Sub t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvsub e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists (FP s) (Sub t e1 e2) = do
  bv <- binaryConvert dists t mkBvsub e1 e2
  sort <- convertBitsizeToFP s
  mkFpaToFpBv bv sort
convertToZ3' dists t1 e@(Mul t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvmul e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(UDiv t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvudiv e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(URem t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvurem e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(SDiv t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvsdiv e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(SRem t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkBvsrem e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(Not t2 e') 
  | t1 == t2 || t1 == Unknown = convertToZ3'' dists t2 e' >>= mkBvnot
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n) e@(And t2 e1 e2) = case t2 of
  BitVec n' -> if n == n'
               then binaryConvert dists t2 mkBvand e1 e2
               else typeError t1 t2 e
  _ -> typeError t1 t2 e
convertToZ3' dists Boolean (And _ e1 e2) = mapM (convertToZ3'' dists Boolean) [e1,e2] >>= mkAnd
convertToZ3' dists t1@(BitVec n) e@(Or t2 e1 e2) = case t2 of
  BitVec n' -> if n == n'
               then binaryConvert dists t2 mkBvor e1 e2
               else typeError t1 t2 e
  _ -> typeError t1 t2 e
convertToZ3' dists Unknown (Or t e1 e2) = binaryConvert dists t mkBvor e1 e2
convertToZ3' dists Boolean (Or _ e1 e2) = mapM (convertToZ3'' dists Boolean) [e1,e2] >>= mkOr
convertToZ3' dists t1@(BitVec n) e@(Xor t2 e1 e2) = case t2 of
  BitVec n' -> if n == n'
               then binaryConvert dists t2 mkBvxor e1 e2
               else typeError t1 t2 e
  _ -> typeError t1 t2 e
convertToZ3' dists Boolean (Xor _ e1 e2) = binaryConvert dists Boolean mkXor e1 e2
convertToZ3' dists t1@(BitVec n1) e@(Shl t2@(BitVec n2) e1 e2)
  | n1 == n2 = binaryConvert dists t2 mkBvshl e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (Shl t e1 e2) = binaryConvert dists t mkBvshl e1 e2
convertToZ3' dists t1@(BitVec n1) e@(LShr t2@(BitVec n2) e1 e2) 
  | n1 == n2 = binaryConvert dists t2 mkBvlshr e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (LShr t e1 e2) = binaryConvert dists t mkBvlshr e1 e2
convertToZ3' dists t1@(BitVec n1) e@(AShr t2@(BitVec n2) e1 e2)
  | n1 == n2 = binaryConvert dists t2 mkBvashr e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t (Eq e1 e2) = convertComparison dists t mkEq e1 e2
convertToZ3' dists t (Ne e1 e2) = convertComparison dists t (\a1 -> \a2 -> mkEq a1 a2 >>= mkNot) e1 e2
convertToZ3' dists t (Ult e1 e2) = convertComparison dists t mkBvult e1 e2
convertToZ3' dists t (Ule e1 e2) = convertComparison dists t mkBvule e1 e2
convertToZ3' dists t (Ugt e1 e2) = convertComparison dists t mkBvugt e1 e2
convertToZ3' dists t (Uge e1 e2) = convertComparison dists t mkBvuge e1 e2
convertToZ3' dists t (Slt e1 e2) = convertComparison dists t mkBvslt e1 e2
convertToZ3' dists t (Sle e1 e2) = convertComparison dists t mkBvsle e1 e2
convertToZ3' dists t (Sgt e1 e2) = convertComparison dists t mkBvsgt e1 e2
convertToZ3' dists t (Sge e1 e2) = convertComparison dists t mkBvsge e1 e2
convertToZ3' dists t1@(BitVec n1) e@(Concat t2@(BitVec n2) e1 e2)
  | n1 == n2 = do
      z3e1 <- convertToZ3'' dists Unknown e1
      e1bvSize <- getSort z3e1 >>= getBvSortSize
      z3e2 <- convertToZ3'' dists (BitVec $ n2 - e1bvSize) e2
      mkConcat z3e1 z3e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (Concat (BitVec n) e1 e2) = do
  z3e1 <- convertToZ3'' dists Unknown e1
  e1bvSize <- getSort z3e1 >>= getBvSortSize
  z3e2 <- convertToZ3'' dists (BitVec $ n - e1bvSize) e2
  mkConcat z3e1 z3e2
convertToZ3' _ t1 e@(Concat t2 _ _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n1) e@(Extract t2@(BitVec high) low e')
  | n1 == high = convertToZ3'' dists Unknown e' >>= mkExtract (low + high - 1) low
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (Extract (BitVec high) low e) = convertToZ3'' dists Unknown e >>= mkExtract (low + high - 1) low
convertToZ3' _ t1 e@(Extract t2 _ _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n1) e@(ZExt t2@(BitVec n2) e')
  | n1 == n2 = do
      child <- convertToZ3'' dists Unknown e'
      childSort <- getSort child
      curSize <- getBvSortSize childSort
      mkZeroExt (n2 - curSize) child
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (ZExt (BitVec n) e) = do
  child <- convertToZ3'' dists Unknown e
  childSort <- getSort child
  curSize <- getBvSortSize childSort
  mkZeroExt (n - curSize) child
convertToZ3' _ t1 e@(ZExt t2 _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n1) e@(SExt t2@(BitVec n2) e')
  | n1 == n2 = do
      child <- convertToZ3'' dists Unknown e'
      childSort <- getSort child
      curSize <- getBvSortSize childSort
      mkSignExt (n2 - curSize) child
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (SExt (BitVec n) e) = do
  child <- convertToZ3'' dists Unknown e
  childSort <- getSort child
  curSize <- getBvSortSize childSort
  mkSignExt (n - curSize) child
convertToZ3' _ t1 e@(SExt t2 _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n1) e@(ReadLSB t2@(BitVec n2) ind arr)
  | n1 == n2 = do
      arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
--      mulOffset <- mkBvNum 32 8
--      ind' <- (mkBvmul mulOffset) =<< (convertToZ3'' dists (BitVec 32) ind)
      ind' <- convertToZ3'' dists (BitVec 32) ind
      inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(n2 `div` 8) - 1]
      vals <- mapM (mkSelect arr') (ind':inds)
      --str <- getSort (head vals) >>= sortToString
      foldM (flip mkConcat) (head vals) (tail vals)
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (ReadLSB (BitVec t) ind arr) = do
  arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
--  mulOffset <- mkBvNum 32 8
--  ind' <- (mkBvmul mulOffset) =<< (convertToZ3'' dists (BitVec 32) ind)
  ind' <- convertToZ3'' dists (BitVec 32) ind
  inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(t `div` 8) - 1]
  vals <- mapM (mkSelect arr') (ind':inds)
  foldM (flip mkConcat) (head vals) (tail vals)
convertToZ3' dists (FP s) (ReadLSB (BitVec t) ind arr) = do
  arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
  ind' <- convertToZ3'' dists (BitVec 32) ind
  inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(t `div` 8) - 1]
  vals <- mapM (mkSelect arr') (ind':inds)
  bv <- foldM (flip mkConcat) (head vals) (tail vals)
  sort <- convertBitsizeToFP s
  mkFpaToFpBv bv sort
convertToZ3' _ t1 e@(ReadLSB t2 _ _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec n1) e@(ReadMSB t2@(BitVec n2) ind arr) 
  | n1 == n2 = do
      arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
      ind' <- convertToZ3'' dists (BitVec 32) ind
      inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(n2 `div` 8) - 1]
      vals <- mapM (mkSelect arr') (reverse (ind':inds))
      foldM (flip mkConcat) (head vals) (tail vals)
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (ReadMSB (BitVec t) ind arr) = do
  arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
  ind' <- convertToZ3'' dists (BitVec 32) ind
  inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(t `div` 8) - 1]
  vals <- mapM (mkSelect arr') (reverse (ind':inds))
  foldM (flip mkConcat) (head vals) (tail vals)
convertToZ3' dists (FP _) (ReadMSB (BitVec t) ind arr) = do
  arr' <- convertToZ3'' dists (Arr (BitVec 32) (BitVec 8)) arr
  ind' <- convertToZ3'' dists (BitVec 32) ind
  inds <- mapM (\n -> mkBvNum 32 n >>= mkBvadd ind') [1..(t `div` 8) - 1]
  vals <- mapM (mkSelect arr') (reverse (ind':inds))
  foldM (flip mkConcat) (head vals) (tail vals)
convertToZ3' _ t1 e@(ReadMSB t2 _ _) = typeError t1 t2 e
convertToZ3' dists t1@(BitVec _) e@(Read t2 i arr) 
  | t1 == t2 = do
      a <- convertToZ3'' dists (Arr (BitVec 32) t2) arr
      iAST <- convertToZ3'' dists (BitVec 32) i
      mkSelect a iAST
  | otherwise = typeError t1 t2 e
convertToZ3' dists Unknown (Read t i arr) = do
  a <- convertToZ3'' dists (Arr (BitVec 32) t) arr
  iAST <- convertToZ3'' dists (BitVec 32) i
  mkSelect a iAST
convertToZ3' dists (FP _) (Read t i arr) = do
  a <- convertToZ3'' dists (Arr (BitVec 32) t) arr
  iAST <- convertToZ3'' dists (BitVec 32) i
  mkSelect a iAST
convertToZ3' _ t1 e@(Read t2 _ _) = typeError t1 t2 e
convertToZ3' dists t (KArrayUpdate ((ind,val):xs) arr) = do
  a <- convertToZ3'' dists t (KArrayUpdate xs arr)
  i <- convertToZ3'' dists (BitVec 32) ind
  v <- convertToZ3'' dists Unknown val
  mkStore a i v
convertToZ3' dists t (KArrayUpdate [] arr) = convertToZ3'' dists t arr
convertToZ3' _ _ (KArray xs) = do
  arrSort <- mkBvSort 32
  _0 <- mkBvNum 8 (0 :: Integer)
  arr <- mkConstArray arrSort _0
  inds <- mapM (mkBvNum 32) [0..((length xs) - 1)]
  vals <- mapM (mkBvNum 8) xs
  foldM (uncurry . mkStore) arr (zip inds vals)
convertToZ3' dists t1@(BitVec _) e@(Select t2 cond tru fls)
  | t1 == t2 = do
      cond' <- convertToZ3'' dists Boolean cond
      tru'  <- convertToZ3'' dists t2 tru
      fls'  <- convertToZ3'' dists t2 fls
      mkIte cond' tru' fls'
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1@(FP _) e@(Select _ cond tru fls) = do
      cond' <- convertToZ3'' dists Boolean cond
      tru'  <- convertToZ3'' dists t1 tru
      fls'  <- convertToZ3'' dists t1 fls
      mkIte cond' tru' fls'
convertToZ3' dists Unknown (Select t cond tru fls) = do
  cond' <- convertToZ3'' dists Boolean cond
  tru'  <- convertToZ3'' dists t tru
  fls'  <- convertToZ3'' dists t fls
  mkIte cond' tru' fls'
convertToZ3' dists t1@(FP n) e'@(FPExt t2@(FP _) e)
  | t1 == t2 = do
      rm <- mkFpaRoundNearestTiesToEven
      sort <- convertBitsizeToFP n
      eAst <- convertToZ3'' dists t1 e
      mkFpaToFpFloat rm eAst sort
  | otherwise = typeError t1 t2 e'
convertToZ3' dists Unknown (FPExt t@(FP n) e) = do
  rm <- mkFpaRoundNearestTiesToEven
  sort <- convertBitsizeToFP n
  e' <- convertToZ3'' dists t e
  mkFpaToFpFloat rm e' sort
convertToZ3' dists t1@(FP n) e'@(FPTrunc t2@(FP _) e)
  | t1 == t2 = do
      rm <- mkFpaRoundNearestTiesToEven
      sort <- convertBitsizeToFP n
      eAst <- convertToZ3'' dists t1 e
      mkFpaToFpFloat rm eAst sort
  | otherwise = typeError t1 t2 e'
convertToZ3' dists Unknown (FPTrunc t@(FP n) e) = do
  rm <- mkFpaRoundNearestTiesToEven
  sort <- convertBitsizeToFP n
  e' <- convertToZ3'' dists t e
  mkFpaToFpFloat rm e' sort
convertToZ3' dists (BitVec n) (FPToUI t2 e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t2 e
  mkFpaToUbv rm e' n
convertToZ3' dists (BitVec n) (FPToSI t2 e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t2 e
  mkFpaToSbv rm e' n
convertToZ3' dists (FP n) (UIToFP t2 e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t2 e
  sort <- convertBitsizeToFP n
  mkFpaToFpUnsigned rm e' sort
convertToZ3' dists Unknown (UIToFP t e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t e
  sort <- convertBitsizeToFP 32
  mkFpaToFpUnsigned rm e' sort
convertToZ3' dists (FP n) (SIToFP t2 e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t2 e
  sort <- convertBitsizeToFP n
  mkFpaToFpSigned rm e' sort
convertToZ3' dists Unknown (SIToFP t e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t e
  sort <- convertBitsizeToFP 32 -- assuming normal 32-bit float
  mkFpaToFpSigned rm e' sort
convertToZ3' dists t@(FP _) (FSqrt e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists t e
  mkFpaSqrt rm e'
convertToZ3' dists Unknown (FSqrt e) = do
  rm <- mkFpaRoundNearestTiesToEven
  e' <- convertToZ3'' dists (FP 32) e -- assuming normal 32-bit float
  mkFpaSqrt rm e'
convertToZ3' dists t1@(FP _) (FAbs t2 e)
  | t1 == t2 = mkFpaAbs =<< convertToZ3'' dists t2 e
  | otherwise = typeError t1 t2 (FAbs t2 e)
convertToZ3' dists Unknown (FAbs t' e) = case getKType e of
  FP n -> mkFpaAbs =<< convertToZ3'' dists (FP n) e
  t -> typeError (FP 32) t (FAbs t' e)
convertToZ3' dists t@(FP _) (FNeg e)
  | t == (getKType e) = mkFpaNeg =<< convertToZ3'' dists t e
  | otherwise = typeError t (getKType e) (FNeg e)
convertToZ3' dists Unknown (FNeg e) = case getKType e of
  FP n -> mkFpaNeg =<< convertToZ3'' dists (FP n) e
  t -> typeError (FP 32) t (FNeg e)
convertToZ3' dists t@(FP _) e'@(FRint e)
  | t == (getKType e) || Unknown == (getKType e) = do
      rm <- mkFpaRoundNearestTiesToEven
      eAst <- convertToZ3'' dists t e
      mkFpaRoundToIntegral rm eAst
  | otherwise = typeError t (getKType e) e'
convertToZ3' dists Unknown e'@(FRint e) = case getKType e of
  FP n -> do rm <- mkFpaRoundNearestTiesToEven
             eAst <- convertToZ3'' dists (FP n) e
             mkFpaRoundToIntegral rm eAst
  t -> typeError (FP 32) t e'
convertToZ3' dists _ (IsNaN e) = mkFpaIsNaN =<< convertToZ3'' dists Unknown e
convertToZ3' dists _ (IsInfinite e) = mkFpaIsInfinite =<< convertToZ3'' dists Unknown e
convertToZ3' dists _ (IsNormal e) = mkFpaIsNormal =<< convertToZ3'' dists Unknown e
convertToZ3' dists _ (IsSubnormal e) = mkFpaIsSubnormal =<< convertToZ3'' dists Unknown e
convertToZ3' dists t1 e@(FAdd t2 e1 e2)
  | t1 == t2 || t1 == Unknown = fpBinaryConvert dists t2 mkFpaAdd e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1@(FP _) e@(FSub t2 e1 e2)
  | t1 == t2 = fpBinaryConvert dists t2 mkFpaSub e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists (BitVec _) (FSub t e1 e2) = mkFpaToIEEEBv =<< fpBinaryConvert dists t mkFpaSub e1 e2
convertToZ3' dists Unknown (FSub t e1 e2) = fpBinaryConvert dists t mkFpaSub e1 e2
convertToZ3' dists t1 e@(FMul t2 e1 e2)
  | t1 == t2 || t1 == Unknown = fpBinaryConvert dists t2 mkFpaMul e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(FDiv t2 e1 e2)
  | t1 == t2 || t1 == Unknown = fpBinaryConvert dists t2 mkFpaDiv e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 e@(FRem t2 e1 e2)
  | t1 == t2 || t1 == Unknown = binaryConvert dists t2 mkFpaRem e1 e2
  | otherwise = typeError t1 t2 e
convertToZ3' dists t1 (FMin e1 e2) = binaryConvert dists t1 mkFpaMin e1 e2
convertToZ3' dists t1 (FMax e1 e2) = binaryConvert dists t1 mkFpaMax e1 e2
convertToZ3' dists _ (FOEq e1 e2) = convertFpComparison dists mkFpaEq e1 e2
convertToZ3' dists _ (FOLt e1 e2) = convertFpComparison dists mkFpaLt e1 e2
convertToZ3' dists _ (FOLe e1 e2) = convertFpComparison dists mkFpaLeq e1 e2
convertToZ3' dists _ (FOGt e1 e2) = convertFpComparison dists mkFpaGt e1 e2
convertToZ3' dists _ (FOGe e1 e2) = convertFpComparison dists mkFpaGeq e1 e2
convertToZ3' _ t e  = error ("Cannot convert " ++ show e ++ " into a Z3 AST " ++ show t)

typeError :: (Show a1, Show a2, Show a3) => a1 -> a2 -> a3 -> a4
typeError t1 t2 k =  error $ "Type Error: Expected type " ++ show t1 ++ "\nActual Type: " ++ show t2 ++ "\nin " ++ show k

convertFpComparison :: MonadZ3 z3 => DistMap -> (AST -> AST -> z3 AST) -> KExpr -> KExpr -> z3 AST
convertFpComparison dists z3Fun e1 e2 = case (getKType e1, getKType e2) of
  (FP s, _) -> helper s
  (_, FP s) -> helper s
  (BitVec s, _) -> helper s
  (_, BitVec s) -> helper s
  (t1,t2) -> typeError t1 t2 (e1,e2)
  where helper s = do
          ast1 <- convertToZ3'' dists (FP s) e1
          ast2 <- convertToZ3'' dists (FP s) e2
          z3Fun ast1 ast2

convertComparison :: MonadZ3 z3 => DistMap -> KType -> (AST -> AST -> z3 AST) -> KExpr -> KExpr -> z3 AST
convertComparison dists (BitVec 1) z3Fun e1 e2 = case (getKType e1, getKType e2) of
  (t, Unknown) -> helper t
  (Unknown, t) -> helper t
  (t1, t2) -> if (t1 == t2) && (t1 /= Unknown)
              then helper t1
              else error $ "Unknown subexpression types for " ++ show e1 ++ " and " ++ show e2
  where helper t = do
          _1 <- mkBvNum 1 (1 :: Integer)
          _0 <- mkBvNum 1 (0 :: Integer)
          z3e1 <- convertToZ3'' dists t e1
          z3e2 <- convertToZ3'' dists t e2
          res <- z3Fun z3e1 z3e2
          mkIte res _1 _0
convertComparison dists Unknown z3Fun e1 e2 = case (getKType e1, getKType e2) of
  (t, Unknown) -> helper t
  (Unknown, t) -> helper t
  (t1, t2) -> if (t1 == t2) && (t1 /= Unknown)
              then helper t1
              else error $ "Unknown subexpression types for " ++ show e1 ++ " and " ++ show e2
  where helper t = do
          _1 <- mkBvNum 1 (1 :: Integer)
          _0 <- mkBvNum 1 (0 :: Integer)
          z3e1 <- convertToZ3'' dists t e1
          z3e2 <- convertToZ3'' dists t e2
          res <- z3Fun z3e1 z3e2
          mkIte res _1 _0          
convertComparison dists Boolean z3Fun e1 e2 = case (getKType e1, getKType e2) of
  (t, Unknown) -> helper t
  (Unknown, t) -> helper t
  (t1, t2) -> if (t1 == t2) && (t1 /= Unknown)
              then helper t1
              else error $ "Unknown subexpression types for " ++ show e1 ++ " and " ++ show e2
  where helper t = do
          z3e1 <- convertToZ3'' dists t e1
          z3e2 <- convertToZ3'' dists t e2
          z3Fun z3e1 z3e2
convertComparison _ t _ _ _ = error $ "Unsupported resultant type: " ++ show t

getKType :: KExpr -> KType
getKType (VarC t _) = t
getKType (BoolC _) = Boolean
getKType (NumC _) = Unknown
getKType (Add t _ _) = t
getKType (Sub t _ _) = t
getKType (Mul t _ _) = t
getKType (UDiv t _ _) = t
getKType (URem t _ _) = t
getKType (SDiv t _ _) = t
getKType (SRem t _ _) = t
getKType (Not Unknown e) = getKType e
getKType (Not t _) = t
getKType (And Unknown e _) = getKType e
getKType (And t _ _) = t
getKType (Or Unknown e _) = getKType e
getKType (Or t _ _) = t
getKType (Xor Unknown e _) = getKType e
getKType (Xor t _ _) = t
getKType (Shl Unknown e _) = getKType e
getKType (Shl t _ _) = t
getKType (LShr Unknown e _) = getKType e
getKType (LShr t _ _) = t
getKType (AShr Unknown e _) = getKType e
getKType (AShr t _ _) = t
getKType (Eq _ _) = Boolean
getKType (Ne _ _) = Boolean
getKType (Ult _ _) = Boolean
getKType (Ule _ _) = Boolean
getKType (Ugt _ _) = Boolean
getKType (Uge _ _) = Boolean
getKType (Slt _ _) = Boolean
getKType (Sle _ _) = Boolean
getKType (Sgt _ _) = Boolean
getKType (Sge _ _) = Boolean
getKType (Concat Unknown e1 e2) = case (getKType e1, getKType e2) of
  (BitVec n1, BitVec n2) -> BitVec $ n1 + n2
  (_,_) -> Unknown
getKType (Concat t _ _) = t
getKType (Extract t _ _) = t
getKType (ZExt t _) = t
getKType (SExt t _) = t
getKType (ReadLSB t _ _) = t
getKType (ReadMSB t _ _) = t
getKType (Read t _ _) = t
getKType (KArrayUpdate ((i,val):_) _) = Arr (getKType i) (getKType val)
getKType (KArrayUpdate [] e) = getKType e
getKType (KArray _) = Arr (BitVec 32) (BitVec 8)
getKType (Select t _ _ _) = t
getKType (FPExt t _) = t
getKType (FPTrunc t _) = t
getKType (FPToUI t _) = t
getKType (FPToSI t _) = t
getKType (UIToFP t _) = t
getKType (SIToFP t _) = t
getKType (FSqrt e) = getKType e
getKType (FAbs t _) = t
getKType (FNeg e) = getKType e
getKType (FRint e) = getKType e
getKType (IsNaN _) = Boolean
getKType (IsInfinite _) = Boolean
getKType (IsNormal _) = Boolean
getKType (IsSubnormal _) = Boolean
getKType (FAdd t _ _) = t
getKType (FSub t _ _) = t
getKType (FMul t _ _) = t
getKType (FDiv t _ _) = t
getKType (FRem t _ _) = t
getKType (FMax e _) = getKType e
getKType (FMin e _) = getKType e
getKType (FOEq _ _) = Boolean
getKType (FOLt _ _) = Boolean
getKType (FOLe _ _) = Boolean
getKType (FOGt _ _) = Boolean
getKType (FOGe _ _) = Boolean

getVarTypes :: [KExpr] -> Map.Map String KType
getVarTypes = undefined

convertBitsizeToFP :: MonadZ3 z3 => Int -> z3 Sort
convertBitsizeToFP 16 = mkFpaSort16
convertBitsizeToFP 32 = mkFpaSort32
convertBitsizeToFP 64 = mkFpaSort64
convertBitsizeToFP 128 = mkFpaSort128
convertBitsizeToFP n = error $ "Unsupported bitsize for floating-point sort: " ++ show n
