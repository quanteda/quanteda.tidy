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
                       President = c("Roosevelt", 
                                     "Roosevelt", "Roosevelt", "Roosevelt", "Roosevelt"), 
                       FirstName = c("Theodore", 
                                     "Franklin D.", "Franklin D.", "Franklin D.", "Franklin D."), 
                       Party = structure(c(5L, 1L, 1L, 1L, 1L), 
                                         .Label = c("Democratic", 
                                                    "Democratic-Republican", "Federalist", "none", "Republican", 
                                                    "Whig"), 
                                         class = "factor")), 
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
        structure(list(Year = 1789L, President = "Washington", FirstName = "George", 
                       Party = structure(4L, .Label = c("Democratic", "Democratic-Republican", 
                                                        "Federalist", "none", "Republican", "Whig"), class = "factor"), 
                       pyear = "Washington_1789"), 
                  row.names = c(NA, -1L), class = "data.frame")
    )
    expect_identical(
        docvars(mutate(data_corpus_inaugural[1:3], cent = floor(Year / 100) * 100), 
                "cent"),
        c(1700, 1700, 1700)
    )
})

test_that("corpus transmute() works", {
    expect_identical(
        docvars(transmute(data_corpus_inaugural[1], 
                       pyear = paste(President, Year, sep = "_"))),
        structure(list(pyear = "Washington_1789"), row.names = c(NA, 
                                                                 -1L), class = "data.frame")
    )
})

test_that("corpus select() works", {
    expect_identical(
        names(docvars(select(data_corpus_inaugural[1:2], Party, Year))),
        c("Party", "Year")
    )
    expect_identical(
        names(docvars(rename(data_corpus_inaugural[1:2], LastName = President))),
        c("Year", "LastName", "FirstName", "Party")
    )
})
