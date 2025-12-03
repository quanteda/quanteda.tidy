context("test left_join")

test_that("left_join works with regular docvars", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(id = 1:3, name = c("a", "b", "c")))
    df <- data.frame(id = 1:4, info = c("x", "y", "z", "w"))

    result <- left_join(corp, df, by = "id")

    expect_identical(docnames(result), c("doc1", "doc2", "doc3"))
    expect_identical(
        docvars(result),
        data.frame(
            id = 1:3,
            name = c("a", "b", "c"),
            info = c("x", "y", "z")
        )
    )
})

test_that("left_join handles unmatched rows with NA", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(id = 1:3))
    df <- data.frame(id = c(1, 3, 5), info = c("a", "c", "e"))

    result <- left_join(corp, df, by = "id")

    expect_equal(
        docvars(result),
        data.frame(
            id = 1:3,
            info = c("a", NA, "c")
        )
    )
})

test_that("left_join works with docname in y", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(id = 1:3))
    df <- data.frame(
        docname = c("doc1", "doc2", "doc4"),
        info = c("a", "b", "d")
    )

    result <- left_join(corp, df, by = "docname")

    expect_identical(docnames(result), c("doc1", "doc2", "doc3"))
    expect_identical(
        docvars(result),
        data.frame(
            id = 1:3,
            info = c("a", "b", NA)
        )
    )
    # docname should not be added as a docvar
    expect_false("docname" %in% names(docvars(result)))
})

test_that("left_join works with join_by(docname == other_col)", {
    skip_if_not_installed("dplyr", minimum_version = "1.1.0")
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(id = 1:3))
    df <- data.frame(
        doc_id = c("doc1", "doc2", "doc4"),
        info = c("a", "b", "d")
    )

    result <- left_join(corp, df, by = dplyr::join_by(docname == doc_id))

    expect_identical(docnames(result), c("doc1", "doc2", "doc3"))
    expect_identical(
        docvars(result),
        data.frame(
            id = 1:3,
            info = c("a", "b", NA)
        )
    )
    # docname should not be added as a docvar
    expect_false("docname" %in% names(docvars(result)))
})

test_that("left_join works with named vector c(docname = other_col)", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(id = 1:3))
    df <- data.frame(
        doc_id = c("doc1", "doc2", "doc4"),
        info = c("a", "b", "d")
    )

    result <- left_join(corp, df, by = c("docname" = "doc_id"))

    expect_identical(docnames(result), c("doc1", "doc2", "doc3"))
    expect_identical(
        docvars(result),
        data.frame(
            id = 1:3,
            info = c("a", "b", NA)
        )
    )
    # docname should not be added as a docvar
    expect_false("docname" %in% names(docvars(result)))
})

test_that("left_join uses existing docname docvar when present", {
    # When docname exists as a docvar, it should use that instead of docnames(x)
    corp <- corpus(c(a = "text1", b = "text2", c = "text3"),
                   docvars = data.frame(
                       docname = c("doc1", "doc2", "doc3"),
                       id = 1:3
                   ))
    df <- data.frame(
        docname = c("doc1", "doc2", "doc4"),
        info = c("a", "b", "d")
    )

    result <- left_join(corp, df, by = "docname")

    # Document names should be unchanged (a, b, c)
    expect_identical(docnames(result), c("a", "b", "c"))
    # Join should use the docname docvar, not docnames()
    expect_identical(
        docvars(result),
        data.frame(
            docname = c("doc1", "doc2", "doc3"),
            id = 1:3,
            info = c("a", "b", NA)
        )
    )
})

test_that("left_join works with multiple join columns", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2", doc3 = "text3"),
                   docvars = data.frame(
                       year = c(2020, 2021, 2020),
                       country = c("US", "US", "UK")
                   ))
    df <- data.frame(
        year = c(2020, 2021, 2020, 2021),
        country = c("US", "US", "UK", "UK"),
        value = c(10, 20, 30, 40)
    )

    result <- left_join(corp, df, by = c("year", "country"))

    expect_identical(
        docvars(result),
        data.frame(
            year = c(2020, 2021, 2020),
            country = c("US", "US", "UK"),
            value = c(10, 20, 30)
        )
    )
})

test_that("left_join preserves corpus metadata", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2"),
                   docvars = data.frame(id = 1:2))
    meta(corp, "source") <- "test"
    meta(corp, "notes") <- "example"

    df <- data.frame(id = 1:2, info = c("a", "b"))
    result <- left_join(corp, df, by = "id")

    expect_identical(meta(result, "source"), "test")
    expect_identical(meta(result, "notes"), "example")
})

test_that("left_join handles suffix parameter correctly", {
    corp <- corpus(c(doc1 = "text1", doc2 = "text2"),
                   docvars = data.frame(id = 1:2, value = c("x", "y")))
    df <- data.frame(id = 1:2, value = c("a", "b"))

    result <- left_join(corp, df, by = "id", suffix = c("_corp", "_df"))

    expect_identical(
        names(docvars(result)),
        c("id", "value_corp", "value_df")
    )
})
