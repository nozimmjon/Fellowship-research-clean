# Combined Review Report v3 — Clean Folder, Pipeline-Aware
**Date:** 2026-04-07  
**Reviewers:** Methodology Reviewer v3, Writing Reviewer v3 (Claude Code agents)  
**Base path:** `Fellowship research clean/`

---

## Overall Assessment

The pipeline is fully reproducible, well-documented, and unusually disciplined. **Zero hardcoded numbers** in the main manuscript — all figures pull from CSVs. Causal language is consistently policed: no causal verbs in Modules A or B. The audit layer (`60_empirical_audit.R`) proactively flags key risks.

**Top vulnerability:** The 2010 baseline is the weakest link. The 2010 parental education goes through a structurally different coding path (years → level → years) than 2016/2022 (direct categorical), which may mechanically depress the 2010 rank-rank slope and create an artefactual appearance of rising persistence. Combined with 18.9% non-random missingness in 2010, the headline trend (0.133 → 0.307 → 0.253) needs a symmetry check before a referee will accept it.

---

## CRITICAL

### 1. Policy brief hardcodes all numbers — reproducibility gap
`20_policy_brief.qmd` states values as plain text (lines 21, 48, 52, 58, 64-68, 76) rather than R inline expressions. If the pipeline is re-run, the brief will silently diverge from the main paper. This is inconsistent with the rest of the reproducible pipeline.  
*Fix: Convert to `r fmt_num(...)` expressions pulling from CSVs, or add a prominent warning comment in the YAML.*

### 2. 2010 years-to-level-to-years conversion may suppress the 2010 slope — no symmetry check exists
`R/20_ingest_data.R` lines 78-89, 311-371: LiTS 2010 parental education comes from continuous q718/q719, converted via `years_to_education_level()` with hard thresholds (y<7→primary, y<10→lower_secondary, etc.), then back to years for ranking. LiTS 2016/2022 use direct categorical responses. This double discretization compresses the 2010 parental rank distribution, which could mechanically depress the 2010 slope. **No sensitivity check exists** that re-estimates 2016/2022 slopes through the same years→level→years pipeline to test whether the trend collapses. This is the single issue most likely to draw sustained referee scrutiny.

---

## MAJOR

### Methodology:

**3. ~14 region clusters — anti-conservative standard errors**  
`R/40_module_b_determinants.R` line 162: `vcov = ~region` with ~14-15 regions, below the 30-50 threshold for reliable cluster-robust inference. The headline 2016 interaction (p=0.003-0.005) rests on these SEs. No wild bootstrap or CR2 correction is provided.  
*Fix: Report wild cluster bootstrap CIs in the appendix, or use PSU-level clustering if identifiers are available.*

**4. 2022 effective N (400) much smaller than 2010/2016 (~870)**  
`module_a_summary_metrics.csv`: Design effect ~1.95 in 2022 vs ~1.07 in earlier waves. The 2016-to-2022 difference is not significant (p=0.172). The source of the wider CIs — unequal 2022 survey weights — is not explicitly stated in the paper.

**5. 2010 parental-education missingness is non-random**  
`empirical_parent_missingness_by_wave.csv`: 18.9% missing in 2010, 4.4% in 2016, 1.9% in 2022. Missing cases are older and less educated. The 2010 slope is estimated on a systematically more educated subsample. Sensitivity scenarios address bounds but not selection-on-observables.

**6. Module C gender control dropped vs pre-registered equation**  
`R/50_module_c_mechanisms.R` line 313: Formula is `outcome ~ parent_low_edu + urban + parent_low_edu:urban | region`. The `research_strategy.md` Eq. 6 specifies both `Urban(i)` and `Male(i)`. Gender is dropped without explanation in the code.

**7. Technical appendix has ~17 "not available yet" placeholders**  
`10_technical_appendix.qmd`: Every major robustness section falls back to placeholder text when CSVs are missing. The rendered appendix today would consist mostly of placeholder messages. All referenced CSVs must be populated before submission.

### Writing:

**8. No inline citations in empirical sections of 00_main.qmd**  
Sections 4-7 (lines 196-643) contain zero `[@...]` citations. The lit review (via include) is well-cited, but the empirical sections need at minimum: LiTS survey documentation, rank-rank slope methodology source (Chetty et al. or Dahl & DeLeire), parent-proxy construction literature.

**9. Scope shift from DiD never explained for external readers**  
The original proposal promised a DiD design. The main paper says "claims are intentionally limited by design" but never explains the change. For fellowship reviewers who saw the proposal, one sentence in the Limitations section would close the gap:  
*"The original project design included a difference-in-differences extension; diagnostic checks on regional treatment variation indicated that the conditions for credible identification were not met, and that design was archived."*

**10. Policy brief "87% tertiary persistence" lacks small-cell caveat**  
`20_policy_brief.qmd` line 58: The main paper correctly notes the 2022 tertiary-origin row has limited cell counts. The policy brief presents the same figure without this caveat.

**11. Transition between Module B and Module C in Discussion**  
`00_main.qmd` lines 607-619: The third Discussion conclusion ("pandemic mechanism evidence underscores the practical importance of household learning conditions") inflates what the bounded Module C shows. Should match the more careful language used in the Module C section itself.

---

## MINOR

### Methodology:
| # | Issue | Location |
|---|-------|----------|
| 12 | No alternative age window robustness despite appendix promise | `10_technical_appendix.qmd` line 77 |
| 13 | No logit/probit robustness for Module B upward-mobility LPM | `R/40_module_b_determinants.R` |
| 14 | No cohort-specific trend decomposition | Not in pipeline |
| 15 | Multiple-testing across 15 Module B models (82 coefficients) not discussed | `module_b_model_coefficients.csv` |
| 16 | Missingness bounds are informal, not partial-identification framing | `R/60_empirical_audit.R` lines 481-516 |
| 17 | No discussion of how max-parent proxy handles assortative mating changes | `research_strategy.md` |
| 18 | No compositional stability check across waves within cohort-region cells | Not in pipeline |

### Writing:
| # | Issue | Location |
|---|-------|----------|
| 19 | Abstract ~230 words — long for economics journals (150-200 target) | `00_main.qmd` line 138 |
| 20 | Abstract doesn't motivate why Uzbekistan matters before methodology | `00_main.qmd` line 138 |
| 21 | "The statistically clearest strengthening..." repeated ~5 times across docs | `00_main.qmd` lines 139, 285, 339, 497, 611 |
| 22 | Covariates subsection introduces nested specs before Empirical Strategy re-explains them | `00_main.qmd` lines 185-187 |
| 23 | "Cohorts" used but these are age groups, not birth cohorts tracked over time | `00_main.qmd` line 164 |
| 24 | Policy brief disruption stats (78%) lack sample-size/selectivity caveat | `20_policy_brief.qmd` line 64 |
| 25 | Slides show raw logit coefficient for Module C without interpretation | `30_slides.qmd` line 185 |
| 26 | Slides show female coefficient without magnitude/significance context | `30_slides.qmd` line 181 |
| 27 | Slides replicate helper functions instead of sourcing shared file | `30_slides.qmd` lines 20-129 |
| 28 | Caveats slide appears after Module C — should appear before | `30_slides.qmd` line 194 |
| 29 | "LiTS IV" vs "2022-23 LiTS" used interchangeably | `00_main.qmd`, `30_slides.qmd` |
| 30 | "Missingness" vs "missing data" vs "parent-education missing" inconsistent | `00_main.qmd` vs `10_technical_appendix.qmd` |
| 31 | Appendix H referenced in main paper (line 565) but may not exist in appendix structure | `00_main.qmd` |
| 32 | `literature_review_section.md` not listed as active in REPO_STATUS.md | `REPO_STATUS.md` |
| 33 | Policy brief "Talent is filtered through family circumstances" is a mechanism claim | `20_policy_brief.qmd` line 38 |
| 34 | Appendix C section numbering: C contains C1 but no C2 | `10_technical_appendix.qmd` |

---

## NOTES
| # | Issue | Location |
|---|-------|----------|
| 35 | Rank-rank change test uses pnorm not t-distribution — fine at N~400-900 | `R/60_empirical_audit.R` |
| 36 | Module A z-test significant for 2010-2022 (p=0.004) but Module B is not (p=0.082-0.182) — different questions, deserves explicit discussion | `00_main.qmd` |
| 37 | Abstract correctly avoids stating 2016 peak is causal | `00_main.qmd` |
| 38 | Module C max-parent median is degenerate (N_high=0); mean-parent fallback is appropriate | `empirical_claim_audit.csv` |
| 39 | Parent-proxy robustness table shows qualitative stability across 5 variants | `empirical_parent_measure_robustness.csv` |
| 40 | Policy brief administrative stats (lines 28) appropriately hardcoded — external data | `20_policy_brief.qmd` |

---

## Strengths (Both Reviewers)

**Pipeline & Reproducibility:**
- Zero hardcoded numbers in `00_main.qmd` — all values from named accessor functions pulling CSVs
- `read_csv_safe` with graceful error handling — renders NA instead of crashing
- Pre-registered measure lock in `research_strategy.md` reduces researcher degrees of freedom
- Explicit audit layer with claim-checking CSV that flags Module C fragility and log-odds scale as "caution"

**Methodology:**
- Rank-rank slope correctly implemented as within-wave weighted rank with proper tie handling
- Parent-proxy robustness: 5 variants all estimated and stored; qualitatively consistent across variants
- Module C guarded estimation: `assess_module_c_model_support()` prevents degenerate models
- Wave-difference tests formally reported with p-values/CIs, not inferred visually
- Covariate selection transparent and rule-based (20% non-missing + 10% per-wave floor)
- HBS linkage gate failure handled correctly — 9.3% recognized as too selective

**Writing:**
- Causal language discipline is the manuscript's strongest dimension — no causal verbs in Modules A/B
- Literature review (via include) is substantively accurate and well-positioned
- "Identification Limits and Contribution" subsection effectively locates the paper in the literature
- Slides footer reads "Descriptive and associational design" on every slide
- REPO_STATUS.md and README.md are accurate and well-structured

---

## Priority Action List

| Priority | Issue | Action |
|----------|-------|--------|
| Critical | Policy brief hardcodes all pipeline-derived numbers | Convert to R inline expressions |
| Critical | No symmetry check for 2010 years→level→years coding path | Re-estimate 2016/2022 through same pipeline; compare |
| Major | ~14 region clusters — anti-conservative SEs | Add wild bootstrap CIs or use PSU clustering |
| Major | 2010 missingness (18.9%) non-random | Add bounding argument or selection discussion |
| Major | Module C gender control dropped vs Eq. 6 | Restore or document the deviation |
| Major | ~17 appendix placeholders | Populate all CSVs before submission |
| Major | No inline citations in empirical sections | Add LiTS docs + methodology citations |
| Major | Scope shift from DiD unexplained | Add one sentence to Limitations |
| Major | Policy brief "87% tertiary" lacks small-cell caveat | Add parenthetical |
| Minor | No age-window robustness | Produce CSV for 25-54 |
| Minor | Abstract too long (~230 words) | Prune to 150-200 |
| Minor | Slides helper functions duplicated | Source from shared file |
