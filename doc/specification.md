# MVP
Solve [Poisson's equation](https://en.wikipedia.org/wiki/Poisson%27s_equation) `-Δu = 1`
on the unit interval with homogeneous Dirichlet boundary conditions.
The analytical solution is `-x^2 / 2 + x / 2`.

Discretization with piecewise linear finite elements on a equidistant grid of 10 elements.

## Extra features
* visualization
* arbitrary right-hand side
* arbitrary 1D interval
* arbitrary number of elements
* arbitrary Dirichlet boundary conditions
* Neumann boundary conditions

# API
A function which returns the solution for the equation described above.
The solution is a function which can be evaluated on the domain.
For points outside of the domain, 0 should be returned.

    >>> let u = solvePoisson
    >>> u 0
    0
    >>> u 1
    0
    >>> u 0.5
    >should be bigger than 0<
    >>> u -0.2
    0
