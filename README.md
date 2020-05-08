
# quanteda.tidy

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/quanteda.tidy)](https://cran.r-project.org/package=quanteda.tidy)
[![Travis-CI Build
Status](https://travis-ci.org/quanteda/quanteda.tidy.svg?branch=master)](https://travis-ci.org/quanteda/quanteda.tidy)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/quanteda/quanteda.tidy?branch=master&svg=true)](https://ci.appveyor.com/project/quanteda/quanteda.tidy)
[![Coverage
Status](https://img.shields.io/codecov/c/github/quanteda/quanteda.tidy/master.svg)](https://codecov.io/github/quanteda/quanteda.tidy?branch=master)

## About

**quanteda.tidy** extends the **quanteda** package with functionality
from the “tidyverse”, especially **dplyr**.  
Note that this is not the same as **tidytext**, which stretches tokens
into data.frames. Instead, tidy functions operate only on document
variables, but extends these functions (from **dplyr**) to work on
**quanteda** objects as if they were tibbles or data.frames.

## Installation

You can install **quanteda.tidy** from GitHub with:

``` r
devtools::install_github("quanteda/quanteda.tidy")
```

## Examples

Adding a document variable for full president name:

``` r
library("quanteda.tidy")
## Loading required package: quanteda
## Package version: 2.0.2
## Parallel computing: 2 of 8 threads used.
## See https://quanteda.io for tutorials and examples.
## 
## Attaching package: 'quanteda'
## The following object is masked from 'package:utils':
## 
##     View
## 
## Attaching package: 'quanteda.tidy'
## The following object is masked from 'package:stats':
## 
##     filter

data_corpus_inaugural %>%
  transmute(fullname = paste(FirstName, President, sep = ", ")) %>%
  summary(n = 5)
## Corpus consisting of 58 documents, showing 5 documents:
## 
##             Text Types Tokens Sentences           fullname
##  1789-Washington   625   1537        23 George, Washington
##  1793-Washington    96    147         4 George, Washington
##       1797-Adams   826   2577        37        John, Adams
##   1801-Jefferson   717   1923        41  Thomas, Jefferson
##   1805-Jefferson   804   2380        45  Thomas, Jefferson

data_corpus_inaugural %>%
  mutate(fullname = paste(FirstName, President, sep = ", ")) %>%
  summary(n = 5)
## Corpus consisting of 58 documents, showing 5 documents:
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

Filtering documents based on years:

``` r
data_corpus_inaugural %>%
  filter(President == "Roosevelt") %>%
  summary()
## Corpus consisting of 5 documents, showing 5 documents:
## 
##            Text Types Tokens Sentences Year President   FirstName      Party
##  1905-Roosevelt   404   1079        33 1905 Roosevelt    Theodore Republican
##  1933-Roosevelt   743   2057        85 1933 Roosevelt Franklin D. Democratic
##  1937-Roosevelt   725   1989        96 1937 Roosevelt Franklin D. Democratic
##  1941-Roosevelt   526   1519        68 1941 Roosevelt Franklin D. Democratic
##  1945-Roosevelt   275    633        26 1945 Roosevelt Franklin D. Democratic
```
