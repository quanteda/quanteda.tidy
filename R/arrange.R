#' @name arrange
#' @rdname dplyr_single
#' @importFrom dplyr arrange
#' @export
NULL

#' Arrange the document order of a corpus by variables
#' 
#' Order the documents in a corpus by variables, including document variables.
#' @param .data a corpus object whose documents will be sorted
#' @param ... comma-separated list of unquoted document variables, or
#'   expressions involving document variables. Use [desc][dplyr::desc()] to 
#'   sort a variable in descending order.
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' arrange(data_corpus_inaugural[1:5], President)
#' arrange(data_corpus_inaugural[1:5], c(3, 2, 1, 5, 4))
#' arrange(data_corpus_inaugural[1:5], desc(President))
arrange.corpus <- function(.data, ...) {
  corpus_stv_bydoc(.data, ..., fun = dplyr::arrange)
}
