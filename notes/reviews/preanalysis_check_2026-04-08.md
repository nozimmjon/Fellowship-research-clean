# Pre-Analysis Plan Compliance Check

**Strategy document**: `notes/planning/research_strategy.md`
**Date**: 2026-04-08
**Equations checked**: 7 (Eq. 1 through Eq. 7)
**Outcomes checked**: 5 locked mobility measures + Module C mechanism outcomes

---

## Overall Compliance

The code is broadly faithful to the pre-registered research strategy. The locked measure set, sample restrictions, education harmonization, and fixed-effects structure are all implemented as specified. The most consequential deviations are: (1) the Eq. 6 Module C mechanism logit drops two pre-registered covariates (Male and the three-way interaction) from the implemented formula; (2) standard errors are clustered at region throughout rather than at PSU-with-region-fallback as the strategy specifies; and (3) several data-driven covariate selection thresholds in Module B are undocumented in the strategy. No equation is entirely missing from the code.

**Compliance Rating**: Minor Deviations

---

## Equation-to-Code Mapping

### Eq. 1: Wave-Specific Rank-Rank Slope

**Strategy (line 63)**:
`R_own(i,w) = alpha_w + beta_w * R_parent(i,w) + e(i,w)`

**Code location**: `R/30_module_a_mobility.R`, lines 188-256, function `compute_rank_rank_slope()`

**Status: MATCH**

Details:
- DV: `child_rank` = `weighted_rank(own_years_schooling, sample_weight)` -- within-wave weighted percentile rank. Matches.
- IV: `parent_rank` = `weighted_rank(parent_years_schooling, sample_weight)` -- within-wave weighted percentile rank. Matches.
- Estimation: `stats::lm(child_rank ~ parent_rank, data = dat, weights = sample_weight)` -- weighted OLS, one regression per wave via `group_by(wave_year)`. Matches.
- Subgroups computed via the `group_var` parameter. Matches strategy line 4 of measure spec: "overall + urban/rural + gender + region + cohort".
- Minimum cell size: `min_n = 30L`. Matches strategy line 31.
- SE: OLS default (homoskedastic from `summary(fit)`), not robust/clustered. This is acceptable for descriptive wave-specific slopes but technically does not match the strategy line 85 ("robust standard errors clustered at PSU if retained; otherwise clustered at region"). **MINOR deviation** -- the descriptive module uses analytic SEs rather than clustered SEs.

### Eq. 2: Pooled Persistence with Wave Interactions

**Strategy (line 66)**:
`R_own(i) = alpha + beta*R_parent(i) + theta2016*(R_parent(i)*D2016) + theta2022*(R_parent(i)*D2022) + gamma'X(i) + region_FE + cohort_FE + wave_FE + e(i)`

**Code location**: `R/40_module_b_determinants.R`, lines 406-419

**Status: MATCH**

Details:
- DV: `own_rank` (within-wave weighted rank of `own_ed_score`). Matches.
- IV: `parent_rank` + `i(wave_year_fe, parent_rank, ref = '2010')` -- fixest interaction notation, produces `parent_rank`, `wave_year_fe::2016:parent_rank`, `wave_year_fe::2022:parent_rank`. Matches theta2016 and theta2022.
- Controls (gamma'X): Three nested specs -- minimal (none), demographic (`urban + female`), extended (adds `migration_exposure`, `multigenerational_hh` if informative). Matches strategy lines 47-49 for conditional variables.
- FE: `region + cohort + wave_year_fe`. Matches.
- Clustering: `vcov = ~region` (line 163). Strategy says "PSU if retained; otherwise region" (line 85). **See clustering deviation below.**
- Weights: `weights = ~sample_weight`. Matches.

### Eq. 3: Attainment Score Correlates

**Strategy (line 69)**:
`S_own(i) = alpha + beta*S_parent(i) + gamma'X(i) + region_FE + cohort_FE + wave_FE + e(i)`

**Code location**: `R/40_module_b_determinants.R`, lines 421-429

**Status: MATCH**

Details:
- DV: `own_ed_score` (integer 1-6 from EDUCATION_LEVELS). Matches "attainment score".
- IV: `parent_ed_score`. Matches.
- Controls, FE, weights, clustering: Same as Eq. 2. Matches.

### Eq. 4: Upward Mobility Model

**Strategy (line 72)**:
`Up(i) = alpha + sum_k beta_k * 1(parent_level(i)=k) + gamma'X(i) + region_FE + cohort_FE + wave_FE + e(i)`

**Code location**: `R/40_module_b_determinants.R`, lines 435-457

**Status: MATCH**

Details:
- DV: `upward_any` = `as.integer(own_ed_score > parent_ed_score)`. Matches.
- IV: `i(parent_ed_level, ref = 'upper_secondary')` -- category indicators with upper_secondary as reference. Matches sum_k notation.
- Estimation: LPM via `feols()`. The strategy does not specify logit vs LPM; LPM is defensible.
- Additionally, a low-parent subsample variant is estimated (`low_parent_sample == 1`). This is **not mentioned** in the strategy but is a reasonable sensitivity. **MINOR** -- added specification not pre-registered but does not displace the main spec.

### Eq. 5: Persistence Heterogeneity

**Strategy (line 75)**:
`Persist(i) = alpha + beta*S_parent(i) + d1*(S_parent(i)*Urban(i)) + d2*(S_parent(i)*Female(i)) + d3*(S_parent(i)*D2022) + region_FE + cohort_FE + wave_FE + e(i)`

**Code location**: `R/40_module_b_determinants.R`, lines 459-478

**Status: PARTIAL**

Details:
- DV: `persist_same` = `as.integer(own_ed_score == parent_ed_score)`. Matches.
- Main RHS terms (lines 460-467):
  - `parent_ed_score` -- matches beta*S_parent
  - `urban` -- **added main effect** not in strategy equation
  - `female` -- **added main effect** not in strategy equation
  - `parent_ed_score:urban` -- matches d1
  - `parent_ed_score:female` -- matches d2
  - `parent_ed_score:wave2022` -- matches d3
- The strategy equation includes only interactions (d1, d2, d3) plus the main parent term. The code adds `urban` and `female` as standalone main effects. This is **econometrically correct** practice (always include main effects when including interactions), so the strategy equation likely omitted them for notational brevity, but they are technically not written in the locked equation.
- **MINOR** deviation -- the added main effects are standard practice and improve the specification.
- The strategy specifies `D2022` for the wave interaction but does not mention `D2016`. The code uses `wave2022` (a binary for 2022 only) which matches. However, no `parent_ed_score:wave2016` interaction is included, which means the model forces 2010 and 2016 persistence to share the same coefficient for the parent-wave interaction. This matches the strategy as written.

### Eq. 6: LiTS IV Mechanism Model (2022-23 only)

**Strategy (line 78)**:
`logit(Pr(M(i)=1)) = alpha + beta*LowParentEdu(i) + eta*Urban(i) + phi*Male(i) + kappa*(LowParentEdu(i)*Urban(i)) + region_FE + e(i)`

**Code location**: `R/50_module_c_mechanisms.R`, lines 313-315

Implemented formula:
`outcome ~ parent_low_edu + urban + parent_low_edu:urban | region`

**Status: DEVIATION**

Details:
- **Dropped term**: `phi*Male(i)` -- the `Male` indicator is completely absent from the Module C formula. The code does not include any gender variable. This is a substantive omission.
- **Dropped interaction**: The strategy does not include a `LowParentEdu*Male` interaction, but the `Male` main effect is specified. It is absent from the code.
- Estimation: `fixest::feglm(..., family = "logit")`. Matches "logit".
- FE: `region`. Matches.
- Clustering: `vcov = ~region`. Same clustering deviation as elsewhere.
- Weights: `weights = ~weight_final`. Matches.
- **Severity: MAJOR** -- dropping `Male(i)` from the mechanism model is a referee-flaggable deviation. If gender is correlated with both parental education and the mechanism outcomes (e.g., mothers vs fathers providing support), omitting it introduces omitted-variable bias in the `beta` estimate. The manuscript does not document this omission.

### Eq. 7: HBS Supplemental Model (Appendix-only, conditional)

**Strategy (line 81)**: "Run only if parent-child linkage diagnostics are adequate."

**Code location**: `R/33_estimate_hbs_appendix_models.R` (exists in pipeline via `_targets.R` line 128-131)

**Status: MATCH**

Details: The strategy explicitly conditions this on linkage diagnostics. The code implements it conditionally. The manuscript notes HBS linkage is insufficient for headline estimates. Implemented as intended.

---

## Dropped Variables

| Variable | Equation | Strategy location | Status |
|----------|----------|-------------------|--------|
| `Male(i)` / gender indicator | Eq. 6 (Module C) | Line 78 | **DROPPED from code** -- not in formula at line 314 of `50_module_c_mechanisms.R` |

## Added Variables

| Variable | Equation | Code location | Status |
|----------|----------|---------------|--------|
| `urban` main effect | Eq. 5 | `40_module_b_determinants.R:462` | Added (standard econometric practice) |
| `female` main effect | Eq. 5 | `40_module_b_determinants.R:463` | Added (standard econometric practice) |
| `low_parent_sample` subsample | Eq. 4 | `40_module_b_determinants.R:449` | Added (extra sensitivity, not pre-registered) |

---

## Outcome and Sample Construction

### Sample Restrictions

| Restriction | Strategy | Code | Status |
|-------------|----------|------|--------|
| Age range 25-64 | Line 27 | `00_config.R:62-63` (`age_min=25, age_max=64`); `20_ingest_data.R:544` (`filter(age >= ... & age <= ...)`) | **MATCH** |
| Cohort bands 25-34, 35-44, 45-54, 55-64 | Line 28 | `20_ingest_data.R:245-253` (`assign_cohort()`) | **MATCH** |
| One respondent per LiTS record | Line 29 | Implicit in data structure (one row per respondent) | **MATCH** |
| Weighted estimates | Line 30 | Used throughout (`sample_weight`, `weight_final`) | **MATCH** |
| Suppress subgroup when N < 30 | Line 31 | `30_module_a_mobility.R:188` (`min_n = 30L`); `12_analysis_specs.R:4` (`min_n = 30L`) | **MATCH** |
| Module C: 2022-23 only | Line 20 | `50_module_c_mechanisms.R:63` (filters to Uzbekistan LiTS IV) | **MATCH** |

### Measure Lock Compliance

| Measure | Strategy line 13-14 | Code | Status |
|---------|---------------------|------|--------|
| Rank-rank slope | Locked | `compute_rank_rank_slope()` in `30_module_a_mobility.R` | **MATCH** |
| Transition matrix | Locked | `compute_transition_matrix()` in `30_module_a_mobility.R` | **MATCH** |
| Upward mobility rate | Locked | `compute_directional_rates()` in `30_module_a_mobility.R` | **MATCH** |
| Downward mobility rate | Locked | `compute_directional_rates()` in `30_module_a_mobility.R` | **MATCH** |
| Persistence probability | Locked | `compute_directional_rates()` + `compute_persistence_by_parent()` | **MATCH** |

### Parent Education Proxy

**Strategy (lines 55-56)**:
- Main spec: `parent_ed_level = max(father_ed_level, mother_ed_level)`
- Robustness: averaged ordered parent score

**Code**:
- `20_ingest_data.R:91-101` (`parent_max_level()`) -- takes the higher of father/mother. **MATCH**.
- `20_ingest_data.R:344-345` (LiTS 2010): `parent_level = parent_max_level(father_level, mother_level)`. **MATCH**.
- Same pattern for 2016 (line 433) and 2022 (line 510). **MATCH**.
- Robustness variants in `60_empirical_audit.R:244-293` include `baseline_max`, `mean_parent_years`, `father_only`, `mother_only`, `both_parents_observed_only`. **MATCH** and **exceeds** the strategy.
- Module C uses `mean_parent_years` for the split (line 360 of `50_module_c_mechanisms.R`). This is **documented in the manuscript** (line 170 of `00_main.qmd`) and justified. **MATCH** with documented deviation.

### Rank Construction

**Strategy (line 58)**: "within-wave education ranks from monotone parent/child scores"

**Code**:
- Module A (`30_module_a_mobility.R:8-28`): `weighted_rank()` computes within-group weighted percentile ranks using cumulative weight midpoints. The ranking is within wave via `group_by(wave_year)`. **MATCH**.
- Module B (`40_module_b_determinants.R:62-67`): Ranks computed from `own_ed_score` and `parent_ed_score` (ordinal 1-6), grouped by `wave_year_fe`. **MATCH** -- within-wave.
- Tie handling: `weighted_rank()` assigns midpoint of cumulative weight interval to ties. In Module A descriptive, `safe_rank()` uses `ties.method = "average"`. Both are standard. **MATCH**.

---

## Clustering and Inference

**Strategy (line 85)**: "Robust standard errors clustered at PSU if retained; otherwise clustered at region."

**Code**: All `feols()` and `feglm()` calls use `vcov = ~region` (e.g., `40_module_b_determinants.R:163`, `50_module_c_mechanisms.R:321`). No PSU variable is constructed or used anywhere in the codebase.

**Status: MAJOR** -- The strategy specifies PSU clustering as the preferred option with region as fallback. The code uses only region clustering. If PSU identifiers are available in the LiTS data but not extracted, this is a deviation from the pre-registered inference strategy. If PSU identifiers are genuinely unavailable, this should be documented. The manuscript does not explicitly state why region clustering is used instead of PSU.

**Practical impact**: Region clustering is coarser (fewer clusters, ~14 regions), which typically produces more conservative standard errors. This makes the deviation direction-favorable (wider CIs), but it is still undocumented.

---

## Robustness Checks: Promised vs. Delivered

### Promised in Strategy

| Check | Strategy line | Delivered | Code location |
|-------|---------------|-----------|---------------|
| Parent proxy robustness (max vs average) | Line 56 | **YES** | `60_empirical_audit.R:295-316` (5 variants) |
| Weighted estimates | Line 30 | **YES** | Used throughout |
| Subgroup suppression N < 30 | Line 31 | **YES** | `min_n = 30L` enforced |
| Module C split-threshold sensitivity | Implicit | **YES** | `50_module_c_mechanisms.R:433-439` (median, leq_11, leq_9) |
| Module C unweighted robustness | Implicit | **YES** | `50_module_c_mechanisms.R:436` |
| Module C max-parent proxy | Implicit | **YES** | `50_module_c_mechanisms.R:439` |

### Additional Robustness Not in Strategy (Data-Driven)

| Check | Code location | Severity |
|-------|---------------|----------|
| Covariate informativeness threshold: `min_non_missing_share = 0.2`, `min_wave_non_missing_share = 0.1` | `40_module_b_determinants.R:111-114` | **MAJOR** -- These thresholds determine which endogenous controls enter the extended specification. They are not pre-registered. |
| Parent-missingness imputation scenarios (observed-only, cell-mode, lower-bound, upper-bound) | `60_empirical_audit.R:423-516` | **MINOR** -- These are additional robustness checks beyond what the strategy requires. They strengthen the analysis. |
| Rank-rank change tests (z-test on difference of descriptive slopes) | `60_empirical_audit.R:527-571` | **MINOR** -- Useful diagnostic not in strategy. |
| Module B minimum observation threshold: `nrow(data_obj) < 100` to fit | `40_module_b_determinants.R:154` | **MINOR** -- Practical safeguard, not pre-registered. |
| Module C minimum group N = 15, minimum events per group = 2 | `50_module_c_mechanisms.R:25-26` | **MINOR** -- More lenient than the main N < 30 rule. Not pre-registered. |

---

## Documentation of Deviations in Manuscript

### Documented Deviations

1. **Module C parent proxy switch** (mean parent years instead of max parent): Explicitly documented at `00_main.qmd` line 170, with justification that max-parent median split is degenerate in the small child-module sample. Well handled.

2. **Module C mechanism models demoted to appendix**: The manuscript (line 224) explicitly states that "adjusted region-fixed-effects logits are retained only as appendix diagnostics." This is a documented scope reduction from the strategy's Eq. 6 being listed as a main-text equation.

3. **HBS supplementary status**: Documented throughout (lines 166-167 of `00_main.qmd`). Matches strategy conditional clause.

### Undocumented Deviations

1. **Eq. 6 dropped `Male(i)` term**: The strategy specifies `phi*Male(i)` in the mechanism logit. The code does not include any gender variable. The manuscript does not acknowledge this omission.

2. **PSU vs. region clustering**: The strategy specifies PSU clustering with region fallback. All code uses region only. No statement in the manuscript explains why PSU was not used.

3. **Covariate selection thresholds (20% non-missing, 10% per-wave minimum)**: These data-driven rules for including endogenous controls in the extended Module B specification are not pre-registered and not discussed in the manuscript as post-hoc choices.

4. **Module C minimum group thresholds (N >= 15, events >= 2)**: Different from the project-wide N < 30 rule stated in the strategy. Not documented.

### Confirmatory vs. Exploratory Labeling

The manuscript does a reasonable job of distinguishing confirmatory from exploratory:
- Module A is explicitly "descriptive"
- Module B is explicitly "associational" (not causal)
- Module C is explicitly "bounded descriptive evidence" and "suggestive"
- The manuscript does not reference the research strategy document directly or use the term "pre-registered"

---

## Priority Actions

**CRITICAL** (none identified):
No deviations were found that would reverse substantive conclusions. The closest is the dropped `Male` term in Eq. 6, but since Module C results are explicitly described as fragile and secondary, this is unlikely to change the paper's main claims.

**MAJOR** (deviations a referee would likely flag):

1. **Eq. 6 missing `Male(i)` covariate** (`50_module_c_mechanisms.R:314`): Add `male` or `female` indicator to the Module C logit formula as specified in the strategy, or document its exclusion and report a robustness check with and without gender. The variable is not constructed in the Module C data preparation pipeline, so it would need to be added.

2. **Clustering at region instead of PSU** (`40_module_b_determinants.R:163`, `50_module_c_mechanisms.R:321`): Either extract PSU identifiers from the LiTS microdata and cluster at PSU, or add an explicit statement in the manuscript (e.g., in Section 4 or the Limitations) explaining that PSU identifiers are not available/retained and region clustering is used as the fallback per the strategy.

3. **Undocumented covariate selection thresholds** (`40_module_b_determinants.R:111-114`): Add a brief note in the data/methods section or appendix stating the 20%/10% coverage rule used to gate endogenous controls into the extended specification. This is a data-driven decision that determines model content.

**MINOR** (defensible, low priority):

4. Eq. 5 includes main effects for `urban` and `female` beyond what the strategy equation writes. Standard econometric practice; no action needed.

5. Eq. 4 low-parent subsample variant is not pre-registered. Defensible as exploratory sensitivity; label it as such if referenced in the manuscript.

6. Module A descriptive slopes use OLS SEs rather than clustered SEs. For descriptive wave-specific outputs this is standard; consider noting that formal inference uses the pooled Module B models with clustered SEs.

7. Module C uses `min_group_n = 15` rather than the project-wide 30. Document this relaxation or harmonize.

8. Rank-rank change z-tests and parent-missingness imputation scenarios are post-hoc additions. They strengthen the paper; just ensure they are clearly labeled as supplementary diagnostics.
