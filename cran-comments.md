# quanteda.tidy 0.4

## Resubmission

This is a resubmission addressing all issues raised by Benjamin Altmann on 2025-12-03:

1. **Description field expanded**: The Description field now provides a detailed paragraph explaining the package functionality, including the types of operations supported (row operations, column operations, grouped operations, and two-table verbs) and their purposes.

2. **References added**: Added references to both quanteda and dplyr in the Description field using the required format with DOIs:
   - Benoit et al. (2018) <doi:10.21105/joss.00774> for quanteda
   - Wickham et al. (2023) <doi:10.32614/CRAN.package.dplyr> for dplyr

3. **\value tags added to all Rd files**: Added @return documentation to all exported functions specifying the return type (corpus object) and meaning. The following files were updated:
   - add_tally.Rd
   - arrange.corpus.Rd
   - distinct.corpus.Rd
   - dplyr_cols.Rd (also added \arguments)
   - dplyr_context.Rd (also added \arguments)
   - dplyr_groups.Rd (also added \arguments)
   - dplyr_pairs.Rd (also added \arguments)
   - dplyr_rows.Rd (also added \arguments)
   - dplyr_vector.Rd (also added \arguments)
   - filter.corpus.Rd
   - glimpse.corpus.Rd
   - mutate.corpus.Rd
   - pull.corpus.Rd
   - relocate.corpus.Rd
   - rename.corpus.Rd
   - select.corpus.Rd

## Purpose

Adds tidyverse (dplyr) functionality to the document variables attached to quanteda corpus objects.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Dependencies

None; this is a new package.
