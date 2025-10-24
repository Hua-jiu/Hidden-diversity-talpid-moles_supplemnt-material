# Hidden Diversity in Talpid Moles — Supplementary Materials

This directory provides supplementary data and code to reproduce morphometric and model-based analyses for talpid moles (Parascaptor, Euroscaptor).

## Overview
- Geometric morphometrics of ventral cranium using `outlineR`, `Momocs`, `geomorph`.
- Measurement-based morphometrics tables for statistical analysis.
- Saved R workspaces for quick reproduction.
- Model inference and training code under `Suplement_Code` (HISNET, ViT setups).

### Key Directories
- `geometric morphometrics/` — raw JPGs, processed outputs (`*_OUT`), and `R_Data/` workspaces.
- `measurement-based morphometrics/` — XLSX tables and R scripts for measurements.
- `testcode-ventral.Rmd` — end-to-end ventral cranial outline workflow (EFA + PCA + CVA).
- `LICENSE` — open-source license terms.

## Requirements
R (>= 4.2):
- Packages: `outlineR`, `Momocs`, `geomorph`, `shapes`, `tibble`, `plotly`, `Morpho`, `ggfortify`, `dplyr`, `patchwork`, `ggplot2`.
- Install example:
  ```r
  install.packages(c("Momocs", "geomorph", "shapes", "tibble", "plotly", "ggfortify", "dplyr", "patchwork", "ggplot2"))
  # outlineR may require installation from source or GitHub
  ```

## Quick Start (R)
Use `testcode-ventral.Rmd` to reproduce the ventral outline pipeline:
```r
# 1) Set paths
inpath <- file.path(".../geometric morphometrics/Parascaptor_V_JPG")
outpath <- file.path(".../Parascaptor_V_JPG_OUT")

# 2) Extract outlines and combine
# outlineR::separate_single_artefacts(inpath = inpath, outpath = outpath)
outlines <- outlineR::get_outlines(outpath = outpath, tps_file_rescale = NULL)
outlines_combined <- outlineR::combine_outlines(single_outlines_list = outlines)

# 3) Standardize for shape analysis
outlines_std <- outlines_combined %>%
  coo_center() %>%
  coo_sample(150) %>%
  coo_scale() %>%
  coo_alignxax() %>%
  coo_slidedirection("right")

# 4) Elliptic Fourier Analysis and PCA
bot.f <- efourier(outlines_std, smooth.it = 1, nb.h = 14)
bot.p <- PCA(bot.f)
```
- Load saved workspaces: `load("geometric morphometrics/R_Data/Parascaptor_skull_ventral.RData")` (or Euroscaptor).
- Specimen naming convention: `Genus#species#voucher#imageID#s#v.jpg`.

## Data & Structure
- Raw ventral cranial images in `Parascaptor_V_JPG` and `Euroscaptor_V_JPG`.
- `*_OUT`: single-specimen images after separation.
- `R_Data/`: pre-saved `.RData` workspaces.
- `measurement-based morphometrics/*.xlsx`: measurement tables (raw and log-transformed).

## License
See `LICENSE` for license terms.
