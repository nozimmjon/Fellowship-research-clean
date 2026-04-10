# Fellowship Research Project

This repository is the cleaned working repo for the Uzbekistan intergenerational educational mobility paper. It keeps the active LiTS paper pipeline separate from internal notes, archived drafts, and exploratory side projects.

## Active Scope

- Main paper: `reports/00_main.qmd`
- Technical appendix: `reports/10_technical_appendix.qmd`
- Policy brief: `reports/20_policy_brief.qmd`
- Slides: `reports/30_slides.qmd`
- Reader guide: `reports/01_start_here.qmd`

The paper scope is locked to descriptive and associational LiTS evidence plus a short bounded Module C extension. Archived causal and exploratory material is preserved under `archive/` and is not part of the active manuscript path.

## Repository Map

- `R/`: active pipeline code
- `reports/`: active Quarto sources
- `reports/includes/`: manuscript include files used by live reports
- `reports/supplementary/`: supplementary but still active notes
- `analysis/`: active audit helpers and supplementary descriptive scripts
- `data/metadata/`: inventories, dictionaries, and audit exports
- `data/processed/`: local processed data cache
- `data/raw/`: local raw-data mount point
- `outputs/`: generated tables, figures, models, and rendered reports
- `notes/`: planning notes, review notes, and progress logs
- `archive/`: superseded drafts, proposal material, freezes, and exploratory branches

## Raw Data Policy

Raw data were intentionally not duplicated into this cleaned repo.

The code looks for raw data in this order:

1. `FELLOWSHIP_RAW_DATA_ROOT` environment variable
2. local `data/raw/`
3. sibling legacy repo `../Fellowship research/data/raw/` if present

If you want this repo to be fully standalone, copy the raw files into:

- `data/raw/lits/`
- `data/raw/hbs/`
- `data/raw/admin/`

The LiTS pipeline now checks for the required raw inputs before execution. If those files are absent, the build stops with a targeted diagnostic instead of failing later inside the harmonization step.

## Quick Start

1. Open `FellowshipResearch.Rproj` in RStudio.
2. Restore the project library:
   - `source("R/02_renv_bootstrap.R")`
   - `bootstrap_renv()`
3. If you are not using `renv`, install packages manually:
   - `source("R/01_packages.R")`
   - `install_missing_packages()`
4. Build the pipeline:
   - `source("run_pipeline.R")`
5. Render the active reports:
   - `quarto render reports/01_start_here.qmd`
   - `quarto render reports/00_main.qmd`
   - `quarto render reports/10_technical_appendix.qmd`
   - `quarto render reports/20_policy_brief.qmd`
   - `quarto render reports/30_slides.qmd`
6. Optional documentation renders:
   - `quarto render reports/05_process_guide.qmd`
   - `quarto render reports/06_process_flowchart.qmd`
   - `quarto render reports/supplementary/41_hbs_descriptive_note.qmd`

Rendered outputs now land in `outputs/rendered/`. Historical submission bundles live in `archive/releases/`.

## Replication Status

- Package state is pinned in `renv.lock`; the preferred setup path is `bootstrap_renv()`.
- Full end-to-end rebuilds still require the external raw-data payload described above.
- Raw-data preflight verified on `2026-04-09`: missing LiTS source files now trigger an immediate diagnostic instead of a late harmonization failure.
- Processed-data report refresh completed on `2026-04-09` for `reports/00_main.qmd` and `reports/10_technical_appendix.qmd`, using the checked-in `data/processed/lits_harmonized.csv` plus refreshed Module A and Module B outputs.
- Checked-in rendered outputs and tables may exist even when a fresh raw-data rebuild is not possible on a given machine because the source files are unavailable locally.

## Working Rules

- `reports/` is for live publication-facing Quarto files only.
- `notes/` is for internal prose.
- `archive/` preserves superseded or exploratory material.
- `outputs/` is generated content and should be treated as rebuildable.
- Do not reintroduce a baseline DiD or event-study design into the active paper path.
