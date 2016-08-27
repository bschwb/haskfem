# Plotting Library Notes
The requirement was to easily plot `R -> R` function.

## [easyplot](http://hackage.haskell.org/package/easyplot)
This is what I ended up using.

    main = plot X11 solvePoisson

A wrapper to `gnuplot`. Seems a bit out-of-date. Needs `gnuplot` in installed path.

## [gnuplot](https://hackage.haskell.org/package/gnuplot)
Also a wrapper to `gnuplot`. Didn't try because I saw no quickstart guide.

## [Chart](https://github.com/timbod7/haskell-chart/wiki)
Didn't work out for either back end.

## Chart-diagrams
Built w/o errors and executed but didn't render anything.

### Chart-cairo
[Gtk2Hs installation instructions](https://wiki.haskell.org/Gtk2Hs/Installation) seemed to long
and thus I didn't try it.

## [dynamic-plot](http://hackage.haskell.org/package/dynamic-plot-0.1.3.0/docs/Graphics-Dynamic-Plot-R2.html)
Wanted to use this first, but results in an error when trying to plot the solution.
Seems like it wants to calculate a derivative somehow, which doesn't seem to be possible by default
for a `R -> R` function which is somehow based on vectors / matrices.

    λ: let pl = fnPlot solvePoisson

    <interactive>:10:17:
        Couldn't match type ‘manifolds-0.2.2.0:Data.Function.Differentiable.RWDfblFuncValue
                              Double m Double’
                      with ‘Double’
        Expected type: constrained-categories-0.2.5.1:Control.Category.Constrained.AgentVal
                        (Graphics.Dynamic.Plot.R2.-->)
                        m
                        manifolds-0.2.2.0:Data.Manifold.Types.Primitive.ℝ
                      -> constrained-categories-0.2.5.1:Control.Category.Constrained.AgentVal
                            (Graphics.Dynamic.Plot.R2.-->)
                            m
                            manifolds-0.2.2.0:Data.Manifold.Types.Primitive.ℝ
          Actual type: hmatrix-0.17.0.2:Internal.Vector.R
                      -> hmatrix-0.17.0.2:Internal.Vector.R
        In the first argument of ‘fnPlot’, namely ‘solvePoisson’
        In the expression: fnPlot solvePoisson
