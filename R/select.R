#' @name select
#' @rdname dplyr_cols
#' @importFrom dplyr select
#' @export
NULL

# Alias required for help links in downstream packages
#' @aliases select_helpers
#' @importFrom tidyselect contains
#' @export
tidyselect::contains
#' @importFrom tidyselect ends_with
#' @export
tidyselect::ends_with
#' @importFrom tidyselect everything
#' @export
tidyselect::everything
#' @importFrom tidyselect matches
#' @export
tidyselect::matches
#' @importFrom tidyselect num_range
#' @export
tidyselect::num_range
#' @importFrom tidyselect one_of
#' @export
tidyselect::one_of
#' @importFrom tidyselect starts_with
#' @export
tidyselect::starts_with
#' @importFrom tidyselect last_col
#' @export
tidyselect::last_col
#' @importFrom tidyselect any_of
#' @export
tidyselect::any_of
#' @importFrom tidyselect all_of
#' @export
tidyselect::all_of


#' Subset docvars using their names and types
#'
#' Select (and optionally rename) document variables in a data frame, using a
#' concise mini-language that makes it easy to refer to variables based on their
#' name (e.g. `a:f` selects all columns from `a` on the left to `f` on the
#' right). You can also use predicate functions like `is.numeric` to select
#' variables based on their properties.
#' 
#' For an overview of selection features, see [dplyr::select()].
#' @param .data a \pkg{quanteda} object with document variables
#' @inheritParams dplyr::select
#' @export
#' @examples
#' data_corpus_inaugural %>%
#'   select(Party, Year) %>%
#'   summary(n = 5)
#'
select.corpus <- function(.data, ...) {
  corpus_stv_byvar(.data, ..., fun = select)
}
