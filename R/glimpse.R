#' @name glimpse
#' @rdname glimpse.corpus
#' @keywords internal
#' @importFrom tibble glimpse
#' @export
NULL

#' Get a glimpse of a quanteda object
#'
#' Implementation of [glimpse][tibble::glimpse()] for \pkg{quanteda} objects,
#' allowing docvars to be viewed.
#' @param x a corpus or \pkg{quanteda} object
#' @param width width of the output; default to the width of the console
#' @param ... unused
#' @importFrom quanteda texts corpus convert %>% meta `texts<-`
#' @export
#' @examples
#' glimpse(data_corpus_inaugural)
glimpse.corpus <- function(x, width = NULL, ...) {
  text.width <- 10
  texts(x) <- paste0(substring(texts(x), 1, text.width),
                     ifelse(nchar(texts(x)) > text.width, "\u2026", ""))
  convert(x, to = "data.frame") %>%
    glimpse(width = width)
}
