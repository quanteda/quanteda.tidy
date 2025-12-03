context("test single table dplyr verbs")

test_that("corpus arrange() works", {
    expect_identical(
        docnames(arrange(data_corpus_inaugural[1:3], c(3, 1, 2))),
        c("1793-Washington", "1797-Adams", "1789-Washington")
    )
    expect_identical(
        docnames(arrange(data_corpus_inaugural[1:3], President)),
        c("1797-Adams", "1789-Washington", "1793-Washington")
    )
    expect_identical(
        docnames(arrange(data_corpus_inaugural[1:3], President, desc(Year))),
        c("1797-Adams", "1793-Washington", "1789-Washington")
    )
})

test_that("corpus filter() works", {
    expect_identical(
        docnames(filter(data_corpus_inaugural, President == "Roosevelt")),
        c("1905-Roosevelt", "1933-Roosevelt", "1937-Roosevelt",
          "1941-Roosevelt", "1945-Roosevelt")
    )
    expect_identical(
        docvars(filter(data_corpus_inaugural, President == "Roosevelt")),
        structure(list(Year = c(1905L, 1933L, 1937L, 1941L, 1945L),
                       President = c("Roosevelt", "Roosevelt", "Roosevelt",
                                     "Roosevelt", "Roosevelt"),
                       FirstName = c("Theodore", "Franklin D.", "Franklin D.",
                                     "Franklin D.", "Franklin D."),
                       Party = structure(c(5L, 1L, 1L, 1L, 1L), .Label = c("Democratic", 
                                                                           "Democratic-Republican", "Federalist", "none", "Republican", 
                                                                           "Whig"), class = "factor")),
                  row.names = c(NA, -5L), class = "data.frame")
    )
    expect_identical(
        docnames(filter(data_corpus_inaugural[1:3], c(TRUE, FALSE, TRUE))),
        c("1789-Washington", "1797-Adams")
    )

    x <- c(TRUE, FALSE, TRUE)
    expect_identical(
        docnames(filter(data_corpus_inaugural[1:3], x)),
        c("1789-Washington", "1797-Adams")
    )
})

test_that("corpus mutate() works", {
    expect_identical(
        docvars(mutate(data_corpus_inaugural[1],
                       pyear = paste(President, Year, sep = "_"))),
        structure(list(Year = 1789L, President = "Washington",
                       FirstName = "George",
                       Party = structure(4L, .Label = c("Democratic", "Democratic-Republican", 
                                                        "Federalist", "none", "Republican", "Whig"), class = "factor"),
                       pyear = "Washington_1789"),
                  row.names = c(NA, -1L), class = "data.frame")
    )
    expect_identical(
        docvars(mutate(data_corpus_inaugural[1:3],
                       cent = floor(Year / 100) * 100),
                "cent"),
        c(1700, 1700, 1700)
    )
})

test_that("corpus transmute() works", {
    expect_identical(
        docvars(transmute(data_corpus_inaugural[1],
                       pyear = paste(President, Year, sep = "_"))),
        structure(list(pyear = "Washington_1789"), row.names = c(NA, -1L),
                  class = "data.frame")
    )
})

test_that("corpus select() works", {
    expect_identical(
        names(docvars(select(data_corpus_inaugural[1:2], Party, Year))),
        c("Party", "Year")
    )
    expect_identical(
        names(docvars(rename(data_corpus_inaugural[1:2],
                             LastName = President))),
        c("Year", "LastName", "FirstName", "Party")
    )
})

test_that("pull works", {
    corp <- head(data_corpus_inaugural, 3)
    expect_identical(
        corp %>% pull(President),
        c("Washington", "Washington", "Adams")
    )
    expect_identical(
        corp %>% pull(1),
        c(1789L, 1793L, 1797L)
    )
    expect_identical(
        corp %>% pull(-1),
        structure(c(4L, 4L, 3L),
                  .Label = c("Democratic", "Democratic-Republican",
                             "Federalist", "none", "Republican", "Whig"),
                  class = "factor")
    )

    toks <- tokens(corp)
    expect_identical(
        toks %>% pull(President),
        c("Washington", "Washington", "Adams")
    )

    dfmat <- dfm(toks)
    expect_identical(
        dfmat %>% pull(President),
        c("Washington", "Washington", "Adams")
    )
})

test_that("pull gives informative error with empty docvars", {
    corp <- corpus(letters[1:3])
    expect_error(
        pull(corp),
        "Cannot extract document variables: corpus has no docvars"
    )

    toks <- tokens(corp)
    expect_error(
        pull(toks),
        "Cannot extract document variables: corpus has no docvars"
    )

    dfmat <- dfm(toks)
    expect_error(
        pull(dfmat),
        "Cannot extract document variables: corpus has no docvars"
    )
})

test_that("corpus distinct() works", {
    # Test distinct with .keep_all = FALSE (default behavior)
    corp <- data_corpus_inaugural[c(1, 2, 4)]  # Washington, Washington, Jefferson
    result <- distinct(corp, President)
    expect_identical(
        docnames(result),
        c("1789-Washington", "1801-Jefferson")
    )
    expect_identical(
        names(docvars(result)),
        c("President")
    )

    # Test distinct with .keep_all = TRUE
    result_keep_all <- distinct(corp, President, .keep_all = TRUE)
    expect_identical(
        docnames(result_keep_all),
        c("1789-Washington", "1801-Jefferson")
    )
    expect_identical(
        names(docvars(result_keep_all)),
        c("Year", "President", "FirstName", "Party")
    )

    # Test distinct with multiple variables
    corp2 <- data_corpus_inaugural[1:10]
    result_multi <- distinct(corp2, Party, .keep_all = TRUE)
    expect_true(
        nrow(docvars(result_multi)) < nrow(docvars(corp2))
    )
})

test_that("corpus relocate() works", {
    corp <- data_corpus_inaugural[1:3]

    # Test relocating to front
    result <- relocate(corp, Party)
    expect_identical(
        names(docvars(result)),
        c("Party", "Year", "President", "FirstName")
    )

    # Test relocating to end
    result_after <- relocate(corp, Year, .after = last_col())
    expect_identical(
        names(docvars(result_after)),
        c("President", "FirstName", "Party", "Year")
    )

    # Test relocating before a column
    result_before <- relocate(corp, Party, .before = President)
    expect_identical(
        names(docvars(result_before)),
        c("Year", "Party", "President", "FirstName")
    )

    # Verify document order is preserved
    expect_identical(
        docnames(result),
        docnames(corp)
    )
})

test_that("corpus rename_with() works", {
    corp <- data_corpus_inaugural[1:3]

    # Test renaming all columns with a function
    result <- rename_with(corp, toupper)
    expect_identical(
        names(docvars(result)),
        c("YEAR", "PRESIDENT", "FIRSTNAME", "PARTY")
    )

    # Test renaming with selection
    result_select <- rename_with(corp, toupper, starts_with("P"))
    expect_identical(
        names(docvars(result_select)),
        c("Year", "PRESIDENT", "FirstName", "PARTY")
    )

    # Test with custom function
    add_prefix <- function(x) paste0("doc_", x)
    result_prefix <- rename_with(corp, add_prefix, all_of(c("Year", "President")))
    expect_identical(
        names(docvars(result_prefix)),
        c("doc_Year", "doc_President", "FirstName", "Party")
    )

    # Verify document order and content are preserved
    expect_identical(
        docnames(result),
        docnames(corp)
    )
    expect_identical(
        docvars(result)$YEAR,
        docvars(corp)$Year
    )
})

test_that("corpus slice() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test basic slicing by position
    result <- slice(corp, 1:3)
    expect_identical(
        docnames(result),
        docnames(corp)[1:3]
    )
    expect_equal(ndoc(result), 3)

    # Test slicing with negative indices
    result_neg <- slice(corp, -(1:5))
    expect_equal(ndoc(result_neg), 5)
    expect_identical(
        docnames(result_neg),
        docnames(corp)[6:10]
    )

    # Test slicing with non-sequential indices
    result_skip <- slice(corp, c(1, 3, 5, 7, 9))
    expect_equal(ndoc(result_skip), 5)
    expect_identical(
        docnames(result_skip)[1],
        docnames(corp)[1]
    )
})

test_that("corpus slice_head() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test with n argument
    result_n <- slice_head(corp, n = 3)
    expect_equal(ndoc(result_n), 3)
    expect_identical(
        docnames(result_n),
        docnames(corp)[1:3]
    )

    # Test with prop argument
    result_prop <- slice_head(corp, prop = 0.3)
    expect_equal(ndoc(result_prop), 3)
    expect_identical(
        docnames(result_prop),
        docnames(corp)[1:3]
    )
})

test_that("corpus slice_tail() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test with n argument
    result_n <- slice_tail(corp, n = 3)
    expect_equal(ndoc(result_n), 3)
    expect_identical(
        docnames(result_n),
        docnames(corp)[8:10]
    )

    # Test with prop argument
    result_prop <- slice_tail(corp, prop = 0.2)
    expect_equal(ndoc(result_prop), 2)
    expect_identical(
        docnames(result_prop),
        docnames(corp)[9:10]
    )
})

test_that("corpus slice_sample() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test with n argument
    set.seed(123)
    result_n <- slice_sample(corp, n = 5)
    expect_equal(ndoc(result_n), 5)
    expect_true(all(docnames(result_n) %in% docnames(corp)))

    # Test with prop argument
    set.seed(456)
    result_prop <- slice_sample(corp, prop = 0.5)
    expect_equal(ndoc(result_prop), 5)
    expect_true(all(docnames(result_prop) %in% docnames(corp)))

    # Test that different seeds give different results
    set.seed(789)
    result_diff <- slice_sample(corp, n = 5)
    expect_false(identical(docnames(result_n), docnames(result_diff)))
})

test_that("corpus slice_min() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test with n argument
    result_n <- slice_min(corp, Year, n = 3)
    expect_equal(ndoc(result_n), 3)
    expect_true(all(docvars(result_n)$Year <= 1797))

    # Test with prop argument
    result_prop <- slice_min(corp, Year, prop = 0.2)
    expect_equal(ndoc(result_prop), 2)

    # Verify ordering (should be in original order, not sorted)
    result_ordered <- slice_min(corp, Year, n = 5)
    expect_true(min(docvars(result_ordered)$Year) == min(docvars(corp)$Year))
})

test_that("corpus slice_max() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test with n argument (top 3 years are 1825, 1821, 1817)
    result_n <- slice_max(corp, Year, n = 3)
    expect_equal(ndoc(result_n), 3)
    expect_true(all(docvars(result_n)$Year >= 1817))

    # Test with prop argument
    result_prop <- slice_max(corp, Year, prop = 0.3)
    expect_equal(ndoc(result_prop), 3)

    # Test with ties
    corp_ties <- data_corpus_inaugural[c(1, 2, 3)]  # Has two 179x years
    result_ties <- slice_max(corp_ties, Year, n = 1, with_ties = TRUE)
    expect_true(ndoc(result_ties) >= 1)
})

test_that("corpus add_count() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test basic add_count by single variable
    result <- add_count(corp, President)
    expect_true("n" %in% names(docvars(result)))
    expect_equal(ndoc(result), ndoc(corp))

    # Check that Washington has count of 2 (appears twice in first 10)
    washington_count <- unique(docvars(result)[docvars(result)$President == "Washington", "n"])
    expect_equal(washington_count, 2)

    # Test add_count with custom name
    result_custom <- add_count(corp, President, name = "pres_count")
    expect_true("pres_count" %in% names(docvars(result_custom)))
    expect_false("n" %in% names(docvars(result_custom)))

    # Test add_count by multiple variables
    result_multi <- add_count(corp, President, Party)
    expect_true("n" %in% names(docvars(result_multi)))

    # Test add_count with sort
    result_sort <- add_count(corp, President, sort = TRUE)
    expect_true("n" %in% names(docvars(result_sort)))
    # First document should have the highest count or tied for highest
    first_count <- docvars(result_sort)$n[1]
    expect_true(first_count >= max(docvars(result_sort)$n) - 1)

    # Verify original docvars are preserved
    expect_true(all(c("Year", "President", "FirstName", "Party") %in% names(docvars(result))))
})

test_that("corpus add_tally() works", {
    corp <- data_corpus_inaugural[1:10]

    # Test basic add_tally (adds total count to each row)
    result <- add_tally(corp)
    expect_true("n" %in% names(docvars(result)))
    expect_equal(ndoc(result), ndoc(corp))

    # All rows should have the same count (total number of documents)
    expect_true(all(docvars(result)$n == 10))

    # Test add_tally with custom name
    result_custom <- add_tally(corp, name = "total")
    expect_true("total" %in% names(docvars(result_custom)))
    expect_false("n" %in% names(docvars(result_custom)))
    expect_true(all(docvars(result_custom)$total == 10))

    # Test add_tally with a subset that has duplicates
    corp_subset <- data_corpus_inaugural[c(1, 1, 2, 2, 2, 3)]
    result_subset <- add_tally(corp_subset)
    expect_equal(ndoc(result_subset), 6)
    expect_true(all(docvars(result_subset)$n == 6))

    # Verify original docvars are preserved
    expect_true(all(c("Year", "President", "FirstName", "Party") %in% names(docvars(result))))
})

test_that("add_count() and add_tally() with wt argument", {
    corp <- data_corpus_inaugural[1:10]

    # Create a corpus with a weight variable
    corp_wt <- mutate(corp, weight = Year - min(Year) + 1)

    # Test add_count with weights
    result_count_wt <- add_count(corp_wt, President, wt = weight)
    expect_true("n" %in% names(docvars(result_count_wt)))

    # Check that weighted count for Washington is sum of weights
    # Washington appears at indices 1 and 2 (years 1789 and 1793)
    # weights are: (1789-1789+1)=1 and (1793-1789+1)=5, sum=6
    washington_weighted <- unique(docvars(result_count_wt)[docvars(result_count_wt)$President == "Washington", "n"])
    expect_equal(washington_weighted, 6)

    # Test add_tally with weights
    result_tally_wt <- add_tally(corp_wt, wt = weight)
    expect_true("n" %in% names(docvars(result_tally_wt)))
    # All rows should have the same weighted total
    expected_total <- sum(docvars(corp_wt)$weight)
    expect_true(all(docvars(result_tally_wt)$n == expected_total))
})
