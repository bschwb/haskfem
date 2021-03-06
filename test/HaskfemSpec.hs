module HaskfemSpec where

import Test.Hspec
import Test.Hspec.QuickCheck (prop)

import Haskfem

-- | The analytical solution is `-(x^2)/2 + x/2` for x in [0, 1]
refSolution :: Double -> Double
refSolution x | 0 <= x && x <= 1 = -(x^(2::Int))/2.0 + x/2.0
              | otherwise = 0.0

spec :: Spec
spec = do
  describe "solvePoisson" $ do
    prop "is positive if the reference solution is positive" $ \x ->
      (solvePoisson standardInterval 1.0 1.0 x > 0) == (refSolution x > 0)
