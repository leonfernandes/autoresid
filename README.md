
<!-- README.md is generated from README.Rmd. Please edit that file -->

# autoresid

<!-- badges: start -->

<!-- badges: end -->

The autoresid package performs model diagnostics by checking for
dependence among the estimated residuals.

## Installation

You can install the development version of autoresid like so:

``` r
pak::pkg_install("leonfernandes/autoresid")
```

## Example

``` r
# load packages
library(autoresid)
library(fable)
#> Loading required package: fabletools
library(smpspltools)
library(tsibble)
#> 
#> Attaching package: 'tsibble'
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, union

# simulate i.i.d. data
data <-
  tsibble(x = rnorm(100), date = Sys.Date() + 0:99, index = date)

# Consider fitting an AR(1) model
fit <-
  data |>
  estimate(ARIMA(x ~ pdq(1, 0, 0) + PDQ(0, 0, 0)))

# Extract arima object from fitted model
fit_arima <- smpspltools::extract_model(fit)

# Get residuals
autoresid(fit_arima, data, "x")
#> # A tsibble: 100 x 2 [1D]
#>    date       .resid
#>    <date>      <dbl>
#>  1 2024-08-07  0.311
#>  2 2024-08-08 -1.44 
#>  3 2024-08-09 -0.875
#>  4 2024-08-10 -1.22 
#>  5 2024-08-11 -0.235
#>  6 2024-08-12  1.52 
#>  7 2024-08-13  0.687
#>  8 2024-08-14 -0.620
#>  9 2024-08-15  0.874
#> 10 2024-08-16  0.653
#> # ℹ 90 more rows
```
