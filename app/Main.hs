module Main where

import Graphics.EasyPlot

import Haskfem

main :: IO Bool
main = plot X11
        [ Function2D [Title "FEM solution"] [Range 0.0 1.0] solvePoisson
        , Function2D [Title "Ref solution"] [Range 0.0 1.0] refSolution
        ]

refSolution :: Double -> Double
refSolution x = -x^(2 :: Integer) / 2.0 + x / 2.0
