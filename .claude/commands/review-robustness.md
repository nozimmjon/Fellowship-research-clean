---
name: review-robustness
description: Scan the pipeline for missing robustness checks, unfilled appendix placeholders, and gaps between promised and delivered sensitivity analyses.
user-invocable: true
argument-hint: [optional: path/to/main.qmd]
---

# Review Robustness Completeness

Audit the project for missing robustness checks, unfilled appendix placeholders, and gaps between what the paper promises and what the pipeline delivers. This is a pre-submission completeness check.

## Phase 1: Discover the Project

### 1. Find all manuscript files

- Main manuscript: `reports/00_main.qmd` (or auto-detect)
- Technical appendix: `reports/10_technical_appendix.qmd`
- All `{{< include >}}` files
- Research strategy: `research_strategy.md` or similar
- Policy brief, slides

### 2. Find all output files

- `outputs/tables/*.csv` — list every CSV
- `outputs/figures/*` — list every figure
- `outputs/models/*` — list every saved model

### 3. Find all R scripts

- `R/*.R`
- `scripts/*.R`
- Root `.R` files

### 4. Find audit infrastructure

- Look for audit scripts (e.g., `R/60_empirical_audit.R`)
- Look for audit output CSVs (e.g., `empirical_*.csv`)

Before proceeding, report the inventory to the user.

## Phase 2: Launch 3 Agents in Parallel

---

### AGENT 1: Appendix Placeholder Scanner

Prompt:

> You are scanning a Quarto technical appendix and manuscript for placeholder text, conditional fallbacks, and incomplete sections.
>
> Files to scan: [ALL .qmd and .md files]
>
> Search for:
> 1. **Placeholder patterns**: "not available yet", "placeholder", "TODO", "TBD", "FIXME", "to be added", "forthcoming", "not yet computed", "will be populated"
> 2. **Conditional fallbacks**: R code patterns like `if (is.null(...))`, `if (nrow(...) == 0)`, `tryCatch`, `read_csv_safe` that fall back to "not available" messages when CSVs are missing
> 3. **Empty sections**: Sections with headers but no substantive content
> 4. **Referenced but missing CSVs**: Inline R code that references CSV files — check whether each CSV actually exists in `outputs/tables/`
> 5. **Appendix sections promised in main text**: Search the main manuscript for "Appendix A", "Appendix B", etc. or "see the appendix" references. Verify each referenced appendix section exists and has content.
>
> Output:
>
> ## Placeholder Inventory
> For each placeholder found:
> - File:line — quoted text — what CSV or content is needed
>
> ## Missing CSVs
> For each CSV referenced but not found:
> - CSV filename — referenced in file:line — which R script should produce it
>
> ## Empty or Stub Sections
> For each:
> - Section title — file:line — what content is expected
>
> ## Appendix Cross-Reference Check
> For each appendix reference in the main text:
> - Reference text — main paper location — appendix location (or NOT FOUND)
>
> ## Summary Counts
> - Placeholders found: N
> - Missing CSVs: N
> - Empty sections: N
> - Broken appendix references: N

---

### AGENT 2: Promised vs Delivered Robustness Checks

Prompt:

> You are auditing whether every robustness check promised in the manuscript, appendix, or research strategy is actually implemented in the R pipeline and has output.
>
> Files:
> - Manuscript files: [list]
> - Research strategy: [path or "not found"]
> - R code files: [list]
> - Output CSVs: [list all in outputs/tables/]
>
> Step 1: Extract every robustness check or sensitivity analysis mentioned anywhere:
> - Main manuscript (look for "robustness", "sensitivity", "alternative", "as a check", "appendix")
> - Technical appendix (every section that promises a robustness result)
> - Research strategy (pre-registered robustness checks)
>
> Step 2: For each promised check, determine:
> - Is there R code that implements it? (file:line)
> - Does the code produce an output CSV or figure?
> - Does the output exist on disk?
> - Is the result reported in the manuscript or appendix?
>
> Assign status:
> - COMPLETE: code exists, output exists, reported in paper
> - CODE_ONLY: code exists but output missing or not reported
> - PROMISED: mentioned in text but no code found
> - PARTIAL: some aspects implemented but not all
>
> Step 3: Identify MISSING robustness checks — important sensitivity analyses that are standard for this type of study but not mentioned anywhere:
> - For rank-rank slopes: alternative rank construction, age window sensitivity, bootstrapped CIs
> - For survey data: design effect adjustments, weight sensitivity
> - For clustered SEs with few clusters: wild bootstrap, CR2 correction
> - For missing data: bounds analysis, IPW, selection models
> - For multiple testing: FDR correction, randomization inference
> - For cross-wave comparison: measurement equivalence checks
>
> Output:
>
> ## Promised Robustness Checks
> | # | Check | Source | Code | Output | Reported | Status |
> |---|-------|--------|------|--------|----------|--------|
>
> ## Missing Standard Robustness Checks
> For each:
> - Check name — why it's standard for this design — impact of omission — difficulty to implement
>
> ## Summary
> - COMPLETE: N
> - CODE_ONLY: N
> - PROMISED: N
> - PARTIAL: N
> - MISSING (standard but not promised): N

---

### AGENT 3: Empirical Audit Layer Review

Prompt:

> You are reviewing the project's existing empirical audit infrastructure to assess its coverage and identify gaps.
>
> Files:
> - Audit scripts: [list any R files with "audit" or "empirical" in name]
> - Audit output CSVs: [list any CSVs with "empirical" or "audit" in name]
> - Main manuscript: [path]
> - Research strategy: [path or "not found"]
>
> Read the audit scripts and their outputs. Assess:
>
> 1. **What the audit checks**: List every check performed by the audit layer
> 2. **What the audit flags**: Read the audit output CSVs and list every flagged issue
> 3. **Audit-to-manuscript connection**: Are audit results incorporated into the manuscript? Are flagged issues addressed?
> 4. **Audit gaps**: What important checks are NOT in the audit layer?
>    - Does it check for measurement equivalence across waves?
>    - Does it check for compositional stability?
>    - Does it verify that rank construction is invariant to tie-breaking?
>    - Does it test for non-random attrition/missingness beyond simple rates?
>    - Does it check whether results are sensitive to weight trimming?
>
> Output:
>
> ## Audit Coverage
> List of every check in the audit layer with brief description.
>
> ## Flagged Issues
> List of every issue flagged by the audit, with its status (addressed / unaddressed in manuscript).
>
> ## Audit Gaps
> Important checks not covered by the audit layer.
>
> ## Recommendations
> Prioritized list of additions to the audit layer.

## Phase 3: Synthesize and Write Report

After all agents return, synthesize.

Check whether `robustness_review_[YYYY-MM-DD].md` exists. If so, append `-v2`, etc.

Save to: `robustness_review_[YYYY-MM-DD].md`

```markdown
# Robustness Completeness Review

**Date**: [Today's date]
**Manuscript**: [main .qmd filename]

---

## Overall Readiness

[3-4 sentences: overall state of robustness coverage, biggest gaps, submission readiness assessment]

**Submission Readiness**: [Ready | Nearly Ready — minor gaps | Not Ready — significant gaps | Blocked — critical gaps]

---

## Placeholder & Missing Content Inventory

[Agent 1 output]

## Promised vs Delivered Robustness Checks

[Agent 2 output]

## Empirical Audit Layer Review

[Agent 3 output]

---

## Priority Actions

**CRITICAL** (must fix before submission):
1. ...

**MAJOR** (should fix — referees will ask):
4. ...

**MINOR** (nice to have):
8. ...

---

## Robustness Roadmap

[Ordered list of all missing robustness checks with estimated implementation effort: Low / Medium / High]
```

After saving, report to the user:
1. Path to saved report
2. Submission readiness rating
3. Counts: placeholders, missing CSVs, promised-but-undelivered checks, missing standard checks
4. Top 5 priority actions
