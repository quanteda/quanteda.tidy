#' @importFrom dplyr arrange
#' @export
dplyr::arrange

#' Arrange the document order of a corpus by variables
#' 
#' Order the a corpus by variables, including a document variables.
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
  convert(.data, to = "data.frame") %>%
    arrange(...) %>%
    corpus(meta = meta(.data))
}

#' desc re-export
#'
#' See [dplyr::desc()] for details.
#'
#' @name desc
#' @keywords internal
#' @importFrom dplyr desc
#' @export
NULL
