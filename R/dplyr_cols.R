#' Verbs that operate on columns
#'
#' These functions operate on the columns (document variables) of \pkg{quanteda}
#' objects, creating, modifying, renaming, reordering, or selecting document
#' variables.
#'
#' `mutate()` creates new document variables or modifies existing ones.
#' `transmute()` creates new document variables and drops existing ones. See
#' [dplyr::mutate()] for more details.
#'
#' `pull()` extracts a single document variable as a vector. See
#' [dplyr::pull()] for more details.
#'
#' `relocate()` changes the column order of document variables. See
#' [dplyr::relocate()] for more details.
#'
#' `rename()` changes the names of individual document variables using
#' `new_name = old_name` syntax. `rename_with()` renames document variables
#' using a function. See [dplyr::rename()] for more details.
#'
#' `select()` keeps or drops document variables by name. See [dplyr::select()]
#' for more details.
#'
#' @name dplyr_cols
#' @keywords internal
NULL
