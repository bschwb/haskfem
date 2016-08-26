module Main where

import Graphics.EasyPlot

import Haskfem

main :: IO Bool
main = plot X11 solvePoisson
