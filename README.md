
# quanteda.tidy

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/quanteda.tidy)](https://cran.r-project.org/package=quanteda.tidy)
[![](https://img.shields.io/badge/devel%20version-0.3-royalblue.svg)](https://github.com/quanteda/quanteda.tidy)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/quanteda/quanteda.tidy/workflows/R-CMD-check/badge.svg)](https://github.com/quanteda/quanteda.tidy/actions)
[![Coverage
Status](https://img.shields.io/codecov/c/github/quanteda/quanteda.tidy/master.svg)](https://codecov.io/github/quanteda/quanteda.tidy?branch=master)
<!-- badges: end -->

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
library("quanteda.tidy", warn.conflicts = FALSE)
## Loading required package: quanteda
## Package version: 3.2.3
## Unicode version: 14.0
## ICU version: 70.1
## Parallel computing: 10 of 10 threads used.
## See https://quanteda.io for tutorials and examples.

data_corpus_inaugural %>%
  transmute(fullname = paste(FirstName, President, sep = ", ")) %>%
  summary(n = 5)
## Corpus consisting of 59 documents, showing 5 documents:
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
## Corpus consisting of 59 documents, showing 5 documents:
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
##  1945-Roosevelt   275    633        27 1945 Roosevelt Franklin D. Democratic
```

Renaming document variables:

``` r
data_corpus_inaugural %>%
  rename(LastName = President) %>%
  select(FirstName, LastName) %>%
  summary(n = 5)
## Corpus consisting of 59 documents, showing 5 documents:
## 
##             Text Types Tokens Sentences FirstName   LastName
##  1789-Washington   625   1537        23    George Washington
##  1793-Washington    96    147         4    George Washington
##       1797-Adams   826   2577        37      John      Adams
##   1801-Jefferson   717   1923        41    Thomas  Jefferson
##   1805-Jefferson   804   2380        45    Thomas  Jefferson
```

Glimpse (from **tibble**):

``` r
glimpse(data_corpus_inaugural)
## Rows: 59
## Columns: 6
## $ doc_id    <chr> "1789-Washington", "1793-Washington", "1797-Adams", "1801-Je…
## $ text      <chr> "Fellow-Cit…", "Fellow cit…", "When it wa…", "Friends an…", …
## $ Year      <int> 1789, 1793, 1797, 1801, 1805, 1809, 1813, 1817, 1821, 1825, …
## $ President <chr> "Washington", "Washington", "Adams", "Jefferson", "Jefferson…
## $ FirstName <chr> "George", "George", "John", "Thomas", "Thomas", "James", "Ja…
## $ Party     <fct> none, none, Federalist, Democratic-Republican, Democratic-Re…
```

Slice operations:

``` r
slice(data_corpus_inaugural, 1:3)
## Corpus consisting of 3 documents and 4 docvars.
## 1789-Washington :
## "Fellow-Citizens of the Senate and of the House of Representa..."
## 
## 1793-Washington :
## "Fellow citizens, I am again called upon by the voice of my c..."
## 
## 1797-Adams :
## "When it was first perceived, in early times, that no middle ..."

slice_head(data_corpus_inaugural, prop = .10)
## Corpus consisting of 5 documents and 4 docvars.
## 1789-Washington :
## "Fellow-Citizens of the Senate and of the House of Representa..."
## 
## 1793-Washington :
## "Fellow citizens, I am again called upon by the voice of my c..."
## 
## 1797-Adams :
## "When it was first perceived, in early times, that no middle ..."
## 
## 1801-Jefferson :
## "Friends and Fellow Citizens: Called upon to undertake the du..."
## 
## 1805-Jefferson :
## "Proceeding, fellow citizens, to that qualification which the..."
slice_tail(data_corpus_inaugural, n = 3)
## Corpus consisting of 3 documents and 4 docvars.
## 2013-Obama :
## "Vice President Biden, Mr. Chief Justice, Members of the Unit..."
## 
## 2017-Trump :
## "Chief Justice Roberts, President Carter, President Clinton, ..."
## 
## 2021-Biden :
## "Chief Justice Roberts, Vice President Harris, Speaker Pelosi..."

set.seed(42)
slice_sample(data_corpus_inaugural, prop = .50)
## Corpus consisting of 29 documents and 4 docvars.
## 1981-Reagan :
## "Senator Hatfield, Mr. Chief Justice, Mr. President, Vice Pre..."
## 
## 1933-Roosevelt :
## "I am certain that my fellow Americans expect that on my indu..."
## 
## 1789-Washington :
## "Fellow-Citizens of the Senate and of the House of Representa..."
## 
## 1885-Cleveland :
## "Fellow citizens, in the presence of this vast assemblage of ..."
## 
## 1825-Adams :
## "In compliance with an usage coeval with the existence of our..."
## 
## 1929-Hoover :
## "My Countrymen: This occasion is not alone the administration..."
## 
## [ reached max_ndoc ... 23 more documents ]
```
