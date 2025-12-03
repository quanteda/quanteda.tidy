#' @name rename
#' @rdname dplyr_cols
#' @importFrom dplyr rename
#' @export
NULL

#' @name rename_with
#' @rdname dplyr_cols
#' @importFrom dplyr rename_with
#' @export
NULL

#' Rename document variables
#'
#' `rename()` changes the names of individual document variables using `new_name
#' = old_name` syntax; `rename_with()` renames columns using a function.
#' 
#' @param .data a \pkg{quanteda} object with document variables
#' @inheritParams dplyr::rename
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   rename(LastName = President) %>%
#'   summary(n = 5)
rename.corpus <- function(.data, ...) {
  corpus_stv_byvar(.data, ..., fun = rename)
}

#' @rdname rename.corpus
#' @inheritParams dplyr::rename_with
#' @importFrom quanteda docvars<-
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   rename_with(toupper) %>%
#'   summary(n = 5)
#' data_corpus_inaugural %>%
#'   rename_with(toupper, starts_with("P")) %>%
#'   summary(n = 5)
rename_with.corpus <- function(.data, .fn, .cols = everything(), ...) {
  docvars(.data) <- rename_with(docvars(.data), .fn = .fn, .cols = {{ .cols }}, ...)
  .data
}
