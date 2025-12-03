## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "##"
)

## ----setup, message=FALSE-----------------------------------------------------
library(quanteda.tidy)

## ----function-table, echo=FALSE-----------------------------------------------
func_table <- data.frame(
  Category = c(
    rep("Rows", 5),
    rep("Columns", 6),
    rep("Groups of rows", 2),
    "Pairs of data frames"
  ),
  Function = c(
    # Rows
    "`filter()`", "`slice()`, `slice_head()`, `slice_tail()`",
    "`slice_sample()`", "`slice_min()`, `slice_max()`", "`arrange()`, `distinct()`",
    # Columns
    "`select()`", "`rename()`, `rename_with()`", "`relocate()`",
    "`mutate()`, `transmute()`", "`pull()`", "`glimpse()`",
    # Groups
    "`add_count()`", "`add_tally()`",
    # Pairs
    "`left_join()`"
  ),
  Description = c(
    # Rows
    "Subset documents based on docvar conditions",
    "Subset documents by position",
    "Randomly sample documents",
    "Select documents with min/max docvar values",
    "Reorder documents; keep unique documents",
    # Columns
    "Keep or drop docvars by name",
    "Rename docvars",
    "Change docvar column order",
    "Create or modify docvars",
    "Extract a single docvar as a vector",
    "Get a quick overview of the corpus",
    # Groups
    "Add count by group as a docvar",
    "Add total count as a docvar",
    # Pairs
    "Join corpus with external data frame"
  )
)
knitr::kable(func_table, caption = "quanteda.tidy functions by category")

## ----filter-------------------------------------------------------------------
# Keep only Roosevelt's speeches
data_corpus_inaugural %>%
  filter(President == "Roosevelt") %>%
  summary()

## ----slice--------------------------------------------------------------------
# First 3 documents
slice(data_corpus_inaugural, 1:3)

# First 10%
slice_head(data_corpus_inaugural, prop = 0.10)

# Last 3 documents
slice_tail(data_corpus_inaugural, n = 3)

## ----slice-sample-------------------------------------------------------------
set.seed(42)
slice_sample(data_corpus_inaugural, n = 5)

## ----slice-minmax-------------------------------------------------------------
# Add token counts first
corp <- data_corpus_inaugural %>%
  mutate(n_tokens = ntoken(data_corpus_inaugural))

# Shortest speeches
slice_min(corp, n_tokens, n = 3)

# Longest speeches
slice_max(corp, n_tokens, n = 3)

## ----arrange------------------------------------------------------------------
# Sort alphabetically by president
data_corpus_inaugural[1:5] %>%
  arrange(President)

# Sort by year descending
data_corpus_inaugural[1:5] %>%
  arrange(desc(Year))

## ----distinct-----------------------------------------------------------------
# Keep first document for each president
data_corpus_inaugural %>%
  distinct(President, .keep_all = TRUE) %>%
  summary(n = 10)

## ----select-------------------------------------------------------------------
data_corpus_inaugural %>%
  select(President, Year) %>%
  summary(n = 5)

## ----rename-------------------------------------------------------------------
data_corpus_inaugural %>%
  rename(LastName = President, Given = FirstName) %>%
  summary(n = 5)

## ----rename-with--------------------------------------------------------------
data_corpus_inaugural %>%
  rename_with(toupper) %>%
  summary(n = 5)

## ----relocate-----------------------------------------------------------------
data_corpus_inaugural %>%
  relocate(Party, President) %>%
  summary(n = 5)

## ----mutate-------------------------------------------------------------------
data_corpus_inaugural %>%
  mutate(
    fullname = paste(FirstName, President, sep = " "),
    century = floor(Year / 100) + 1
  ) %>%
  summary(n = 5)

## ----transmute----------------------------------------------------------------
data_corpus_inaugural %>%
  transmute(
    speech_id = paste(Year, President, sep = "-"),
    party = Party
  ) %>%
  summary(n = 5)

## ----pull---------------------------------------------------------------------
data_corpus_inaugural %>%
  filter(Year >= 2000) %>%
  pull(President)

## ----glimpse------------------------------------------------------------------
glimpse(data_corpus_inaugural)

## ----add-count----------------------------------------------------------------
# Count speeches per president
data_corpus_inaugural %>%
  add_count(President, name = "n_speeches") %>%
  filter(n_speeches > 1) %>%
  summary(n = 10)

## ----add-tally----------------------------------------------------------------
data_corpus_inaugural %>%
  slice(1:5) %>%
  add_tally() %>%
  summary()

## ----left-join----------------------------------------------------------------
# Create some external data
party_colors <- data.frame(
  Party = c("Democratic", "Republican", "none", "Federalist",
            "Democratic-Republican", "Whig"),
  color = c("blue", "red", "gray", "purple", "green", "orange")
)

# Join to corpus
data_corpus_inaugural %>%
  left_join(party_colors, by = "Party") %>%
  summary(n = 10)

## ----left-join-docname--------------------------------------------------------
# Create data with document name as key
doc_metadata <- data.frame(
  docname = c("1789-Washington", "1793-Washington", "1797-Adams"),
  notes = c("First inaugural", "Second inaugural", "First Adams speech")
)

# Join using docname
data_corpus_inaugural[1:5] %>%
  left_join(doc_metadata, by = "docname") %>%
  summary()

## ----left-join-docname2-------------------------------------------------------
doc_metadata2 <- data.frame(
  doc_id = c("1789-Washington", "1793-Washington"),
  rating = c(5, 4)
)

data_corpus_inaugural[1:5] %>%
  left_join(doc_metadata2, by = c("docname" = "doc_id")) %>%
  summary()

## ----piping-------------------------------------------------------------------
data_corpus_inaugural %>%
  # Add metadata
  mutate(
    decade = floor(Year / 10) * 10,
    n_tokens = ntoken(data_corpus_inaugural)
  ) %>%
  # Filter to 20th century

  filter(Year >= 1900, Year < 2000) %>%
  # Keep only relevant columns
  select(President, Party, decade, n_tokens) %>%
  # Sort by speech length

  arrange(desc(n_tokens)) %>%
  summary(n = 10)

