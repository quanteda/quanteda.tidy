#' @name pull
#' @rdname dplyr_single
#' @importFrom dplyr pull
#' @export
NULL

#' Pull out a single document variable
#'
#' Works like `$` for \pkg{quanteda} objects with document variables, or like
#' `docvars(x, "varname")`.
#' @param .data a \pkg{quanteda} object with document variables
#' @inheritParams dplyr::pull
#' @importFrom rlang enquo
#' @importFrom quanteda docvars
#' @export
#' @examples
#' tail(data_corpus_inaugural) %>% pull(President)
#' tail(data_corpus_inaugural) %>% pull(-1)
#' tail(data_corpus_inaugural) %>% pull(1)
#'
pull.corpus <- function(.data, var = -1) {
  var <- enquo(var)
  pull(docvars(.data), !!var)
}

#' @rdname pull.corpus
#' @export
#' @examples
#' toks <- data_corpus_inaugural %>%
#'   tail() %>%
#'   tokens()
#' pull(toks, President)
#'
pull.tokens <- pull.corpus

#' @rdname pull.corpus
#' @export
#' @examples
#' dfmat <- data_corpus_inaugural %>%
#'   tail() %>%
#'   dfm()
#' pull(dfmat, President)
#'
pull.dfm <- pull.corpus
