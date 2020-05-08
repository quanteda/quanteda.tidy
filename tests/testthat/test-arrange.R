context("test arrange()")

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
