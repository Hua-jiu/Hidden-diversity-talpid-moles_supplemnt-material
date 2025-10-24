# Unraveling hidden species diversity of talpid moles using phylogenomics and skull-based deep learning — Supplementary Materials

This directory contains supplementary data and code to support cranial morphometric analyses of talpid moles (Parascaptor, Euroscaptor). It focuses on geometric morphometrics from ventral skull images and measurement-based analyses.

## Scope
- Geometric morphometrics (ventral cranium outlines): EFA, PCA, CVA, and visualization.
- Measurement-based morphometrics: curated tables and R scripts for descriptive statistics and transformations.
- Pre-saved R workspaces for reproducibility.

## Directory Structure
- `geometric_morphometrics/`
  - `Parascaptor_V_JPG/`, `Euroscaptor_V_JPG/`: raw ventral cranial images (per specimen).
  - `Parascaptor_V_JPG_OUT/`, `Euroscaptor_V_JPG_OUT/`: processed single-specimen outputs.
  - `R_Data/`: pre-saved workspaces (`Parascaptor_skull_ventral.RData`, `Euroscaptor_skull_ventral.RData`).
  - `testcode-ventral.Rmd`: end-to-end workflow for outline extraction and downstream analyses.
- `measurement-based_morphometrics/`
  - `Parascaptor.R`, `Euroscaptor.R`: measurement analysis scripts.
  - `*.xlsx`: measurement tables (raw and log-transformed), e.g., `euroscaptor_1023.xlsx`, `para_log10.xlsx`.
- `LICENSE`, `README.md`

## Geometric Morphometrics
- Uses R packages such as `outlineR`, `Momocs`, `geomorph`, `ggplot2`, `dplyr`, `patchwork`, `ggfortify`, `Morpho`, `shapes`, `tibble`, `plotly`.
- Primary entry point: `geometric_morphometrics/testcode-ventral.Rmd` (ventral outlines → EFA → PCA/CVA → plots).
- Workspaces in `R_Data/` provide precomputed objects to speed up reproduction.

## Measurement-Based Morphometrics
- R scripts (`Euroscaptor.R`, `Parascaptor.R`) conduct data cleaning, transformations (e.g., `log10`), and exploratory analyses.
- Spreadsheets (`*.xlsx`) store curated measurements and derived tables.

## Data Notes
- Raw image filenames follow a structured pattern (e.g., `Genus#species#specimenID#source#s#v[##_flags].jpg`).
  - `#s#v` indicates skull ventral view; additional flags like `#p` or `_pseudo_no_1` denote capture variants or processed outputs.
- Processed outputs in `*_OUT/` mirror one-to-one specimen images prepared for outline extraction.

## Dependencies
- R (>= 4.2) with: `outlineR`, `Momocs`, `geomorph`, `shapes`, `tibble`, `plotly`, `Morpho`, `ggfortify`, `dplyr`, `patchwork`, `ggplot2`.

## Reproducibility
- Pre-saved `.RData` files in `R_Data/` allow running analyses without recomputing all steps.
- `testcode-ventral.Rmd` documents the full processing pipeline.
