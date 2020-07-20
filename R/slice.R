#' @name slice
#' @rdname dplyr_single
#' @importFrom dplyr slice
#' @export
NULL

#' @name slice_head
#' @rdname dplyr_single
#' @importFrom dplyr slice_head
#' @export
NULL

#' @name slice_tail
#' @rdname dplyr_single
#' @importFrom dplyr slice_tail
#' @export
NULL

#' @name slice_sample
#' @rdname dplyr_single
#' @importFrom dplyr slice_sample
#' @export
NULL

#' @name slice_min
#' @rdname dplyr_single
#' @importFrom dplyr slice_min
#' @export
NULL

#' @name slice_max
#' @rdname dplyr_single
#' @importFrom dplyr slice_max
#' @export
NULL

n <- dplyr::n

#' Subset documents using their positions
#'
#' @description
#' `slice()` lets you index documents by their (integer) locations. It allows you
#' to select, remove, and duplicate documents.  It is accompanied by a number of
#' helpers for common use cases:
#'
#' * `slice_head()` and `slice_tail()` select the first or last documents.
#' * `slice_sample()` randomly selects documents.
#' * `slice_min()` and `slice_max()` select documents with highest or lowest values
#'   of a document variable.
#'   
#' @inheritParams arrange
#' @inheritParams dplyr::filter
#' @inheritParams dplyr::slice
#' @param n,prop Provide either `n`, the number of documents, or `prop`, the
#'   proportion of documents to select. If neither are supplied, `n = 1` will be
#'   used.
#'
#'   If `n` is greater than the number of rows in the group (or `prop > 1`),
#'   the result will be silently truncated to the group size. If the
#'   `prop`ortion of a group size is not an integer, it is rounded down.
#' @return
#' An object of the same type as `.data`. The output has the following
#' properties:
#'
#' * Each document may appear 0, 1, or many times in the output.  
#'   (If duplicated, then document names will be modified to remain unique.)
#' * Document variables are not modified.
#' @export
#' @examples
#' slice(data_corpus_inaugural, 1:3)
slice.corpus <- function(.data, ..., .preserve = FALSE) {
    corpus_stv_bydoc(.data, ..., .preserve = .preserve, fun = slice)
}

#' @rdname slice.corpus
#' @export
#' @examples
#' slice_head(data_corpus_inaugural, n = 2)
#' slice_head(data_corpus_inaugural, 1:n())
slice_head.corpus <- function(.data, ..., .preserve = FALSE) {
    corpus_stv_bydoc(.data, ..., .preserve = .preserve, fun = slice_head)
}

#' @rdname slice.corpus
#' @export
#' @examples
#' slice_tail(data_corpus_inaugural, n = 3)
#' slice_tail(data_corpus_inaugural, prop = .05)
#' 
slice_tail.corpus <- function(.data, ..., n, prop) {
    corpus_stv_bydoc(.data, ..., fun = slice_tail)
}

#' @rdname slice.corpus
#' @export
#' @examples
#' set.seed(42)
#' slice_sample(data_corpus_inaugural, n = 3)
#' slice_sample(data_corpus_inaugural, prop = .10, replace = TRUE)
#' 
slice_sample.corpus <- function(.data, ..., n, prop, weight_by = NULL, replace = FALSE) {
    corpus_stv_bydoc(.data, ..., fun = slice_sample)
}

#' @rdname slice.corpus
#' @export
#' @examples
#' data_corpus_inaugural <- data_corpus_inaugural %>%
#'     mutate(ntoks = ntoken(data_corpus_inaugural))
#' # shortest three texts
#' slice_min(data_corpus_inaugural, ntoks, n = 3)
slice_min.corpus <- function(.data, ..., n, prop, with_ties = TRUE) {
    corpus_stv_bydoc(.data, ..., fun = slice_min)
}

#' @rdname slice.corpus
#' @export
#' @examples
#' # longest three texts
#' slice_max(data_corpus_inaugural, ntoks, n = 3)
slice_max.corpus <- function(.data, ..., n, prop, with_ties = TRUE) {
    corpus_stv_bydoc(.data, ..., fun = slice_max)
}
