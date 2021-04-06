#' @name filter
#' @rdname dplyr_single
#' @importFrom dplyr filter
#' @export
NULL

#' Return documents with matching conditions
#'
#' Use `filter()` to select documents where conditions evaluated on document
#' variables are true. Documents where the condition evaluates to `NA` are
#' dropped. A tidy replacement for [corpus_subset()][quanteda::corpus_subset()].
#'
#' @param .data a \pkg{quanteda} object whose documents will be filtered
#' @param ... Logical predicates defined in terms of the document variables in
#'   `.data`, or a condition supplied externally whose length matches `the
#'   number of `ndoc(.data)`.  See [filter][dplyr::filter()].
#' @inheritParams dplyr::filter
#' @importFrom quanteda corpus convert %>% meta
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'     filter(Year < 1810) %>%
#'     summary()
#'
filter.corpus <- function(.data, ..., .preserve = FALSE) {
    corpus_stv_bydoc(.data, ..., .preserve = .preserve, fun = filter)
}

#' Return rows with matching conditions including feature matches
#'
#' Use filters to find rows of the return objects from many `textstat_*()`
#' functions where conditions are true, including matches to features using
#' `"glob"`, `"regex"` or `"fixed"` patterns.
#' @param .data a `textstat` object returned from one of the applicable
#' `textstat_*` functions in \pkg{quanteda}
#' @param ... filter conditions passed to \pkg{dplyr} [dplyr::filter()]
#' @inheritParams quanteda::pattern
#' @inheritParams quanteda::valuetype
#' @param case_insensitive ignore case when matching, if `TRUE`
#' @seealso  [quanteda.textstats::textstat_collocations()],
#'   [quanteda.textstats::textstat_keyness()],
#'   [quanteda.textstats::textstat_frequency()]
#' @keywords internal
#' @importFrom utils getS3method getFromNamespace
#' @export
#' @examples
#' period <- ifelse(docvars(data_corpus_inaugural, "Year") < 1945,
#'                  "pre-war", "post-war")
#' mydfm <- tokens(data_corpus_inaugural) %>%
#'     dfm() %>%
#'     dfm_group(groups = period)
#' keyness <- quanteda.textstats::textstat_keyness(mydfm)
#' filter(keyness, pattern = "america*")
#' filter(keyness, p < .00001, pattern = "america*")
#' filter(keyness, p < .00001) %>% head()
filter.textstat <- function(.data, ...,
                            pattern = NULL,
                            valuetype = c("glob", "regex", "fixed"),
                            case_insensitive = TRUE) {

    attrs <- attributes(.data)

    # get regex2id from quanteda
    regex2id <- getFromNamespace("pattern2id", "quanteda")

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
