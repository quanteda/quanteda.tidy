context("test glimpse")

test_that("glimpse works on a corpus", {
  corp <- corpus(c(d1 = "a b c", d2 = paste(LETTERS, collapse = " ")),
                 docvars = data.frame(myint = c(10L, 20L),
                                      lab = c("one", "two")))
  expect_output(
    glimpse(corp),
    'Rows: 2\\nColumns: 4\\n\\$ doc_id.*"d1", "d2"\\n\\$ text.*"a b c", "A B C D E …".*\\$ myint.*\\$ lab.*"one", "two"'
  )
})
