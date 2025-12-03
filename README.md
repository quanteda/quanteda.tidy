
# quanteda.tidy

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/quanteda.tidy)](https://cran.r-project.org/package=quanteda.tidy)
[![](https://img.shields.io/badge/devel%20version-0.4-royalblue.svg)](https://github.com/quanteda/quanteda.tidy)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/quanteda/quanteda.tidy/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/quanteda/quanteda.tidy/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/quanteda/quanteda.tidy/graph/badge.svg)](https://app.codecov.io/gh/quanteda/quanteda.tidy)
<!-- badges: end -->

## About

**quanteda.tidy** extends the **quanteda** package with functionality
from the “tidyverse”, especially **dplyr**.  
Note that this is not the same as **tidytext**, which stretches tokens
into data.frames. Instead, tidy functions operate only on document
variables, but extends these functions (from **dplyr**) to work on
**quanteda** objects as if they were tibbles or data.frames.

## Installation

You can install the stable version of **quanteda.tidy** from CRAN:

``` r
install.packages("quanteda.tidy")
```

Or install the development version from GitHub:

``` r
pak::pkg_install("quanteda/quanteda.tidy")
```

## Overview of Functions

The functions in **quanteda.tidy** are organized into four categories,
following the [dplyr
documentation](https://dplyr.tidyverse.org/reference/):

| Category | Function | Description |
|:---|:---|:---|
| Rows | `filter()` | Subset documents based on docvar conditions |
| Rows | `slice()`, `slice_head()`, `slice_tail()` | Subset documents by position |
| Rows | `slice_sample()` | Randomly sample documents |
| Rows | `slice_min()`, `slice_max()` | Select documents with min/max docvar values |
| Rows | `arrange()`, `distinct()` | Reorder documents; keep unique documents |
| Columns | `select()` | Keep or drop docvars by name |
| Columns | `rename()`, `rename_with()` | Rename docvars |
| Columns | `relocate()` | Change docvar column order |
| Columns | `mutate()`, `transmute()` | Create or modify docvars |
| Columns | `pull()` | Extract a single docvar as a vector |
| Columns | `glimpse()` | Get a quick overview of the corpus |
| Groups of rows | `add_count()` | Add count by group as a docvar |
| Groups of rows | `add_tally()` | Add total count as a docvar |
| Pairs of data frames | `left_join()` | Join corpus with external data frame |

## Example

Adding a document variable for full president name:

``` r
library("quanteda.tidy", warn.conflicts = FALSE)
## Loading required package: quanteda
## Package version: 4.3.1
## Unicode version: 14.0
## ICU version: 71.1
## Parallel computing: disabled
## See https://quanteda.io for tutorials and examples.

data_corpus_inaugural %>%
  mutate(fullname = paste(FirstName, President, sep = ", ")) %>%
  summary(n = 5)
## Corpus consisting of 60 documents, showing 5 documents:
## 
##             Text Types Tokens Sentences Year  President FirstName
##  1789-Washington   625   1537        23 1789 Washington    George
##  1793-Washington    96    147         4 1793 Washington    George
##       1797-Adams   826   2577        37 1797      Adams      John
##   1801-Jefferson   717   1923        41 1801  Jefferson    Thomas
##   1805-Jefferson   804   2380        45 1805  Jefferson    Thomas
##                  Party           fullname
##                   none George, Washington
##                   none George, Washington
##             Federalist        John, Adams
##  Democratic-Republican  Thomas, Jefferson
##  Democratic-Republican  Thomas, Jefferson
```
