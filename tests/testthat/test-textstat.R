context("test textstat_*")

test_that("test filter method for textstat data.frames", {
    skip_if_not_installed("quanteda.textstats")
    library("quanteda.textstats")
    toks <- tokens(data_char_ukimmig2010[1:2])
    mt <- dfm(toks)
    col <- textstat_collocations(toks)
    key <- textstat_keyness(mt)
    frq <- textstat_frequency(mt)

    col_test <- filter(col, pattern = "*political*")
    expect_equal(col_test$collocation,
                 col$collocation[grep("political", col$collocation)])

    key_test <- filter(key, pattern = "poli*")
    expect_equal(key_test$feature,
                 key$feature[grep("^poli", key$feature)])

    frq_test <- filter(frq, pattern = "poli*")
    expect_equal(frq_test$feature,
                 frq$feature[grep("^poli", frq$feature)])

    dplyr_test <- filter(key, p < .05, pattern = "poli*")
    expect_equivalent(
        as.data.frame(dplyr_test),
        data.frame(feature = "police", chi2 = -5.351057, p = .0207,
                   n_target = 2, n_reference = 2, stringsAsFactors = FALSE),
        tolerance = .001
    )
})
