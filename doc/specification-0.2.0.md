# Specification Version 0.2.0
## MVP
Add following features to [version 0.1.0](specification-0.1.0.md):
  * visualization
  * arbitrary constant for right-hand side
  * arbitrary constant parameter for left-hand side
  * arbitrary 1D interval
  * arbitrary number of elements (but equidistant grid)

## API
A way to specify the grid:

    -- | Specify a 1D Intervall [start, end]
    makeInterval :: R -> R -> Integer -> Grid
    makeInterval start end nElements


Addition of lhs and rhs constant specification and providing a grid

    solvePoisson :: Grid -> R -> R -> (R -> R)
    solvePoisson grid lhs rhs

    >>> standardInterval = 0.0 1.0 10
    >>> let u = solvePoisson standardInterval 2.0 3.0
    >>> u 0.0
    0.0
    >>> u 1.0
    0.0
    >>> u 0.5
    >should be bigger than 0.0<
    >>> u -0.2
    0.0

## Further Improvements -> Next versions
* arbitrary Dirichlet boundary conditions
  Where do I set boundary conditions?
  What to do in case of 2 Neumann boundary conditions?
* Neumann boundary conditions
* numerical integration to support
  - arbitrary distant grids
  - non-constant rhs
  - non-constant lhs
  - higher-order elements
* refinement
