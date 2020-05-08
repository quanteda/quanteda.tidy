#' @importFrom dplyr filter
#' @export
dplyr::filter

#' Return rows with matching conditions including feature matches
#'
#' Use filters to find rows of the return objects from many \code{textstat_*()}
#' functions where conditions are true, including matches to features using
#' \code{"glob"}, \code{"regex"} or \code{"fixed"} patterns.
#' @param .data a \code{textstat} object returned from one of the applicable
#' \code{textstat_*} functions in \pkg{quanteda}
#' @param ... filter conditions passed to \pkg{dplyr} \code{\link[dplyr]{filter}}
#' @inheritParams quanteda::pattern
#' @inheritParams quanteda::valuetype
#' @param case_insensitive ignore case when matching, if \code{TRUE}
#' @seealso  \code{\link[quanteda]{textstat_collocations}},
#'   \code{\link[quanteda]{textstat_keyness}},
#'   \code{\link[quanteda]{textstat_frequency}}
#' @keywords textstat
#' @importFrom utils getS3method getFromNamespace
#' @export
#' @examples
#' period <- ifelse(docvars(data_corpus_inaugural, "Year") < 1945, "pre-war", "post-war")
#' mydfm <- dfm(data_corpus_inaugural, groups = period)
#' keyness <- textstat_keyness(mydfm)
#' filter(keyness, pattern = "america*")
#' filter(keyness, p < .00001, pattern = "america*") 
#' filter(keyness, p < .00001) %>% head()
filter.textstat <- function(.data, ...,
                            pattern = NULL, 
                            valuetype = c("glob", "regex", "fixed"),
                            case_insensitive = TRUE) {
    
    attrs <- attributes(.data)
    
    # get regex2id from quanteda
    regex2id <- getFromNamespace("regex2id", "quanteda")
    
    # call dplyr filter, if ... arguments are supplied
    ndots <- function(...) nargs()
    if (length(ndots)) {
        .data <- getS3method("filter", "data.frame")(.data, ...)
    }

    # select on features if specified
    if (!is.null(pattern)) {
        valuetype <- match.arg(valuetype)
        id <- unlist(regex2id(pattern, .data[[1]], valuetype, case_insensitive))
        .data <- .data[id, , drop = FALSE]
    }
    
    # reclass the object as textstat etc.
    class(.data) <- attrs$class
    .data
}