
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CovidYe

<!-- badges: start -->

<!-- badges: end -->

The goal of CovidYe is to provide some basic information about COVID-19
of some countries through some interactive plots and tables.

## Installation

<!-- You can install the released version of CovidYe from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("CovidYe") -->

<!-- ``` -->

And the development version can be installed from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-Year-97")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(CovidYe)
library(tibble)
as_tibble(coronavirus)
#> # A tibble: 181,335 x 7
#>    date       province country       lat  long type      cases
#>    <date>     <chr>    <chr>       <dbl> <dbl> <chr>     <int>
#>  1 2020-01-22 ""       Afghanistan  33.9  67.7 confirmed     0
#>  2 2020-01-23 ""       Afghanistan  33.9  67.7 confirmed     0
#>  3 2020-01-24 ""       Afghanistan  33.9  67.7 confirmed     0
#>  4 2020-01-25 ""       Afghanistan  33.9  67.7 confirmed     0
#>  5 2020-01-26 ""       Afghanistan  33.9  67.7 confirmed     0
#>  6 2020-01-27 ""       Afghanistan  33.9  67.7 confirmed     0
#>  7 2020-01-28 ""       Afghanistan  33.9  67.7 confirmed     0
#>  8 2020-01-29 ""       Afghanistan  33.9  67.7 confirmed     0
#>  9 2020-01-30 ""       Afghanistan  33.9  67.7 confirmed     0
#> 10 2020-01-31 ""       Afghanistan  33.9  67.7 confirmed     0
#> # ... with 181,325 more rows
```
