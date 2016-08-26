# haskfem

1D finite element method for
[Poisson's equation](https://en.wikipedia.org/wiki/Poisson%27s_equation) -Δu = 1 in Haskell.

## Build & Run
This assumes you have [stack](https://docs.haskellstack.org/en/stable/README/) installed.

    git clone git@github.com:bschwb/haskfem.git
    cd haskfem
    stack build
    stack exec haskfem

## Run Tests

    stack test

## Build Documentation

    stack haddock

To open the documentation in your browser use:

    stack haddock --open haskfem
