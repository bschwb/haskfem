module Haskfem
    ( solvePoisson
    , makeInterval
    , standardInterval
    ) where

import Numeric.LinearAlgebra

import Grid
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
-- No proper error handling for @c = 0.0@.
-- The constant 0.0 functions is the standard solution
-- The solution can be evaluated for all x in [0, 1] and returns 0 for points
-- outside of the domain.
--
-- The solution has same sign as @fc@ everywhere:
--
-- prop> (c :: R) * (f :: R) * (solvePoisson standardInterval (c :: R) (f :: R) (x :: R)) >= 0.0
--
-- Dirichlet boundary conditions are fulfilled:
--
-- prop> solvePoisson standardInterval (c :: R) (f :: R) 0.0 == 0.0
-- prop> solvePoisson standardInterval (c :: R) (f :: R) 1.0 == 0.0
solvePoisson :: Grid     -- ^ Grid on which to solve the equation
             -> R        -- ^ left-hand side constant parameter @c@
             -> R        -- ^ right-hand side constant @f@
             -> (R -> R)
solvePoisson _ 0 _ _ = 0.0
solvePoisson grid c f x = sum $ zipWith (*) (toList solVecFree) $ evalBasisF
  where evalBasisF = fmap ($ x) $ basisFuncs grid

        solVecFree = inv (sysMatFreeFree grid c) #> rhs grid f
