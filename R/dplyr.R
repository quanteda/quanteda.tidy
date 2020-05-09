#' Single-table verbs from dplyr
#'
#' These are data manipulation functions designed to work on \pkg{quanteda}
#' objects, where the "single table" is the docvars from the object.
#' Each function operates on the docvars and returns a modified version of the
#' original object.
#'
#' `mutate` and `transmute` can add or modify document variables. See
#' [dplyr::mutate()] for more details.
#'
#' `select` and `rename` keep or rename document variables. See
#' [dplyr::select()] for more details.
#'
#' `pull` extracts a single docvar as a vector.
#' See [dplyr::pull()] for more details.
#'
#' `filter` subsets documents. See [dplyr::filter()]
#' for more details.
#'
#' `arrange` sorts documents by values of the docvars.
#' @name dplyr_single
#' @keywords internal
NULL
