#' @name relocate
#' @rdname dplyr_cols
#' @importFrom dplyr relocate
#' @export
NULL

#' Change column order of document variables
#'
#' Use `relocate()` to change the column positions of document variables, using
#' the same syntax as [select()][select.corpus()] to make it easy to move blocks
#' of columns at once.
#'
#' @inheritParams dplyr::relocate
#' @return A corpus with document variables reordered.
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   relocate(President, Party) %>%
#'   summary(n = 5)
#'
#' data_corpus_inaugural %>%
#'   relocate(FirstName, President, .before = Year) %>%
#'   summary(n = 5)
relocate.corpus <- function(.data, ...) {
  corpus_stv_byvar(.data, ..., fun = relocate)
}
