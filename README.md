
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

# Get residuals
autoresid(fit, data, "x")
#> # A tsibble: 100 x 2 [1D]
#>    date       .resid
#>    <date>      <dbl>
#>  1 2023-10-02 -0.312
#>  2 2023-10-03  1.90 
#>  3 2023-10-04  0.356
#>  4 2023-10-05  2.11 
#>  5 2023-10-06  0.950
#>  6 2023-10-07  0.340
#>  7 2023-10-08  0.101
#>  8 2023-10-09 -0.679
#>  9 2023-10-10  0.385
#> 10 2023-10-11  1.81 
#> # ℹ 90 more rows
```
