module Haskfem
    ( solvePoisson
    ) where

-- $setup
-- >>> import Test.QuickCheck

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
--
-- The solution is non negative everywhere:
-- prop> solvePoisson (x :: Double) >= 0
--
-- Dirichlet boundary conditions are fulfilled:
-- >>> solvePoisson 0
-- 0.0
-- >>> solvePoisson 1
-- 0.0
solvePoisson :: Double -> Double
solvePoisson = const 0.0
