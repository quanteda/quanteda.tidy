#' @name distinct
#' @rdname dplyr_rows
#' @importFrom dplyr distinct
#' @export
NULL

#' Subset documents distinct/unique by document variables
#'
#' Select only documents that are unique/distinct with respect to values of
#' their document variables.
#' @param .data a corpus object with document variables
#' @param ... comma-separated list of unquoted document variables, or
#'   expressions involving document variables
#' @inheritParams dplyr::distinct
#' @importFrom dplyr distinct select left_join
#' @importFrom quanteda convert corpus meta
#' @export
#' @examples
#' distinct(data_corpus_inaugural[1:5], President) %>%
#'   summary()
#' distinct(data_corpus_inaugural[1:5], President, .keep_all = TRUE) %>%
#'   summary()
distinct.corpus <- function(.data, ..., .keep_all = FALSE) {
  text <- doc_id <- NULL
  df <- convert(.data, to = "data.frame") %>%
    distinct(..., .keep_all = TRUE)
  if (!.keep_all) {
    df <- select(df, doc_id, text, ...)
  }
  corpus(df, meta = meta(.data))
}
