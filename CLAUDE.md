# CLAUDE.md — Project Instructions

> Read this file at the start of every session.

## Project Identity

Intergenerational educational mobility in Uzbekistan using LiTS 2010, 2016, 2022-23.
Descriptive and associational paper — no causal identification.

## Ground Rules

1. Never delete data or code without explicit permission.
2. Never go outside this project directory.
3. Do not invent results not present in `outputs/tables/`.
4. Do not reintroduce a DiD, event-study, or causal design.
5. Module C (child module) is short, suggestive, non-causal — keep it bounded.
6. Prefer integrating existing outputs over rewriting the design.
7. Keep journal-style prose: concise, formal, consistent with locked scope.
8. Always run the pipeline before claiming a fix works.
9. Update the session log at the end of every session.

## Pipeline Architecture

```
R/00_config.R          → paths, constants, EDUCATION_LEVELS
R/20_ingest_data.R     → raw LiTS/HBS → lits_harmonized.csv
R/30_module_a_mobility.R → rank-rank slopes, mobility rates, transitions
R/40_module_b_determinants.R → pooled Eq.2-5, wave-difference tests
R/50_module_c_mechanisms.R → LiTS IV child module regressions
R/60_empirical_audit.R → claim-audit, sample-flow, sensitivity checks
R/91_manuscript_helpers.R → inline value lookups for Quarto reports
```

Build command: `source("run_pipeline.R")` or `targets::tar_make()`
Render: `quarto render reports/00_main.qmd` then `10_technical_appendix.qmd`

## Raw Data

Raw data is NOT in this repo. The pipeline looks for it in order:
1. `FELLOWSHIP_RAW_DATA_ROOT` env var
2. `data/raw/` (local mount)
3. `../Fellowship research/data/raw/` (sibling legacy repo)

Required structure: `data/raw/lits/` (lits_ii.csv or lits2.dta, lits_iii.dta, lits_iv_dta/)

## Key Design Decisions

| Decision | Reason |
|----------|--------|
| Rank-rank slope as headline metric | Robust to category granularity differences across waves |
| hh_income_proxy excluded from extended model | 0% coverage in 2010 wave; fails wave-specific 10% gate |
| Region clustering (not PSU) for pooled SE | No harmonized PSU across waves |
| Webb wild-cluster bootstrap alongside clustered p | Only 10-14 region clusters |
| 2010 parent education from years (q718/q719) | LiTS II uses continuous years, not categories |
| Education mapping handles numeric codes 0-7 | LiTS II q515 stores numeric codes in CSV format |

## Current Status

- **Last updated:** 2026-04-12
- **Current focus:** Fixing 2010 region harmonization (Region2 is empty strings, Region1 has values)
- **Known issues:** Module B wave-difference tests empty until 2010 region fix verified
- **Blocked on:** End-to-end rebuild verification after region fix

## Session Logs

Stored in `notes/claude-logs/`, one per session, named by date.
Read the most recent log before starting work if picking up from a previous session.

## Custom Commands

- `/review-paper` — full paper review against outputs
- `/review-robustness` — robustness/reproducibility audit
