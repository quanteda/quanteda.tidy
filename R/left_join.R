#' @name left_join
#' @rdname dplyr_pairs
#' @importFrom dplyr left_join
#' @export
NULL

#' Join corpus with a data frame
#'
#' `left_join()` adds columns from `y` to the corpus `x`, matching documents
#' based on document variables. This is a mutating join that keeps all documents
#' from `x` and adds matching values from `y`. If a document in `x` has no match
#' in `y`, the new columns will contain `NA`.
#'
#' @section Special handling of "docname":
#' This function provides special handling for joining on document names:
#'
#' - If `by = "docname"` (or "docname" appears in the `by` vector), the function
#'   will use `docnames(x)` as the joining column from the corpus, even if
#'   "docname" is not a document variable.
#' - If using `join_by(docname == other_col)`, the function will match
#'   `docnames(x)` to `other_col` in `y`.
#' - If "docname" exists as an actual document variable in `x`, that variable
#'   will be used instead of `docnames(x)`.
#'
#' @param x a \pkg{quanteda} corpus object
#' @param y a data frame or tibble to join
#' @param by a join specification. See [dplyr::left_join()] for details.
#'   Defaults to natural join using all variables with common names. Can use
#'   "docname" to join on document names (see Details).
#' @param copy if `y` is not a data frame or tibble, should it be copied?
#' @param suffix if there are non-joined duplicate variables in `x` and `y`,
#'   these suffixes will be added to disambiguate
#' @param ... other arguments passed to [dplyr::left_join()]
#' @param keep should the join keys from both `x` and `y` be preserved?
#' @return a corpus with document variables from both `x` and `y`
#' @name left_join.corpus
#' @importFrom quanteda corpus convert docnames docvars meta
#' @export
#' @examples
#' # Create example corpus and data
#' corp <- data_corpus_inaugural[1:5]
#'
#' # Create data to join with document names
#' doc_data <- data.frame(
#'   docname = c("1789-Washington", "1793-Washington", "1797-Adams"),
#'   century = c(18, 18, 18),
#'   speech_number = c(1, 2, 1)
#' )
#'
#' # Join using docname - matches docnames(corp) to doc_data$docname
#' left_join(corp, doc_data, by = "docname") %>%
#'   summary()
#'
#' # Join using different column names with named vector
#' doc_data2 <- data.frame(
#'   doc_id = c("1789-Washington", "1793-Washington"),
#'   rating = c(5, 4)
#' )
#' left_join(corp, doc_data2, by = c("docname" = "doc_id")) %>%
#'   summary()
#'
#' # Regular join on existing docvars
#' year_info <- data.frame(
#'   Year = c(1789, 1793, 1797, 1801, 1805),
#'   decade = c("1780s", "1790s", "1790s", "1800s", "1800s")
#' )
#' left_join(corp, year_info, by = "Year") %>%
#'   summary()
#'
left_join.corpus <- function(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"),
                              ..., keep = NULL) {
  # Store original docvars names to detect if we added a temporary column
  orig_docvars_names <- names(docvars(x))
  added_docname <- FALSE

  # Check if we need to handle "docname" specially
  needs_docname <- FALSE

  # Handle different types of 'by' specifications
  if (!is.null(by)) {
    # Check if by is a join_by object (has class "dplyr_join_by")
    if (inherits(by, "dplyr_join_by")) {
      # Extract the left-hand side variable names from join_by
      # The structure has names in the 'x' element
      by_vars <- by$x
      if ("docname" %in% by_vars && !"docname" %in% names(docvars(x))) {
        needs_docname <- TRUE
      }
    } else if (is.character(by)) {
      # Simple character vector or named vector
      # For named vectors, names are 'x' vars, values are 'y' vars
      if (is.null(names(by))) {
        # Unnamed vector - check if "docname" is present
        if ("docname" %in% by && !"docname" %in% names(docvars(x))) {
          needs_docname <- TRUE
        }
      } else {
        # Named vector - check names (which correspond to x columns)
        if ("docname" %in% names(by) && !"docname" %in% names(docvars(x))) {
          needs_docname <- TRUE
        }
      }
    }
  }

  # Get docvars as data frame
  x_docvars <- as.data.frame(docvars(x))

  # Temporarily add docname column if needed
  if (needs_docname) {
    x_docvars$docname <- docnames(x)
    added_docname <- TRUE
  }

  # Perform the join
  result_df <- left_join(x_docvars, y, by = by, copy = copy, suffix = suffix,
                         ..., keep = keep)

  # Remove the temporary docname column if we added it
  if (added_docname && "docname" %in% names(result_df) &&
      !"docname" %in% orig_docvars_names) {
    result_df$docname <- NULL
  }

  # Update docvars
  docvars(x) <- result_df
  x
}
