# Pre-Submission Review

**Paper**: Intergenerational Educational Mobility in Uzbekistan
**Authors**: Research Team
**Date**: 2026-04-07
**Review Standard**: Leading Field Journal (top-field)

---

## Overall Assessment

The paper provides a reproducible, three-wave descriptive profile of intergenerational educational mobility in Uzbekistan using LiTS 2010, 2016, and 2022-23. Its principal strength is exceptional claim discipline: Module A is labeled descriptive, Module B is labeled associational, Module C is labeled bounded and non-causal, and the prose is consistently careful throughout. The single most critical issue is that the headline finding — a doubling of the rank-rank slope from 2010 to 2016 — has not been sufficiently stress-tested against harmonization artifacts and missingness-driven selection in the 2010 wave.

**Preliminary Recommendation**: Revise before sending to referees.

---

## 1. Contribution & Referee Assessment

### Part 1 — Central Contribution

The paper claims to provide the first systematic multi-wave measurement of intergenerational educational persistence in Uzbekistan. This is application of standard tools (rank-rank slopes, transition matrices, pooled OLS) to an understudied setting. The closest comparators are Bruck and Esenaliev (2018) on Kyrgyzstan and the GDIM database (van der Weide et al. 2024).

**Rating: Incremental.** The paper fills a legitimate empirical gap but uses off-the-shelf methods and the reported slopes (0.13–0.31) are within the range seen in other developing/transition economies.

### Part 2 — Identification and Credibility

No identifying variation in the causal sense. Module A is descriptive, Module B is associational, Module C is bounded descriptive. The paper is commendably honest about this.

A skeptical seminar audience would ask:
1. Is the 2010 baseline an artifact of differential parental-education missingness?
2. Is the 2010-to-2016 jump an artifact of questionnaire harmonization across LiTS waves?
3. With three time points and no panel, can you distinguish genuine mobility change from compositional drift?
4. Why is Module C in the paper at all given its tiny, fragile sample?

### Part 3 — Required Analyses

1. **[CRITICAL] Harmonization robustness for the 2010–2016 jump.** Show the rank-rank slope survives under at least two alternative harmonization mappings. Without this, the main finding could be a measurement artifact.

2. **[CRITICAL] Missingness-driven selection bounds on the 2010 baseline.** The cell-mode imputation is a start, but formal Lee-type or Manski-type partial identification bounds are needed. If the bounded 2010 slope overlaps with 2016 under plausible scenarios, the headline trend claim weakens.

3. **[CRITICAL] Report confidence intervals for ALL plotted estimates.** Cohort profiles and regional dispersion figures show point estimates without visible CIs. For a descriptive paper, precision is the entire product.

4. **[CRITICAL] Cross-country benchmarking.** Place Uzbekistan's rank-rank slopes alongside Kyrgyzstan, Turkey, Russia, Kazakhstan, and GDIM benchmarks. Without this, the "contribution to the comparative conversation" claim is unsubstantiated.

5. **[CRITICAL] Clarify cluster-inference validity.** With ~14 regions, cluster-robust SEs may be severely anti-conservative. Report wild cluster bootstrap p-values for the key wave-interaction tests, or show CR3/HC3 results.

### Part 4 — Suggested Analyses

1. **[MAJOR] Absolute mobility measure** — share of children with more years than parents — to connect to the expansion narrative.
2. **[MAJOR] Kitagawa-Oaxaca-Blinder decomposition** of the rank-rank slope change into structural vs. compositional components.
3. **[MAJOR] Rank-based gender analysis** — the category-based gender split is suppressed for small N, but rank-based measures should have better power.
4. **[MAJOR] Drop Module C from main text** or reduce to one paragraph. Its fragile sample dilutes the stronger Modules A/B. Move to appendix.
5. **[MAJOR] Synthetic cohort tracking** — the repeated cross-sections partially allow APC decomposition; its absence is notable.

### Part 5 — Literature Positioning

Right papers cited for comparative mobility and regional comparators. Obvious omissions:
- Narayan et al. (2018), *Fair Progress?* — the major World Bank volume on intergenerational mobility
- Emran and Shilpi (various) on educational mobility in developing countries
- Checchi (2006) on the theoretical framework linking mobility to institutional design
- Neidhoefer et al. (2018) on Latin American educational mobility — closest methodological template

Best framing: "the first systematic multi-wave measurement of intergenerational educational persistence in Uzbekistan." One tight descriptive contribution is more credible than three loosely connected modules.

### Part 6 — Journal Fit

| Journal | Fit | Notes |
|---|---|---|
| JDE | Unlikely | Strongly favors causal identification |
| World Development | Possible | Needs benchmarking + robustness |
| EDCC | Possible | Needs theoretical hook |
| Economics of Transition | Strong fit | Country and topic match |
| J. Comparative Economics | Good fit | Post-socialist mobility |
| Int'l J. Educational Development | Good fit | Accepts descriptive country studies |

### Part 7 — Questions to the Authors

1. Under what specific assumptions about missing parents' education does the 2010 slope remain below 0.20? Do partial identification bounds overlap with 2016?

2. Can you produce rank-rank slopes under two or three alternative harmonization mappings? Does the 2010–2016 jump survive?

3. How many unique cluster values in each wave? Have you tried wild cluster bootstrap?

4. Module C uses a different parent proxy than Modules A/B. Why not simply report unconditional disruption descriptives without a parental-education gradient?

5. Where does Uzbekistan sit relative to Kyrgyzstan, Russia, Turkey, and GDIM benchmarks?

6. How do you justify policy recommendations about what reform should do when your design cannot evaluate what reform has done?

7. The subgroup heterogeneity finding (sharper persistence increase among women, rural, 35-44 cohort) is potentially the most interesting result. Why is it buried in one sentence rather than developed as a core finding?

---

## 2. Unsupported Claims & Identification Integrity

### Causal Overclaiming

1. **[MAJOR]** Policy brief line 38: *"Talent is filtered through family circumstances before it reaches the labor market."* States a causal mechanism the descriptive design cannot establish. → "Talent may be filtered..."

2. **[MAJOR]** Policy brief line 56: *"...equalizing access alone does not break the link between parents' schooling and children's eventual attainment."* Causal claim from associational evidence. → "...equalizing access alone has not been associated with a weaker link..."

3. **[MAJOR]** Policy brief line 78: *"Expansion can widen opportunity. It does not guarantee that the newly available opportunity is used evenly."* Implies the paper tested whether expansion changed the distribution. → "the persistence evidence is consistent with newly available opportunity not being used evenly."

4. **[MINOR]** Main paper line 146–147: *"the distribution of skills is shaped more by inherited circumstance than by individual potential"* — a causal welfare claim beyond what any descriptive measure establishes.

5. **[MINOR]** Main paper line 617: *"reducing the degree to which family background governs educational trajectories"* — "governs" is causal. → "is associated with."

6. **[MINOR]** Main paper line 643: *"convert schooling opportunities into completed attainment"* — "convert" implies a causal production function.

### Generalization Issues

1. **[MAJOR]** Policy brief lines 86–98: Recommendations A and B prescribe specific operational interventions (small-group tutoring, device lending, outreach to first-generation applicants) without any evidence from this paper on their effectiveness. Should be flagged as drawn from the general education-policy literature.

### Missing Caveats

1. **[CRITICAL]** No discussion of **assortative mating** as an alternative explanation. If higher-educated parents marry each other and ability is partly heritable, observed parent-child correlation could reflect genetic/preference channels rather than inequality of opportunity.

2. **[MAJOR]** No discussion of **recall bias** in parental education reporting. Adults recall parents' education potentially decades later; accuracy may differ by respondent education level and wave.

3. **[MAJOR]** No discussion of **migration and sample selection**. Selective emigration from Uzbekistan could bias cross-sectional LiTS mobility estimates.

4. **[MAJOR]** Region-clustered SEs with ~14 regions — inference may be severely anti-conservative. Treated as minor caveat rather than potentially serious problem.

### Cross-Document Claim Inflation

1. **[MAJOR]** Policy brief title: *"Educational Opportunity in Uzbekistan Still Depends Too Much on Family Background."* "Too much" is a normative judgment the descriptive evidence cannot support. Main paper says "substantial persistence," not "too much."

2. **[MAJOR]** Policy brief subtitle: *"Why the next phase of reform should focus on equity."* Paper shows persistence exists; it does not establish "why" reform should focus on equity.

3. **[MAJOR]** Policy brief line 94: *"students from more educated families remain better positioned to convert those places into attainment."* Upgrades main paper's "predictor" to causal "positioned to convert."

4. **[MINOR]** Slides compress policy nuance into direct prescriptions. Main paper is more cautious.

5. **[MINOR]** Policy brief line 58: *"the top of the ladder remains highly secure"* — adds certainty the sparse transition cells may not support.

---

## 3. Internal Consistency & Cross-Reference Verification

### Critical Inconsistencies

No critical numerical inconsistencies found. All hardcoded numbers in the policy brief round correctly to CSV values. Inline R expressions in main paper and slides pull from the same CSV tables.

### Cross-Document Inconsistencies

1. **[MINOR]** Three orphan bibliography entries (`daniela_etal_2021`, `knopik_etal_2021`, `wb_blog_2020`) — never cited in any document.

2. **[MINOR]** Policy brief omits the 25-64 age restriction stated in main paper, slides, and appendix.

3. **[MINOR]** Policy brief line 76 references HBS regional spending range ("54 to 69 percent") not verifiable from `hbs_household_support_context.csv` (which has no regional breakdown).

4. **[MINOR]** `wb_modernizing_tertiary_2017` bib entry has `year = {2014}` but citation key says 2017. Rendered citation will show "(World Bank, 2014)" when surrounding text discusses post-2017 reforms.

### Terminology Drift

1. **[MINOR]** "Persistence probability" (tables/CSVs) vs. "same-category persistence" (prose) vs. "Persistence" (column header) — all refer to the same measure.

2. **[MINOR]** "Fathers reported in only 4 percent" rounds CSV value of 3.7% — borderline but consistent rounding direction.

3. **[MINOR]** Module C parent-education split terminology: policy brief says "lower-parent-education households" without noting the different proxy method used in Module C vs. Modules A/B.

### Minor Inconsistencies

1. **[MINOR]** Technical appendix `fmt_pct` outputs "X.X percent" while slides output "X.X%." Inconsistent formatting across documents.

2. **[MINOR]** HBS internet access covers 2021-2024 only (not 2025). The "pooled HBS 2021-2025" label slightly overstates coverage for that indicator. Slides correctly note "2021-2024 internet module."

---

## 4. Equations, Notation & Specification Consistency

### Specification Errors or Mismatches

1. **[MAJOR] Eq. 6 gender term dropped silently.** Research strategy specifies `phi*Male(i)`. Code omits gender entirely (`R/50_module_c_mechanisms.R`:314). Manuscript sidesteps by never writing a displayed Module C equation. Either restore the term or document the deviation.

2. **[MAJOR] Single displayed equation conflates five specifications.** The manuscript's Module B equation (lines 213–218) shows wave-interaction terms specific to Eq. 2 (persistence trend) but verbally amends it for Eqs. 3, 4, and 5. A reader cannot tell which terms enter which regression. Separate numbered equations or a specification table would improve replicability.

3. **[MAJOR] `X(i)` / `X_i` defined differently between research strategy and manuscript.** Research strategy bundles all controls into `gamma'X(i)`. Manuscript separates `rho_1*U_i + rho_2*F_i` from `X_i'*gamma`. The displayed equation corresponds only to the demographic-or-above specification; the minimal specification is not representable.

4. **[MINOR]** Generic $P_i$ switches meaning between trend model (rank) and heterogeneity model (score) without explicit notice.

5. **[MINOR]** Research-strategy Eq. 5 omits main effects of urban and female; code correctly includes them for proper interaction interpretation.

### Notation Inconsistencies

6. **[MINOR]** $Y_{iw}$ (Module A, with wave subscript) vs. $Y_i$ (Module B, without) — transition is implicit.

7. **[MINOR]** $L_i$ defined in notation paragraph (line 197) but never appears in a displayed formula; $M_i$ never formally defined.

8. **[MINOR]** Greek letter for controls shifts between research strategy (`gamma` for everything) and manuscript (`rho_1`, `rho_2`, `gamma`).

### Minor Formatting Issues

9. **[MINOR]** No explicit equation numbering in manuscript. Research strategy numbers Eqs. 1–6; manuscript has only two displayed equations.

10. **[MINOR]** Rank scale (0–1) never stated explicitly. Readers expecting Chetty-style 0–100 percentile ranks may misinterpret slope magnitudes.

11. **[MINOR]** No explicit "percentage point" distinction when discussing differences in rates (e.g., stoppage rate gaps).

---

## 5. Tables, Figures & Documentation

### Tables with Missing or Incomplete Notes

1. **[CRITICAL] @tbl-pooled-correlates (line 512)** — Regression table with NO table notes at all. Must document: dependent variable, FE, SE clustering, significance levels, sample N, weighting.

2. **[MAJOR] @tbl-sample-composition (line 235)** — No notes. Missing: weighted vs. unweighted statement for composition shares, age restriction, data source.

3. **[MAJOR] @tbl-mobility-metrics (line 294)** — No notes. Missing: definition of measures, sample restriction, weighting, CI interpretation.

4. **[MAJOR] @tbl-transition-structure (line 352)** — No notes. Missing: "Suppressed" cell explanation, category definitions, weighting.

5. **[MAJOR] @tbl-hbs-context (line 568)** — No notes. Missing: pooling method, weighting, internet coverage years.

6. **[MINOR] @tbl-modulec-sample (line 592)** — No notes. Brief eligibility criteria note would help.

7. **[CRITICAL] ALL technical appendix tables** — None have Quarto labels (`#| label: tbl-*`) or captions. Cannot be cross-referenced. None have notes documenting sample, variables, FE, SE clustering, or significance conventions.

### Figures with Missing or Incomplete Documentation

1. **[MAJOR] @fig-cohort-rank-rank (line 407)** — No confidence intervals on cohort profiles despite potentially small cells.

2. **[MAJOR] @fig-region-rank-rank (line 441)** — No confidence intervals for regional estimates. Text says "several intervals remain wide" but figure shows only point estimates.

3. **[MAJOR] Slides figures (lines 172, 233)** — No captions or alt text.

4. **[MINOR]** Figure captions in main paper are minimal — not self-contained. Should state sample, weighting, CI interpretation.

5. **[MINOR]** PNG file `tier_a_upward_by_urban_rural.png` uses raw variable name "urban_rural" in title.

6. **[MINOR]** `tier_a_upward_by_gender.png` exists in outputs/ but is never referenced in any document.

### Cross-Reference Issues

1. **[CRITICAL]** No cross-references in technical appendix. Main text refers to "Appendix D2", "Appendix H" etc. as plain text, not Quarto cross-references. Appendix tables lack labels, so formal linking is impossible.

2. **[MAJOR]** @tbl-hbs-context is defined at line 568 but **never referenced in text**.

3. **[MAJOR]** No cross-references in policy brief or slides.

### Formatting Inconsistencies

1. **[MAJOR]** `fmt_pct()` outputs "X.X percent" in main paper/appendix but "X.X%" in slides. Same statistic displays differently across documents.

2. **[MINOR]** `read_csv_safe()` defined three times with different error-handling (stop vs. graceful fallback).

3. **[MINOR]** Figure x-axis labels say "2022" while text says "2022-23" for the same wave.

---

## 6. Spelling, Grammar & Style

### Critical Issues

1. **[CRITICAL]** Line 150 (Introduction): *"It makes three contributions."* — "This paper contributes" variant. Delete and let the enumeration speak.

2. **[CRITICAL]** Literature review line 31: *"The contribution of this paper is therefore narrow by design but substantively useful"* — show, don't tell. → "The paper is therefore narrow by design: it provides..."

3. **[CRITICAL]** Line 471: *"is worth showing"* — filler phrase variant. → "The urban-rural split is shown here because..."

### Style Patterns to Fix Throughout

4. **[MAJOR] Passive voice** — recurring dozens of times. Examples:
   - Line 163: "Weighted estimates are used throughout" → "The analysis uses weighted estimates"
   - Line 166: "it is not the source" → "it does not supply"
   - Line 627: "they leave the 2010 level less tightly pinned down" → "they pin down the 2010 level less tightly"

5. **[MAJOR] "LiTS IV" vs. "2022-23 LiTS" vs. "2022-23 wave"** — all three used interchangeably. Add a footnote on first use clarifying the convention.

6. **[MAJOR] Overuse of "therefore"** — appears 14 times in the manuscript. Several can be cut without loss.

7. **[MAJOR] Inconsistent person** — uses "the paper" as agent throughout (no first person). Internally consistent but occasionally awkward.

### Minor Issues

8. **[MINOR]** Line 152: Comma splice — four independent clauses joined by commas. Use semicolons.

9. **[MINOR]** Line 291: "noisier" is colloquial. → "less precisely estimated."

10. **[MINOR]** Line 589: "within module" unhyphenated but "within-wave" is hyphenated. → "within-module."

11. **[MINOR]** Policy brief heading case inconsistent: "What The Evidence Shows" vs. "Limits Of The Evidence." Standardize to sentence case.

12. **[MINOR]** Line 197: $L_i$ introduced in notation but Module C never uses it in a displayed equation. Remove or add equation.

13. **[MINOR]** Policy brief line 76: "about 80 percent" — imprecise. Use the exact figure.

14. **[MINOR]** Slides line 168: Arrow notation "2010->2016" — use "2010 to 2016" or en-dash.

15. **[MINOR]** "Cohort" used throughout for what are age groups in repeated cross-sections. Paper acknowledges this (line 404) but could use "age group" in descriptive passages.

---

## Priority Action Items

**CRITICAL** (must fix — could cause desk rejection or major referee objections):

1. **Harmonization robustness table** for the 2010–2016 rank-rank slope jump under alternative LiTS education-item mappings. (Agent 6, Part 3)

2. **Formal missingness bounds** on the 2010 baseline — Lee-type or Manski-type partial identification. If bounded 2010 overlaps 2016, the trend claim weakens. (Agent 6, Part 3)

3. **Wild cluster bootstrap p-values** or CR3/HC3 correction for wave-interaction tests with ~14 region clusters. (Agent 6, Part 3; Agent 3)

4. **Cross-country benchmarking figure** placing Uzbekistan alongside Kyrgyzstan, Turkey, Russia, and GDIM database estimates. (Agent 6, Part 3)

5. **Add confidence intervals** to cohort-profile and regional-dispersion figures. (Agent 5; Agent 6)

6. **Add table notes** to @tbl-pooled-correlates (regression table): DV, FE, SE clustering, significance, N, weights. (Agent 5)

7. **Add labels and captions** to all technical appendix tables so they can be cross-referenced. (Agent 5)

8. **Discuss assortative mating** as an alternative to the opportunity-inequality interpretation. (Agent 3)

**MAJOR** (should fix — will likely be raised by referees):

9. **Document Eq. 6 gender term omission** — restore to code or explain in text. (Agent 4; Code Review)

10. **Add separate numbered equations** for each specification, or a specification table. Single generic equation is ambiguous. (Agent 4)

11. **Tone down policy brief causal language** — "Talent is filtered," "does not break the link," "positioned to convert." (Agent 3)

12. **Add recall bias and selective emigration** to limitations section. (Agent 3)

13. **Consider dropping Module C** from main text or reducing to one paragraph; move to appendix. (Agent 6)

14. **Add table notes** to all main-text tables (@tbl-sample-composition, @tbl-mobility-metrics, @tbl-transition-structure, @tbl-hbs-context). (Agent 5)

15. **Cite Narayan et al. (2018) *Fair Progress?***, Emran and Shilpi, and Neidhoefer et al. (2018). (Agent 6)

16. **Add absolute mobility measure** and consider Kitagawa-Oaxaca-Blinder decomposition. (Agent 6)

17. **Fix `wb_modernizing_tertiary_2017` bib entry** — year field says 2014, should be 2017. (Agent 2)

18. **Harmonize `fmt_pct()`** across documents or document the intentional difference. (Agent 5)

**MINOR** (polish — improves paper quality):

19. Fix passive voice throughout, especially in data/methodology sections. (Agent 1)

20. Clarify "LiTS IV" vs. "2022-23 wave" convention with a footnote. (Agent 1)

21. Remove orphan bibliography entries. (Agent 2)

22. State rank scale (0–1) explicitly. (Agent 4)

23. Use "age group" in descriptive passages; reserve "cohort" for model variable. (Agent 1)

24. Fix comma splice on line 152 and heading case in policy brief. (Agent 1)

25. Reference @tbl-hbs-context in the main text. (Agent 5)

---

## Issue Counts

| Agent | Critical | Major | Minor |
|---|---|---|---|
| 1. Grammar & Style | 3 | 4 | 15 |
| 2. Internal Consistency | 0 | 0 | 10 |
| 3. Causal Claims | 1 | 8 | 6 |
| 4. Equations & Notation | 0 | 3 | 8 |
| 5. Tables & Figures | 3 | 10 | 12 |
| 6. Contribution Evaluation | 5 | 5 | 0 |
| **Total** | **12** | **30** | **51** |
