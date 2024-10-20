module Example.Monad.FloatingPoint
  (run)
  where

import Z3.Monad

run :: IO ()
run = evalZ3 script >>= putStrLn
  
script :: Z3 String
script = do
  singlePrecisionSort <- mkFpaSortSingle
  roundTowardZero <- mkFpaRoundTowardZero
  x <- mkFreshConst "x" singlePrecisionSort
  y <- mkFreshConst "y" singlePrecisionSort
  z <- mkFreshConst "z" singlePrecisionSort

  left <- (mkFpaAdd roundTowardZero x y) >>= (\xy -> mkFpaAdd roundTowardZero xy z)
  right <- (mkFpaAdd roundTowardZero x) =<< (mkFpaAdd roundTowardZero y z)
  body <- mkNot =<< mkFpaEq left right

  assert body
  (_res, mbModel) <- solverCheckAndGetModel
  case mbModel of
    Just model -> showModel model
    Nothing -> return "Couldn't construct model"
