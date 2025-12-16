#' Verbs that operate on rows
#'
#' These functions operate on the rows (documents) of \pkg{quanteda} objects,
#' subsetting, reordering, or selecting distinct documents based on document
#' variables.
#'
#' `arrange()` orders documents by values of document variables.  See
#' [dplyr::arrange()] for more details.
#'
#' `distinct()` subsets documents to keep only unique/distinct rows based on
#' document variable values. See [dplyr::distinct()] for more details.
#'
#' `filter()` subsets documents that satisfy specified conditions on document
#' variables. See [dplyr::filter()] for more details.
#'
#' `slice()` and its variants (`slice_head()`, `slice_tail()`, `slice_min()`,
#' `slice_max()`, `slice_sample()`) select documents by their (integer)
#' positions. See [dplyr::slice()] for more details.
#'
#' @param .data a \pkg{quanteda} corpus object
#' @param ... additional arguments passed to methods
#' @return A corpus, subsetted or reordered according to the operation.
#' @name dplyr_rows
#' @keywords internal
NULL
