#' Single-table verbs from dplyr
#'
#' These are data manipulation functions designed to work on \pkg{quanteda}
#' objects, where the "single table" is the docvars from the object.
#' Each function operates on the docvars and returns a modified version of the
#' original object.
#'
#' `arrange` sorts documents by values of the docvars.
#' 
#' `filter` subsets documents. See [dplyr::filter()]
#' for more details.
#'
#' `mutate` and `transmute` can add or modify document variables. See
#' [dplyr::mutate()] for more details.
#'
#' `pull` extracts a single docvar as a vector.
#' See [dplyr::pull()] for more details.
#'
#' `select` and `rename` keep or rename document variables. See
#' [dplyr::select()] for more details.
#' 
#' `slice` lets you index documents by their (integer) locations, to select,
#' remove, and duplicate documents.  See [dplyr::slice()] for more details.
#'
#' @name dplyr_single
#' @keywords internal
NULL
