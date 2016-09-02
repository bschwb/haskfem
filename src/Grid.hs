module Grid
    ( Grid
    , standardInterval
    , makeInterval
    , startOfInterval
    , endOfInterval
    , elementSize
    , nElements
    ) where

import Numeric.LinearAlgebra (R)

data Grid = Grid R R R Int
  deriving (Eq, Show)

standardInterval :: Grid
standardInterval = makeInterval 0.0 1.0 10

-- | Specify a 1D Intervall [start, end]
makeInterval :: R -> R -> Int -> Grid
makeInterval start end n
  | start < end && n > 0 = Grid start end ((end - start) / fromIntegral n) n
  | otherwise = undefined

startOfInterval :: Grid -> R
startOfInterval (Grid start _ _ _) = start

endOfInterval :: Grid -> R
endOfInterval (Grid _ end _ _) = end

elementSize :: Grid -> R
elementSize (Grid _ _ h _) = h

nElements :: Grid -> Int
nElements (Grid _ _ _ n) = n
