---
name: check-preanalysis
description: Compare the research strategy document against actual R code to detect specification drift, dropped controls, and deviations from pre-registered design.
user-invocable: true
argument-hint: [optional: path/to/research_strategy.md]
---

# Check Pre-Analysis Plan vs Code

Compare the project's research strategy / pre-analysis plan against the actual R code implementation. Flag every deviation, dropped variable, changed specification, or undocumented departure.

## Phase 1: Discover the Documents

### 1. Find the research strategy / PAP

If a path is provided in `$ARGUMENTS`, use it. Otherwise, search for:
- `research_strategy.md`
- `**/pap*`, `**/pre_analysis*`, `**/preanalysis*`, `**/analysis_plan*`
- Any markdown file that contains equations, hypothesis definitions, or outcome specifications

Record as `STRATEGY_FILE`.

### 2. Find the code

Search for R code files:
- `R/` directory (primary)
- `scripts/` directory
- Root-level `.R` files

Record as `CODE_FILES`.

### 3. Find the manuscript

Find the main `.qmd` manuscript (typically `reports/00_main.qmd`) and its includes. This is used to check whether deviations are documented in the paper.

Record as `MANUSCRIPT_FILES`.

### 4. Find outputs

List all CSVs in `outputs/tables/` — these are the intermediate products connecting code to manuscript.

Before proceeding, tell the user what files were found.

## Phase 2: Read the Research Strategy

Read `STRATEGY_FILE` completely. Extract:

- **Equations**: Every numbered or labeled equation with its components (DV, IVs, FE, controls, interactions)
- **Outcome definitions**: How each outcome variable is defined
- **Sample definitions**: Age ranges, wave restrictions, inclusion/exclusion criteria
- **Estimation methods**: OLS, logit, rank-rank, etc.
- **Clustering and inference**: How standard errors are computed
- **Subgroup analyses**: Pre-specified heterogeneity dimensions
- **Robustness checks**: Pre-committed sensitivity analyses
- **Measure locks**: Any explicit statements about which measures are locked vs exploratory

Store as `STRATEGY_SUMMARY` — a structured list of every pre-registered specification.

## Phase 3: Launch 3 Agents in Parallel

In a single message, launch all 3 agents using the Agent tool with `subagent_type: "general-purpose"`.

---

### AGENT 1: Equation-to-Code Mapping

Prompt:

> You are checking whether pre-registered equations are faithfully implemented in R code.
>
> Research strategy summary: [insert `STRATEGY_SUMMARY`]
> Code files to review: [insert `CODE_FILES`]
>
> For EVERY equation in the research strategy:
> 1. Find the corresponding R code (look for `feols()`, `lm()`, `glm()`, `fixest::`, formula objects)
> 2. Compare each component:
>    - Dependent variable: same construction?
>    - Independent variables: all included? Any added? Any dropped?
>    - Fixed effects: match?
>    - Interactions: match?
>    - Controls: all present?
>    - Clustering: matches stated inference?
>    - Sample restrictions: applied correctly?
> 3. Assign a status:
>    - MATCH: code faithfully implements the equation
>    - PARTIAL: most components match but some differ
>    - DEVIATION: meaningful difference between strategy and code
>    - NOT FOUND: no code implements this equation
>
> Output:
>
> ## Equation-to-Code Mapping
>
> For each equation:
> - Equation label/number
> - Strategy specification (brief)
> - Code location (file:line)
> - Status: MATCH / PARTIAL / DEVIATION / NOT FOUND
> - Details: what matches, what differs, impact assessment
>
> ## Dropped Variables
> List every variable in the strategy that does not appear in corresponding code.
>
> ## Added Variables
> List every variable in code that was not in the strategy.
>
> ## Summary
> How many equations: MATCH / PARTIAL / DEVIATION / NOT FOUND

---

### AGENT 2: Outcome and Sample Construction Check

Prompt:

> You are verifying that outcome variables and sample definitions in the R code match the research strategy.
>
> Research strategy summary: [insert `STRATEGY_SUMMARY`]
> Code files to review: [insert `CODE_FILES`]
> Output CSVs: [list of outputs/tables/*.csv]
>
> Check:
> 1. **Outcome variable construction**: For each outcome defined in the strategy, find where it is constructed in the code. Verify the construction matches (coding thresholds, transformations, aggregation rules).
> 2. **Sample restrictions**: Verify age ranges, wave filters, missing-data exclusions match the strategy.
> 3. **Measure locks**: If the strategy locks specific measures, verify the code uses exactly those measures.
> 4. **Parent education proxy**: How is it constructed? Does it match the strategy?
> 5. **Rank construction**: How are ranks computed? Within-wave? Weighted? Tie handling?
>
> Output:
>
> ## Outcome Variable Audit
> For each outcome: Strategy definition -> Code construction -> MATCH / DEVIATION -> details
>
> ## Sample Restriction Audit
> For each restriction: Strategy definition -> Code implementation -> MATCH / DEVIATION -> details
>
> ## Measure Lock Compliance
> For each locked measure: Status and evidence

---

### AGENT 3: Documentation of Deviations in Manuscript

Prompt:

> You are checking whether deviations from the research strategy are documented in the manuscript.
>
> Research strategy summary: [insert `STRATEGY_SUMMARY`]
> Manuscript files: [insert `MANUSCRIPT_FILES`]
>
> For every place where the research strategy specifies something that might have been modified during implementation:
> 1. Search the manuscript for acknowledgment of the change
> 2. Check whether the deviation is explained and justified
> 3. Check whether the original specification is mentioned as a robustness check
>
> Also check:
> - Does the manuscript reference the research strategy or pre-analysis plan?
> - Does the manuscript distinguish confirmatory from exploratory analyses?
> - Are any "we deviate from our pre-registered plan" statements present?
>
> Output:
>
> ## Documented Deviations
> List deviations that are acknowledged in the manuscript with location.
>
> ## Undocumented Deviations
> List deviations that are NOT acknowledged — these need attention.
>
> ## Confirmatory vs Exploratory Labeling
> Assessment of whether the manuscript distinguishes pre-registered from post-hoc analyses.

## Phase 4: Synthesize and Write Report

After all agents return, synthesize into a single report.

Check whether `notes/reviews/preanalysis_check_[YYYY-MM-DD].md` exists. If so, append `-v2`, etc.

Save to: `notes/reviews/preanalysis_check_[YYYY-MM-DD].md`

```markdown
# Pre-Analysis Plan Compliance Check

**Strategy document**: [STRATEGY_FILE]
**Date**: [Today's date]
**Equations checked**: [count]
**Outcomes checked**: [count]

---

## Overall Compliance

[2-3 sentences: overall fidelity, number of deviations, severity assessment]

**Compliance Rating**: [Faithful | Minor Deviations | Substantial Deviations | Major Departures]

---

## Equation-to-Code Mapping

[Agent 1 output]

## Outcome and Sample Construction

[Agent 2 output]

## Documentation of Deviations

[Agent 3 output]

---

## Priority Actions

**CRITICAL** (undocumented deviations that change results):
1. ...

**MAJOR** (deviations that should be documented or justified):
4. ...

**MINOR** (cosmetic or low-impact differences):
8. ...
```

After saving, report to the user:
1. Path to saved report
2. Compliance rating
3. Number of deviations by severity
4. Top 3 actions needed
