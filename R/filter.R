#' @name filter
#' @rdname dplyr_rows
#' @importFrom dplyr filter
#' @export
NULL

#' Return documents with matching conditions
#'
#' Use `filter()` to select documents where conditions evaluated on document
#' variables are true. Documents where the condition evaluates to `NA` are
#' dropped. A tidy replacement for [corpus_subset()][quanteda::corpus_subset()].
#'
#' @param .data a \pkg{quanteda} object whose documents will be filtered
#' @param ... Logical predicates defined in terms of the document variables in
#'   `.data`, or a condition supplied externally whose length matches `the
#'   number of `ndoc(.data)`.  See [filter][dplyr::filter()].
#' @inheritParams dplyr::filter
#' @return A corpus containing only documents that satisfy the specified
#'   conditions.
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'     filter(Year < 1810) %>%
#'     summary()
#'
filter.corpus <- function(.data, ..., .preserve = FALSE) {
    corpus_stv_bydoc(.data, ..., .preserve = .preserve, fun = filter)
}
