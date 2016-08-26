module Haskfem
    ( solvePoisson
    ) where

import Numeric.LinearAlgebra

import HaskfemInternal

-- $setup
-- >>> import Test.QuickCheck
-- >>> import Numeric.LinearAlgebra

-- | Return the solution of the Poisson's equation
-- > -Δu = 1
--
-- * Right-hand side is 1
-- * Domain is the unit interval
-- * homogeneous Dirichlet boundary conditions
--
-- The solution can be evaluated for all x in [0, 1] and returns 0 for points
-- outside of the domain.
--
-- The solution is non negative everywhere:
--
-- prop> solvePoisson (x :: R) >= 0.0
--
-- Dirichlet boundary conditions are fulfilled:
--
-- >>> solvePoisson 0.0
-- 0.0
-- >>> solvePoisson 1.0
-- 0.0
solvePoisson :: R -> R
solvePoisson x = sum $ zipWith (*) (toList solVecFree) $ evalBasisF
  where evalBasisF = fmap ($ x) basisFuncs
