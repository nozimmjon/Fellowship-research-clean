# Robustness Audit Report

**Paper**: Intergenerational Educational Mobility in Uzbekistan
**Date**: 2026-04-08

---

## Part 1: Placeholder Scanner

**Files scanned:** All 7 QMD files in `reports/` plus `literature_review_section.md`.

| Check | Result |
|---|---|
| TODO/FIXME/PLACEHOLDER comments | CLEAN |
| Empty code chunks or stub sections | CLEAN |
| Conditional rendering hiding content | MINOR — `file.exists()` guards in appendix could silently degrade, but all CSVs currently exist |
| Sections promised but empty | CLEAN |
| References to missing tables/figures | CLEAN |

---

## Part 2: Promised vs. Delivered

| Promised Check | Code | Output CSV | Status |
|---|---|---|---|
| Alternative mobility definitions | `60_empirical_audit.R`: 5 parent-measure variants | `empirical_parent_measure_robustness.csv` | DELIVERED |
| **Alternative age windows** | NOT implemented (25-64 hard-coded) | None | **MISSING** |
| Weighted vs. unweighted estimates | Module C only (`unweighted_median` scenario) | Module C CSVs only | **PARTIALLY DELIVERED** |
| Parent proxy definition checks | `60_empirical_audit.R`: 5 variants | `empirical_parent_measure_robustness.csv` | DELIVERED |
| Module C split-threshold sensitivity | `50_module_c_mechanisms.R`: 5 scenarios | `module_c_mechanism_robustness_*.csv` | DELIVERED |
| Module C sample-composition checks | `assess_module_c_model_support()` | Same CSVs | DELIVERED |
| Formal slope-difference tests | `build_rank_rank_change_tests()` | `empirical_rank_rank_change_tests.csv` | DELIVERED |
| Subgroup trend checks | `build_subgroup_trend_checks()` | `empirical_subgroup_trend_checks.csv` | DELIVERED |
| Cell-based mode imputation sensitivity | 4 scenarios in `60_empirical_audit.R` | `empirical_parent_missingness_sensitivity.csv` | DELIVERED |
| Missing-vs-observed comparisons | `build_parent_missingness_observables()` | `empirical_parent_missingness_observables.csv` | DELIVERED |
| Nested specifications (minimal/demographic/extended) | `40_module_b_determinants.R`: 3 specs × all equations | `module_b_key_coefficient_comparison.csv` | DELIVERED |
| Raw vs. conditional trend comparison | `build_trend_comparison()` | `empirical_trend_comparison.csv` | DELIVERED |
| HBS linkage diagnostics | HBS scripts 31-33 | `hbs_linkage_*.csv` | DELIVERED |
| Model inventory | `build_empirical_model_inventory()` | `empirical_model_inventory.csv` | DELIVERED |
| Claim audit | `build_empirical_claim_audit()` | `empirical_claim_audit.csv` | DELIVERED |

---

## Part 3: Missing Standard Robustness Checks

### Summary Table

| # | Gap | Severity |
|---|---|---|
| 1 | Alternative age window sensitivity never implemented despite being listed in robustness checklist | **MAJOR** |
| 2 | Weighted vs. unweighted comparison missing for Modules A and B (only Module C) | **MAJOR** |
| 3 | No wave-dropping sensitivity (e.g., excluding the problematic 2010 wave) | **MAJOR** |
| 4 | No alternative clustering or small-sample correction for ~14 region clusters | **MAJOR** |
| 5 | Module A rank-rank slope SEs are unclustered OLS, inconsistent with Module B | MINOR |
| 6 | No alternative FE structure tested | MINOR |
| 7 | No alternative own-education measure tested (only parent measure varied) | MINOR |
| 8 | No measurement error / attenuation bias discussion | MINOR |
| 9 | No placebo or falsification tests | MINOR |
| 10 | No RESET or functional-form test | MINOR |
| 11 | No goodness-of-fit statistics stored or reported | MINOR |
| 12 | No VIF / collinearity diagnostic | MINOR |
| 13 | No logit/probit robustness for binary Module B outcomes (Eq. 4, Eq. 5) | MINOR |
| 14 | Conditional `file.exists()` guards could silently hide missing outputs | MINOR |

---

## Recommendations (Prioritized)

### Immediate (pre-submission)

1. **Alternative age window sensitivity** (e.g., 30-55) for Module A rank-rank slopes and Module B persistence model
2. **Unweighted versions** of Module A national slopes and Module B Eq. 2
3. **Wave-exclusion sensitivity** (drop 2010, then drop 2016) for Module A headline metrics
4. **Wild cluster bootstrap or CR2 SEs** as alternative to plain region-clustered SEs, or at minimum report unclustered robust SEs alongside

### Before revision

5. Make Module A slope SEs cluster-robust (consistent with Module B)
6. Add paragraph on classical measurement error and attenuation bias to Limitations
7. Store and report R-squared for Module B, pseudo-R-squared for Module C

### Nice to have

8. RESET test on attainment-score model
9. Logit versions of Module B Eq. 4 and Eq. 5 as appendix
10. Placebo/permutation test for 2010-2016 slope change
