module HaskfemInternal
    ( basisFuncs
    , rhs
    , sysMatFreeFree
    , slope
    , hatFunc
    ) where

import Numeric.LinearAlgebra

import Grid

-- $setup
-- >>> import Test.QuickCheck
-- >>> import Numeric.LinearAlgebra

-- | The part of the right-hand side corresponding to the free dofs
--
-- Takes a real number as constant right-hand side.
rhs :: Grid
    -> R        -- ^ @f@
    -> Vector R
rhs g f = fromList . replicate n $ f * h
  where n = nElements g - 1
        h = elementSize g

-- | The part of the system matrix corresponding to the free dofs
sysMatFreeFree :: Grid
               -> R        -- ^ the constant parameter @c@ of the left-hand side
               -> Matrix R
sysMatFreeFree g c = subMatrix (1, 1) (n-1, n-1) sysMat
  where sysMat = (scalar c) * hinv * (conv2 ((2><2) [1.0, -1.0, -1.0, 1.0]) (ident n))
        n = nElements g
        hinv = scalar $ 1.0 / elementSize g

-- | List of basis functions for fe-space
basisFuncs :: Grid
           -> [R -> R]
basisFuncs g = fmap (hatFunc h)  . toList $ subVector 1 (nElements g - 1) grid
  where grid = linspace (nElements g + 1) (startOfInterval g, endOfInterval g) :: Vector R
        h = elementSize g

-- | Return a linear hat function around @midpoint@ with @run@
--
-- >>> hatFunc 0.1 2.0 1.0
-- 0.0
--
-- >>> hatFunc 0.1 2.0 2.0
-- 1.0
--
-- >>> hatFunc 0.1 2.0 2.1
-- 0.0
hatFunc :: R        -- ^ @run@
        -> R        -- ^ @midpoint@
        -> (R -> R) -- ^ resulting hat function
hatFunc run midpoint x = (slope (midpoint - run) run x) - (slope midpoint run x)

-- | Return a linear slope from 0.0 to 1.0 on the length of @run@ with left point @start@
--
-- ____/----
--
-- prop> slope (start :: R) (run :: R) start == 0.0
-- /prop> slope (start :: R) (run :: R) (start + run / 2.0) > 0.0
-- /prop> slope (start :: R) (run :: R) (start + run / 2.0) < 1.0
-- prop> slope (start :: R) (run :: R) (start + run) == 1.0
slope :: R        -- ^ @start@
      -> R        -- ^ @run@
      -> (R -> R) -- ^ resulting slope function
slope start run x
  | x <= start = 0.0
  | x >= start + run = 1.0
  | otherwise  = (x - start) * 1.0 / run
