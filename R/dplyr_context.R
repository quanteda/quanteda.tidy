#' Context functions from dplyr
#'
#' These functions return information about the "current" group or "current"
#' variable, so only work inside specific contexts like `summarise()` and
#' `mutate()`
#'
#' * `n()` gives the current group size.
#' * `cur_data()` gives the current data for the current group (excluding
#'   grouping variables).
#' * `cur_data_all()` gives the current data for the current group (including
#'   grouping variables)
#' * `cur_group()` gives the group keys, a tibble with one row and one column
#'   for each grouping variable.
#' * `cur_group_id()` gives a unique numeric identifier for the current group.
#' * `cur_column()` gives the name of the current column (in [across()] only).
#'
#' See [group_data()] for equivalent functions that return values for all
#' groups.
#' @param ... not used; present for compatibility with the generic
#' @return Context-dependent: `n()` returns an integer; `cur_group_id()` returns
#'   an integer; `cur_group()` returns a tibble; `cur_data()` and `cur_data_all()`
#'   return tibbles; `cur_column()` returns a character string.
#' @name dplyr_context
#' @keywords internal
NULL

#' @name n
#' @rdname dplyr_context
#' @importFrom dplyr n
#' @export
NULL
