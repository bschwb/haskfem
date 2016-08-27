module Haskfem
    ( solvePoisson
    ) where

import Numeric.LinearAlgebra

import HaskfemInternal

-- $setup
-- >>> import Test.QuickCheck
-- >>> import Numeric.LinearAlgebra

-- | Return the solution of the Poisson's equation
-- > -Δu = c
--
-- * Right-hand side is a constant
-- * Domain is the unit interval
-- * homogeneous Dirichlet boundary conditions
--
-- The solution can be evaluated for all x in [0, 1] and returns 0 for points
-- outside of the domain.
--
-- The solution is non negative everywhere:
--
-- prop> solvePoisson (c :: R) (x :: R) >= 0.0
--
-- Dirichlet boundary conditions are fulfilled:
--
-- prop> solvePoisson (c :: R) 0.0 == 0.0
-- prop> solvePoisson (c :: R) 1.0 == 0.0
solvePoisson :: R        -- ^ right-hand side constant @c@
             -> (R -> R)
solvePoisson c x = sum $ zipWith (*) (toList solVecFree) $ evalBasisF
  where evalBasisF = fmap ($ x) basisFuncs

        solVecFree = inv sysMatFreeFree #> rhs c
