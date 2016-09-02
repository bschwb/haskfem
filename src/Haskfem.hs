module Haskfem
    ( solvePoisson
    ) where

import Numeric.LinearAlgebra

import HaskfemInternal

-- $setup
-- >>> import Test.QuickCheck
-- >>> import Numeric.LinearAlgebra

-- | Return the solution of the Poisson's equation
-- > -c Δu = f
--
-- * Right-hand side is a constant
-- * Left-hand side parameter is a constant
-- * Domain is the unit interval
-- * homogeneous Dirichlet boundary conditions
--
-- The solution can be evaluated for all x in [0, 1] and returns 0 for points
-- outside of the domain.
--
-- The solution has same sign as @fc@ everywhere:
--
-- prop> (c :: R) * (f :: R) * (solvePoisson (c :: R) (f :: R) (x :: R)) >= 0.0
--
-- Dirichlet boundary conditions are fulfilled:
--
-- prop> solvePoisson (c :: R) (f :: R) 0.0 == 0.0
-- prop> solvePoisson (c :: R) (f :: R) 1.0 == 0.0
solvePoisson :: R        -- ^ left-hand side constant parameter @c@
             -> R        -- ^ right-hand side constant @f@
             -> (R -> R)
solvePoisson c f x = sum $ zipWith (*) (toList solVecFree) $ evalBasisF
  where evalBasisF = fmap ($ x) basisFuncs

        solVecFree = inv (sysMatFreeFree c) #> rhs f
