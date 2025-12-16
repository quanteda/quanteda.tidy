#' @title quanteda.tidy: Tidyverse Extensions for quanteda
#'
#' @description
#' Extends 'dplyr' verbs to work directly on 'quanteda' corpus objects,
#' enabling users to manipulate document-level variables ("docvars") using
#' familiar 'tidyverse' syntax. Implements row operations for subsetting and
#' reordering documents; column operations for managing document variables;
#' grouped operations via [add_count()] and [add_tally()]; and two-table verbs
#' (such as [left_join()]) for merging external data.
#'
#' @references
#'
#' Benoit, K., Watanabe, K., Wang, H., Nulty, P., Obeng, A., Müller, S., &
#' Matsuo, A. (2018). "quanteda: An R package for the quantitative analysis of
#' textual data." *Journal of Open Source Software*, 3(30), 774.
#' \doi{10.21105/joss.00774}
#'
#' Wickham, H., François, R., Henry, L., Müller, K., & Vaughan, D. (2023).
#' *dplyr: A Grammar of Data Manipulation*. R package version 1.1.4.
#' \doi{10.32614/CRAN.package.dplyr}
#'
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
