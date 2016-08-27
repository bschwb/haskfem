module HaskfemInternal
    ( basisFuncs
    , rhs
    , sysMatFreeFree
    , slopeAt
    , hatFuncAt
    ) where

import Numeric.LinearAlgebra

-- | The part of the right-hand side corresponding to the free dofs
--
-- Takes a real number as constant right-hand side.
rhs :: R        -- ^ @c@
    -> Vector R
rhs c = fromList . replicate 9 $ c * 0.1

-- | The part of the system matrix corresponding to the free dofs
sysMatFreeFree :: Matrix R
sysMatFreeFree = subMatrix (1, 1) (9, 9) sysMat
  where sysMat = 10.0 * (conv2 ((2><2) [1.0, -1.0, -1.0, 1.0]) (ident 10))

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
