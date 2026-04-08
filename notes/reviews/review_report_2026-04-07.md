# Combined Review Report — Methodology + Writing
**Date:** 2026-04-07  
**Reviewers:** Methodology Reviewer, Writing Reviewer (Claude Code agents)

---

## CRITICAL Issues (fix before sharing externally)

### Methodology:
1. **Region-clustering with ~14 clusters produces anti-conservative SEs** — Standard cluster-robust with <20 clusters inflates rejection rates. Fix: use PSU-level clustering, wild cluster bootstrap, or CR2/CR3 correction. *(research_strategy.md Sec. 8; all regression tables)*

2. **Rank-rank trend (0.133→0.350) may be a measurement artifact** — Cross-wave differences in parental education measurement could mechanically produce the upward trend via differential attenuation bias. Robustness outputs in appendix Sections D2/D3 are still placeholders. *(10_technical_appendix.qmd Sec. D2, D3)*

3. **Module C (N=183) logit with region FEs risks quasi-separation** — ~13 obs per region on average. Appendix G1 already documents support-degeneracy under one specification. Consider: drop region FEs, use LPM, or move regressions to appendix. *(main_paper_draft.md Sec. 7.3; Appendix G1)*

### Writing:
4. **"Notes for revision" block still in main_paper_draft.md (lines 253-257)** — Contains four unresolved TODOs. Must be removed before any external sharing.

5. **Rank-rank slope contradiction: 0.350 in paper abstract vs 0.25 in policy brief** — One is wrong. Must resolve.

---

## MAJOR Issues

### Methodology:
- **Pooled model null result** — Wave interactions are not significant once controls added, but the paper leads with the descriptive trend and buries this as a caveat. Should invert the hierarchy. *(main_paper_draft.md Sec. 6.1)*

- **Module C framed as "mechanism evidence"** — A single-wave between-family comparison. Should be reframed as "descriptive heterogeneity by parental education group." *(main_paper_draft.md Sec. 7, title and throughout)*

- **N=124 for 2022 category-based estimates** — 95.3% persistence vs 69.5% in 2016 is likely dominated by sampling variance. Should not anchor the trend narrative. *(main_paper_draft.md Sec. 5.2)*

- **All robustness appendix outputs are placeholders** — Sections D-G of the technical appendix have no actual results yet. *(10_technical_appendix.qmd Sec. D-G)*

- **HBS 9.3% linkage selectivity** — Correctly treated as supplementary, but non-representativeness should be more explicit in the main text. *(main_paper_draft.md Sec. 3.1)*

- **Differential parent-education missingness by wave** — max(father, mother) proxy drawn from different distributions if missingness varies across waves. *(10_technical_appendix.qmd Sec. D3)*

- **Tier B 20% threshold** — Arbitrary; no sensitivity check across thresholds; sample-size implications of listwise deletion not discussed. *(07_tier_b_variable_plan.md)*

### Writing:
- **Literature review has zero inline citations** — Section 2 references unnamed "comparative studies" and "a large body of work" without author-year citations. *(main_paper_draft.md Sec. 2, lines 31-39)*

- **Persistence rates differ between paper and policy brief** — Paper: 60.3%, 69.5%, 95.3%. Brief: 44%, 56%, 67%. Different definitions or an error. *(main_paper_draft.md Sec. 5.2 vs 20_policy_brief.qmd line 52)*

- **Scope shift from DiD never explained in external documents** — Internally documented but no bridge sentence in the paper's intro or limitations. Suggested addition: "An earlier version of this project proposed a difference-in-differences design. After data-variation and coverage diagnostics, that design was not pursued. Module C is the bounded descriptive residue of that design question."

- **Causal language leaks:**
  - Line 128: "dependence of educational attainment on parental background" → should be "association between parental background and children's educational attainment"
  - Line 213: "independently explain mobility" → should be "independently associated with mobility"

---

## MINOR Issues

### Methodology:
- Section 5.3 presents trend as settled directional evidence despite null pooled result *(main_paper_draft.md Sec. 5.3)*
- Policy implication drawn from imprecise urban coefficient *(main_paper_draft.md Sec. 8)*
- Module C uses mean parent years while A/B use max — not disclosed in main text *(main_paper_draft.md Sec. 7)*
- Age-window sensitivity listed but not discussed *(10_technical_appendix.qmd Sec. D)*
- Survey-weight validity for N=183 subsample not verified *(research_strategy.md Sec. 8)*
- Multiple testing not acknowledged for Module C *(main_paper_draft.md Sec. 7)*

### Writing:
- Abstract ~300 words (most journals cap at 150-250)
- Abstract missing sample sizes
- Section 5.3 repeats the 2022 categorical caveat already in 5.2
- Section 6 lacks a framing paragraph previewing its structure
- Variable naming inconsistent: `gender` / `female` / `Male_i` across documents
- Slides caveats appear only at the end — consider a footer note on the results slide
- "bounded extension" undefined in standalone documents (policy brief, slides)

---

## Strengths Noted by Both Reviewers

- **Scope discipline is genuinely unusual** — Moving from causal DiD to a well-framed descriptive paper is the right call, and it's documented transparently
- **Identification language is consistently hedged** — Module A/B use "predictor," "associated with"; Module C uses "suggestive"
- **Policy brief's Limits section is unusually honest** for the genre
- **Slides pull numbers live from R outputs** — eliminates transcription errors
- **Multiple mobility measures** reduce single-measure dependence
- **HBS linkage gate failure handled correctly** — 9.3% recognized as too selective
- **N<30 suppression rule** is good practice
- **Module C proxy inconsistency documented in appendix** — shows methodological self-awareness

---

## Suggested Line-Level Fixes

**main_paper_draft.md, line 128:**
- Current: "The broad pattern is therefore one of persistent, and possibly increasing, dependence of educational attainment on parental background."
- Suggested: "The broad pattern is therefore one of persistent, and possibly increasing, association between parental background and children's educational attainment."

**main_paper_draft.md, line 213:**
- Current: "The data provide less clear evidence that migration exposure or multigenerational household structure independently explain mobility..."
- Suggested: "The data provide less clear evidence that migration exposure or multigenerational household structure are independently associated with mobility..."

**main_paper_draft.md, abstract (line 7):**
- Current: "The main contribution of the paper is to provide a reproducible multi-wave profile of educational mobility in Uzbekistan while keeping the interpretation of the evidence disciplined."
- Suggested: "The paper provides a reproducible multi-wave profile of intergenerational educational mobility in Uzbekistan, with disciplined interpretation of the evidence."

**main_paper_draft.md, Section 6 (line 144) — add framing paragraph:**
- "The correlates analysis has four parts. Section 6.1 examines whether the trend in persistence survives conditional controls. Section 6.2 reports attainment-score correlates. Section 6.3 examines upward-mobility predictors. Section 6.4 reports persistence heterogeneity. All results are interpreted as associations, not causal effects."
