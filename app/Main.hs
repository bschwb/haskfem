module Main where

import Graphics.EasyPlot

import Haskfem

xmin :: Double
xmin = 0.0

xmax :: Double
xmax = 1.0

n :: Int
n = 22

grid = makeInterval xmin xmax n

main :: IO Bool
main = plot X11
        [ Function2D [Title "FEM solution"] [Range xmin xmax] (solvePoisson grid 1.0 1.0)
        , Function2D [Title "Ref solution"] [Range xmin xmax] refSolution
        ]

refSolution :: Double -> Double
refSolution x = -x^(2 :: Int) / 2.0 + x / 2.0
