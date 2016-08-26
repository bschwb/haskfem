module HaskfemInternal
    ( solVec
    , solVecFree
    , basisFuncs
    , rhs
    , sysMatFreeFree
    , slopeAt
    , hatFuncAt
    ) where

import Numeric.LinearAlgebra

-- | The whole solution vector
-- Coefficients for the basis functions
solVec :: Vector R
solVec = vjoin [0.0, solVecFree, 0.0]

-- | The entries of the solution vector corresponding to free dofs
solVecFree :: Vector R
solVecFree = inv sysMatFreeFree #> rhs

-- | The part of the right-hand side corresponding to the free dofs
rhs :: Vector R
rhs = fromList $ replicate 9 1.0

-- | The part of the system matrix corresponding to the free dofs
sysMatFreeFree :: Matrix R
sysMatFreeFree = subMatrix (1, 1) (9, 9) sysMat
  where sysMat = conv2 ((2><2) [1.0, -1.0, -1.0, 1.0]) (ident 10)

-- | List of basis functions for fe-space
basisFuncs :: [R -> R]
basisFuncs = fmap hatFuncAt . toList $ subVector 1 9 grid
  where grid = linspace 11 (0, 1) :: Vector R

-- | Return a linear hat function around @midpoint@
--
-- >>> hatFuncAt 2.0 1.0
-- 0.0
--
-- >>> hatFuncAt 2.0 2.0
-- 1.0
--
-- >>> hatFuncAt 2.0 2.1
-- 0.0
hatFuncAt :: R        -- ^ @midpoint@
          -> (R -> R) -- ^ resulting hat function
hatFuncAt midpoint x = (slopeAt (midpoint - 0.1) x) - (slopeAt midpoint x)

-- | Return a linear slope from 0.0 to 1.0 on one element with left point @start@
--
-- The width of the element is assumed to be 0.1
-- ____/----
--
-- >>> slopeAt 3.0 1.0
-- 0.0
--
-- >>> 0 < slopeAt 3.0 3.05 && slopeAt 3.0 3.05 < 1.0
-- True
--
-- >>> slopeAt 3.0 3.2
-- 1.0
slopeAt :: R        -- ^ @start@
        -> (R -> R) -- ^ resulting slope function
slopeAt start x
  | x <= start = 0.0
  | x >= start + 0.1 = 1.0
  | otherwise  = (x - start) * 10.0
