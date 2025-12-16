#' Verbs that operate on groups of rows
#'
#' These functions operate on groups of rows (documents) of \pkg{quanteda}
#' objects, typically counting or summarising documents by group.
#'
#' `add_count()` and `add_tally()` add a document variable containing the count
#' of observations in each group. See [dplyr::add_count()] for more details.
#'
#' @param x a \pkg{quanteda} corpus object
#' @param ... additional arguments passed to methods
#' @return A corpus with an additional document variable containing counts.
#' @name dplyr_groups
#' @keywords internal
NULL
