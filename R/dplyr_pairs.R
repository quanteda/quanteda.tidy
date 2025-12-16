#' Verbs that operate on pairs of data frames
#'
#' These functions combine a \pkg{quanteda} object with a data frame, adding
#' new document variables based on matching values.
#'
#' `left_join()` adds columns from `y` to the corpus `x`, matching documents
#' based on a key variable. All documents in `x` are kept. See
#' [dplyr::left_join()] for more details.
#'
#' @param x a \pkg{quanteda} corpus object
#' @param y a data frame to join with
#' @param ... additional arguments passed to methods
#' @return A corpus with document variables from both `x` and `y`.
#' @name dplyr_pairs
#' @keywords internal
NULL
