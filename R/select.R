#' @importFrom dplyr select
#' @export
dplyr::select

#' @importFrom dplyr rename
#' @export
dplyr::rename

#' Select/rename docvars by name
#' 
#' Choose or rename document variables.  `select()` keeps only the docvars you
#' mention; `rename()` keeps all of the docvars.
#' @param .data a \pkg{quanteda} object with document variables
#' @param ... comma-separated list of unquoted document variables.  See [select][dplyr::select()].
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   select(Party, Year) %>%
#'   summary(n = 5)
#' 
select.corpus <- function(.data, ...) {
  doc_id <- text <- NULL
  convert(.data, to = "data.frame") %>%
    select(doc_id, text, ...) %>%
    corpus(meta = meta(.data))
}

#' @rdname select.corpus
#' @export
#' @examples 
#' data_corpus_inaugural %>%
#'   rename(LastName = President) %>%
#'   select(FirstName, LastName) %>%
#'   summary(n = 5)
rename.corpus <- function(.data, ...) {
  convert(.data, to = "data.frame") %>%
    rename(...) %>%
    corpus(meta = meta(.data))
}
