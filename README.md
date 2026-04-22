# Intergenerational Educational Mobility in Uzbekistan

This repository is a curated external snapshot of the Uzbekistan intergenerational educational mobility project. It contains the paper pipeline, manuscript sources, and precomputed artifacts needed to render the main publication outputs without shipping raw data.

## Active Scope

- Main paper: `reports/00_main.qmd`
- Technical appendix: `reports/10_technical_appendix.qmd`
- Policy brief: `reports/20_policy_brief.qmd`
- Slides: `reports/30_slides.qmd`
- Reader guide: `reports/01_start_here.qmd`

The active paper scope is limited to descriptive and associational LiTS evidence plus a short bounded Module C extension based on the LiTS IV child module.

## Repository Map

- `R/`: pipeline code for ingest, estimation, audits, and manuscript helpers
- `reports/`: Quarto sources for publication-facing documents
- `reports/includes/`: manuscript include files used by live reports
- `reports/supplementary/`: supplementary active note
- `data/metadata/`: inventories, dictionaries, and audit exports
- `data/processed/`: curated processed datasets required for render-without-raw-data workflows
- `data/raw/`: empty mount point for local raw-data access
- `outputs/tables/`: precomputed CSV outputs from the pipeline
- `outputs/figures/`: precomputed figures required by the reports
- `archive/`: proposal material, release snapshots, and retained exploratory material

## Replication

### With raw data

1. Open `FellowshipResearch.Rproj` in RStudio.
2. Restore packages with `source("R/02_renv_bootstrap.R"); bootstrap_renv()`.
3. Place LiTS raw files under `data/raw/lits/` and HBS files under `data/raw/hbs/`.
4. Run the full pipeline with `source("run_pipeline.R")`.
5. Render reports with:
   - `quarto render reports/01_start_here.qmd`
   - `quarto render reports/00_main.qmd`
   - `quarto render reports/10_technical_appendix.qmd`
   - `quarto render reports/20_policy_brief.qmd`
   - `quarto render reports/30_slides.qmd`

### Without raw data

The repository includes the processed datasets, tables, and figures needed for a render-only replication path. Run:

```r
source("scripts/06_replication.R")
```

The replication script verifies that the required precomputed artifacts are present and then renders the publication reports from those artifacts.

## Raw Data

Raw data is not included in this repository. The pipeline looks for it in the following order:

1. `FELLOWSHIP_RAW_DATA_ROOT`
2. local `data/raw/`
3. sibling legacy repo `../Fellowship research/data/raw/`

Required structure:

- `data/raw/lits/`: LiTS II (`.csv` or `.dta`), LiTS III (`.csv` or `.dta`), LiTS IV (`lits_iv_dta/`)
- `data/raw/hbs/`: Household Budget Survey year folders with `.dta` files
- `data/raw/admin/`: administrative expansion inputs when rebuilding the expansion panel

## Key Design Decisions

| Decision | Reason |
|----------|--------|
| Rank-rank slope as headline metric | Robust to category granularity differences across waves |
| Region clustering for pooled inference | No harmonized PSU identifier across waves |
| Webb wild-cluster bootstrap alongside clustered p-values | Only 10-14 region clusters |
| 2010 parent education mapped from years | LiTS II records continuous years rather than the later categorical item |
| Module C kept bounded and suggestive | Small child-module sample and no causal design |

## Notes

- `renv.lock` pins package versions for the preferred replication path.
- `outputs/rendered/` is not shipped in this snapshot; reports are intended to be rendered locally from source plus the curated artifacts above.
