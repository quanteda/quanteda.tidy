#' @name add_count
#' @rdname dplyr_single
#' @importFrom dplyr add_count
#' @export
NULL

#' Add count of observations to corpus
#'
#' `add_tally` is a generic function for adding a count column. The default
#' method calls [dplyr::add_tally()].
#' @param x an object
#' @param ... additional arguments passed to methods
#' @export
add_tally <- function(x, ...) {
  UseMethod("add_tally")
}

#' @export
add_tally.default <- function(x, ...) {
  dplyr::add_tally(x, ...)
}

#' Add count of observations to corpus
#'
#' `add_count()` and `add_tally()` are wrappers around [dplyr::add_count()] and
#' [dplyr::add_tally()] that add a new document variable with the number of
#' observations. `add_count()` is a shortcut for `group_by() + add_tally()`.
#'
#' @param x a \pkg{quanteda} corpus object
#' @param ... for `add_count()`, document variables to group by; for
#'   `add_tally()`, additional arguments passed to the method
#' @param wt frequency weights. Can be `NULL` or a variable:
#'   * If `NULL` (the default), counts the number of rows in each group
#'   * If a variable, computes `sum(wt)` for each group
#' @param sort if `TRUE`, will sort output in descending order of `n`
#' @param name the name of the new column in the output. If omitted, it will
#'   default to `n`. If there's already a column called `n`, it will error, and
#'   require you to specify the name.
#' @param .drop not used for corpus objects; included for compatibility with
#'   the generic
#' @return a corpus with an additional document variable containing counts
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' # Count documents by President and add as a variable
#' data_corpus_inaugural %>%
#'   add_count(President) %>%
#'   summary(n = 10)
#'
#' # Add total count to each document
#' data_corpus_inaugural %>%
#'   head() %>%
#'   add_tally() %>%
#'   summary()
#'
#' # Count by multiple variables
#' data_corpus_inaugural %>%
#'   add_count(Party, President) %>%
#'   summary(n = 10)
#'
#' # Use custom name
#' data_corpus_inaugural %>%
#'   add_count(Party, name = "party_count") %>%
#'   summary(n = 10)
#'
add_count.corpus <- function(x, ..., wt = NULL, sort = FALSE, name = NULL, .drop = NULL) {
  corpus_stv_bydoc(x, ..., wt = {{ wt }}, sort = sort, name = name, fun = dplyr::add_count)
}

#' @rdname add_count.corpus
#' @export
#' @examples
#' # Add tally to show total count
#' data_corpus_inaugural %>%
#'   slice(1:6) %>%
#'   add_tally() %>%
#'   summary()
add_tally.corpus <- function(x, ..., wt = NULL, sort = FALSE, name = NULL) {
  corpus_stv_bydoc(x, wt = {{ wt }}, sort = sort, name = name, fun = dplyr::add_tally)
}
