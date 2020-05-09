#' Wrappers to dplyr functions
#'
#' Wrapper functions for \pkg{dplyr} functions to preserve texts, document
#' names, and corpus meta-data.
#' @param .data input quanteda object
#' @param ... arguments for the dplyr function
#' @param fun reference to the dplyr function
#' @return a modified \pkg{quanteda} object
#' @importFrom quanteda convert corpus meta
#' @keywords internal
#' @name dplyr-wrappers
#' @export
corpus_stv_byvar <- function(.data, ..., fun) {
  text <- doc_id <- NULL
  convert(.data, to = "data.frame") %>%
    fun(text = text, doc_id = doc_id, ...) %>%
    corpus(meta = meta(.data))
}

#' @rdname dplyr-wrappers
#' @keywords internal
#' @export
corpus_stv_bydoc <- function(.data, ..., fun) {
  convert(.data, to = "data.frame") %>%
    fun(...) %>%
    corpus(meta = meta(.data))
}
