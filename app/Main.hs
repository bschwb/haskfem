module Main where

import Haskfem

main :: IO ()
main = print $ solvePoisson 0.2
