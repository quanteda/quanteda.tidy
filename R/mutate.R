# mutate ------------

#' @name mutate
#' @rdname dplyr_single
#' @importFrom dplyr mutate
#' @export
NULL

#' Create or transform document variables
#'
#' `mutate()` adds new [document variables][quanteda::docvars] and preserves
#' existing ones; `transmute()` adds new document variables and drops existing
#' ones. Both functions preserve the number of rows of the input. New variables
#' overwrite existing variables of the same name.
#'
#' @param .data a \pkg{quanteda} object whose document variables will be created
#'   or transformed
#' @param ... name-value pairs of expressions for document variable modification
#'   or assignment; see [mutate][dplyr::mutate()].
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   mutate(fullname = paste(FirstName, President, sep = ", ")) %>%
#'   summary(n = 5)
#'
mutate.corpus <- function(.data, ...) {
  corpus_stv_byvar(.data, ..., fun = dplyr::mutate)
}

# transmute ------------

#' @name transmute
#' @rdname dplyr_single
#' @importFrom dplyr transmute
#' @export
NULL

#' @rdname mutate.corpus
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   transmute(fullname = paste(FirstName, President, sep = ", ")) %>%
#'   summary(n = 5)
transmute.corpus <- function(.data, ...) {
  corpus_stv_byvar(.data, ..., fun = dplyr::transmute)
}
