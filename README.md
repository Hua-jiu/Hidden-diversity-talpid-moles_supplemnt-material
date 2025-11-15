# Hidden Diversity of Talpid Moles — Supplementary Materials

This directory contains supplementary data and code for the paper "Unraveling hidden species diversity of talpid moles using phylogenomics and skull-based deep learning." It includes morphometric analyses of talpid mole skulls (Parascaptor, Euroscaptor) using both geometric and measurement-based approaches.

## Overview
- **Geometric morphometrics** (ventral cranium outlines): EFA, PCA, CVA, and visualization.
- **Measurement-based morphometrics**: Data cleaning, statistics, log10 transformations, PCA/CVA analyses, and visualization.
- **Reproducibility**: Pre-saved R workspaces for fast reproduction of results.

## Directory Structure

- `geometric_morphometrics/`
  - `Parascaptor_V_JPG/`, `Euroscaptor_V_JPG/`: Raw ventral skull images (one per specimen).
  - `Parascaptor_V_JPG_OUT/`, `Euroscaptor_V_JPG_OUT/`: Processed single-specimen outline outputs.
  - `R_Data/`: Pre-saved R workspaces (`Parascaptor_skull_ventral.RData`, `Euroscaptor_skull_ventral.RData`).
  - `testcode-ventral.Rmd`: Main workflow for outline extraction and downstream analyses.

- `measurement-based_morphometrics/`
  - `Parascaptor.R`, `Euroscaptor.R`: Measurement-based morphometric analysis scripts (including PCA, CVA, convex hull visualization).
  - `*.xlsx`: Measurement tables (raw and log10-transformed), e.g., `euroscaptor_1023.xlsx`, `para_log10.xlsx`.

- `LICENSE`, `README.md`: License and documentation files.

## Geometric Morphometrics
- Main entry point: `geometric_morphometrics/testcode-ventral.Rmd` (from images to EFA, PCA, CVA, and visualization).
- Required R packages: `outlineR`, `Momocs`, `geomorph`, `ggplot2`, `dplyr`, `patchwork`, `ggfortify`, `Morpho`, `shapes`, `tibble`, `plotly`.
- Precomputed `.RData` files in `R_Data/` can be loaded directly to skip repeated calculations.

## Measurement-Based Morphometrics
- Main scripts: `measurement-based_morphometrics/Parascaptor.R`, `Euroscaptor.R`
  - Includes data import, cleaning, PCA, CVA, convex hull visualization, etc.
- Data tables: `*.xlsx`, e.g., `para_log10.xlsx`, `euroscaptor_1023.xlsx`.
- Required R packages: `dplyr`, `ggplot2`, `readxl`, `Morpho`, `MASS`, `tidyr`.

## Data Notes
- Image file naming convention: `Genus#species#specimenID#source#s#v.jpg`
  - `#s#v` indicates ventral skull view; flags like `#p` denote broken skull.
- Processed outputs in `*_OUT/` are one-to-one with input images for outline extraction.
- Measurement tables are in Excel format, including both raw and transformed data.

## Dependencies
- R >= 4.2
- Recommended R packages:
  - `outlineR`, `Momocs`, `geomorph`, `shapes`, `tibble`, `plotly`, `Morpho`, `ggfortify`, `dplyr`, `patchwork`, `ggplot2`, `MASS`, `tidyr`, `readxl`

## Reproducibility & Analysis Workflow
- Load `.RData` files from `R_Data/` for instant reproduction of main results.
- Run `geometric_morphometrics/testcode-ventral.Rmd` for the full image-to-analysis pipeline.
- Run `measurement-based_morphometrics/Parascaptor.R` or `Euroscaptor.R` for measurement-based analyses and visualization.

## License
See the LICENSE file for terms of use.
