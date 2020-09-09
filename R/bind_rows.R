#' @name bind_rows
#' @rdname bind_rows
#' @importFrom dplyr bind_rows
#' @export
NULL

#' @rdname bind_rows
#' @noRd
#' @export
bind_rows <- function(..., .id = NULL) {
  UseMethod("bind_rows")
}

#' @rdname bind_rows
#' @noRd
#' @export
bind_rows.default <- function(..., .id = NULL) {
  dplyr::bind_rows(..., .id = .id)
}


#' Bind multiple corpora by row
#'
#' `bind_rows()` appends documents and document variables
#' @rdname bind_rows
#' @param ... comma-separated list of corpus objects
#' @param .id corpus identifier. When `.id` is supplied, a document variable of identifiers is
#' created to link each document to its corpus. 
#' @param .meta a named list of metadata fields in the corpus. If `.meta` is `NULL`, 
#' the default, the metadata of the first corpus supplied to `bind_rows` will be used.
#' @importFrom quanteda convert corpus meta
#' @export
#' @examples
#' corp1 <- data_corpus_inaugural[1:5]
#' corp2 <- data_corpus_inaugural[6:10]
#' 
#' # using the metadata of the first corpus by default
#' bind_rows(corp1, corp2)
#' 
#' # supply custom meta data 
#' md <- list(source = "some source", author = "some author")
#' bind_rows(corp1, corp2, .meta = md)
#' 
#' # create document variable named "corpus_id" 
#' bind_rows(corp1, corp2, .id = "corpus_id")
bind_rows.corpus <- function(..., .id = NULL, .meta = NULL) {
  
  corpora <- list(...)
  
  dfs <- lapply(corpora, convert, to = "data.frame")
  
  corp <- bind_rows(dfs, .id = .id) %>%
    corpus()
  
  
  if(!is.null(.meta)){
    meta(corp) <- .meta
  } else {
    meta(corp) <- meta(corpora[[1]])
  }
  
  corp
}