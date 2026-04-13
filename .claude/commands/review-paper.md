---
description: Run a 6-agent pre-submission referee report for an academic paper. Adapted for Quarto + R projects.
user-invocable: true
argument-hint: [optional: journal-name] [optional: path/to/main.qmd]
---

You are coordinating a rigorous pre-submission review of an academic economics paper written in Quarto (.qmd) with R inline expressions and CSV-based output tables. You will run 6 specialized review agents in parallel and consolidate their findings into a structured report.

## Phase 1: Parse Arguments and Discover the Paper

Parse `$ARGUMENTS` as follows:
- The recognized journal names are:
  - **Top-5 economics**: `AER`, `QJE`, `JPE`, `Econometrica`, `REStud`
  - **Development / regional**: `WorldDev`, `JDE`, `EJ`, `EDCC`, `WBER`
  - **General field**: `top-field`
  - (case-insensitive; users can add further journals by editing this list)
- If the first token matches a journal name, treat it as `TARGET_JOURNAL` and remaining text as file path.
- If no token matches, treat entire `$ARGUMENTS` as file path, set `TARGET_JOURNAL` to `top-field`.
- If `$ARGUMENTS` is empty, auto-detect everything, set `TARGET_JOURNAL` to `top-field`.

Store the resolved target journal as `TARGET_JOURNAL`.

If a file path was provided, use it. Otherwise, auto-detect:

1. Use Glob with `**/*.qmd` to find all Quarto files in the project.
2. Identify the **main manuscript**: the `.qmd` file named `00_main.qmd` or the one with the most `{{< include >}}` directives and inline R expressions.
3. Read the main file and extract all `{{< include ... >}}` references to build the full file list.
4. Read all included `.md` and `.qmd` files.
5. Find supporting manuscripts: policy brief, slides, technical appendix (typically `20_policy_brief.qmd`, `30_slides.qmd`, `10_technical_appendix.qmd`).
6. Use Glob to find figure files: `outputs/figures/**/*.png`, `outputs/figures/**/*.pdf`, `outputs/figures/**/*.svg`.
7. Use Glob to find table CSVs: `outputs/tables/**/*.csv`.
8. Read `_quarto.yml` for project configuration.
9. Read `references.bib` to have the bibliography available.

Record:
- Full path of each `.qmd` / `.md` file and its role
- List of figure file paths
- List of table CSV paths
- Paper title, authors, and abstract

## Phase 2: Launch 6 Review Agents in Parallel

In a **single message**, launch all 6 agents using the Agent tool with `subagent_type: "general-purpose"`. Each agent reads the manuscript files independently. Pass the complete list of `.qmd`/`.md` file paths, figure paths, and CSV table paths to each agent.

---

### AGENT 1 — Spelling, Grammar & Academic Style

You are a copy editor at a top economics journal. Read all `.qmd` and `.md` files in the following list and perform a thorough review. Ignore R code chunks (between ` ```{r} ` and ` ``` `) and inline R expressions (`` `r ...` ``). Focus on the actual prose.

**What to check:**

1. **Spelling errors**: Misspelled words, proper nouns, technical terms, commonly confused words.

2. **Grammar errors**: Subject-verb agreement, tense consistency, article usage, dangling modifiers, comma splices, run-on sentences, sentence fragments.

3. **Awkward or convoluted phrasing**: Sentences requiring re-reading. Suggest clearer alternatives.

4. **Style violations** — flag every instance of:
   - "interestingly", "importantly", "notably", "it is worth noting", "needless to say" — delete these
   - "significant" used to mean large/important (reserve for statistical significance)
   - "This paper contributes to the literature by..." — show, don't tell
   - Passive voice where active is natural
   - Inconsistent first person ("we find" vs "the paper argues")

5. **Typographic consistency**: Hyphenation, em-dash vs en-dash, spacing, number formatting.

6. **Terminology consistency**: "LiTS IV" vs "2022-23 LiTS", "missingness" vs "missing data", "cohort" vs "age group" — flag inconsistent usage.

Tag every issue `[CRITICAL]`, `[MAJOR]`, or `[MINOR]`.

```
## Agent 1: Spelling, Grammar & Style

### Critical Issues
[numbered list]

### Style Patterns to Fix Throughout
[list recurring problems with one example each]

### Minor Issues
[numbered list]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]

---

### AGENT 2 — Internal Consistency & Cross-Reference Verification

You are a technical reviewer checking whether a Quarto economics paper is internally coherent. Read all `.qmd` and `.md` files and the CSV tables they reference.

**What to check:**

1. **Numerical consistency**: Every number in prose should match the CSV it draws from. Read the actual CSV files in `outputs/tables/` and verify inline R expressions would produce the stated values. Flag any discrepancy.

2. **Abstract vs. body consistency**: Do numbers, findings, and claims in the abstract match the main text?

3. **Introduction vs. results consistency**: When the introduction previews results, verify the results section delivers.

4. **Terminology consistency**: Flag any key term used inconsistently across sections.

5. **Sample description consistency**: Do stated sample sizes, waves, age ranges remain consistent across abstract, data section, and table notes?

6. **Fixed effects and controls consistency**: Do specifications described in text match what the code/tables show?

7. **Cross-document consistency**: Do the policy brief and slides match the main paper's claims? Flag any divergence.

8. **Citation verification**: Check that every `[@...]` citation in the text has a matching entry in `references.bib`. Flag citations that appear in the bibliography but are never cited, and vice versa.

Tag every issue `[CRITICAL]`, `[MAJOR]`, or `[MINOR]`.

```
## Agent 2: Internal Consistency & Cross-Reference Verification

### Critical Inconsistencies
[numbered list]

### Cross-Document Inconsistencies (Brief, Slides, Appendix vs Main Paper)
[numbered list]

### Terminology Drift
[numbered list]

### Minor Inconsistencies
[numbered list]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]
Table CSVs: [LIST CSV PATHS]
Bibliography: [references.bib path]

---

### AGENT 3 — Unsupported Claims & Identification Integrity

You are a skeptical econometrician enforcing "claim discipline." Read all `.qmd` and `.md` files and flag every place where the paper overstates its evidence.

**What to check:**

1. **Causal language without causal identification**: Flag every sentence where causal language is applied to findings from a descriptive/associational design. Quote the exact sentence.

2. **Generalization beyond the sample**: Claims extending beyond the data's scope without caveats.

3. **Mechanism claims stated as facts**: When the paper explains *why* a result holds, check whether it's treated as established or hypothesized.

4. **Missing necessary caveats**: Obvious threats to validity not discussed.

5. **Literature overclaiming**: "No prior study has examined X" — flag as unverified.

6. **Statistical vs. economic significance conflation**.

7. **Module-specific claim discipline**:
   - Modules A and B should use ONLY descriptive/associational language
   - Module C should be clearly flagged as suggestive and non-causal
   - Policy brief and slides should not inflate claims beyond what the main paper supports

Tag every issue `[CRITICAL]`, `[MAJOR]`, or `[MINOR]`.

```
## Agent 3: Unsupported Claims & Identification Integrity

### Causal Overclaiming
[numbered list with exact quotes]

### Generalization Issues
[numbered list]

### Missing Caveats
[numbered list]

### Cross-Document Claim Inflation
[numbered list comparing policy brief/slides to main paper]

### Minor Language Issues
[numbered list]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]

---

### AGENT 4 — Equations, Notation & Specification Consistency

You are a methodologist reviewing the formal content of a Quarto economics paper. Read all `.qmd` and `.md` files, focusing on equations and empirical specifications.

**What to check:**

1. **Equation-text consistency**: Do regression equations match verbal descriptions?

2. **Notation consistency**: Same symbol for same quantity throughout. Subscripts consistent.

3. **Undefined notation**: Every symbol defined at or before first use.

4. **Specification-code alignment**: Do equations in the paper match what the R code actually estimates? Cross-reference with `research_strategy.md` if available.

5. **Percentage vs. percentage point**: Are these distinguished correctly?

6. **Rank-rank slope interpretation**: Are rank-based measures correctly described and interpreted?

Tag every issue `[CRITICAL]`, `[MAJOR]`, or `[MINOR]`.

```
## Agent 4: Equations, Notation & Specification Consistency

### Specification Errors or Mismatches
[numbered list]

### Notation Inconsistencies
[numbered list]

### Minor Formatting Issues
[numbered list]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]
Research strategy: [path if found]

---

### AGENT 5 — Tables, Figures & Documentation

You are a journal production editor reviewing tables and figures in a Quarto manuscript that pulls from CSV files.

**What to check for tables:**

1. **Caption/title**: Accurate and self-contained?
2. **Notes completeness**: Sample definition, variable definitions, controls, FE, SE clustering, significance stars.
3. **Cross-referencing**: Every table referenced in text? References point to correct table?
4. **CSV existence**: Does every CSV referenced by `read_csv_safe()` actually exist in `outputs/tables/`?

**What to check for figures:**

1. **Caption**: Self-contained description?
2. **Axis labels and legends**: Present and clear?
3. **Confidence intervals**: Shown where appropriate?
4. **Notes**: Sample, what is plotted, data source.
5. **Cross-referencing**: Every figure referenced?

**Cross-document consistency:**
- Do tables/figures appear consistently across main paper, appendix, policy brief, and slides?

Tag every issue `[CRITICAL]`, `[MAJOR]`, or `[MINOR]`.

```
## Agent 5: Tables, Figures & Documentation

### Tables with Missing or Incomplete Notes
[organized by table]

### Figures with Missing or Incomplete Documentation
[organized by figure]

### Missing CSV Files
[list CSVs referenced but not found]

### Cross-Reference Issues
[list]

### Formatting Inconsistencies
[list]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]
Figure files: [LIST FIGURE PATHS]
Table CSVs: [LIST CSV PATHS]

---

### AGENT 6 — Contribution Evaluation (Adversarial Associate Editor)

You are a demanding associate editor. Adopt the persona appropriate to `TARGET_JOURNAL`:
- If specific journal: apply that journal's scope, methods bar, and standards.
- If `top-field`: apply high general standards for a leading field journal.

You have read thousands of papers and have extremely high standards. Read all `.qmd` and `.md` files completely.

**Your evaluation has 7 parts:**

**Part 1 — The Central Contribution**
- State in one sentence what the paper claims to contribute.
- Is this genuinely new or a replication in a new setting?
- Closest prior paper? What does this add?
- Rate: [Transformative | Significant | Incremental | Insufficient for target journal]

**Part 2 — Identification and Credibility**
- What variation identifies the main result?
- Is the main finding causal, correlational, or descriptive? Does the paper claim correctly?
- What would a skeptical econometrician say at a seminar?
- What would make identification convincing?

**Part 3 — Required Analyses** (up to 5 blockers)
**Part 4 — Suggested Analyses** (up to 5 enhancements)

**Part 5 — Literature Positioning**
- Right papers cited? Obvious omissions?
- Best framing for the contribution?

**Part 6 — Journal Fit and Recommendation**
- Fit for TARGET_JOURNAL?
- Preliminary recommendation: [Send to referees | Revise before sending | Desk reject]
- Best realistic alternative outlets?

**Part 7 — Pointed Questions to the Authors** (4-7 hard questions)

Tag Required analyses `[CRITICAL]`, Suggested `[MAJOR]`.

```
## Agent 6: Contribution Evaluation

### Part 1-7 [as described above]
```

The files to review are: [LIST ALL QMD/MD FILE PATHS HERE]

---

## Phase 3: Consolidate and Save

Check for agent failures — insert placeholder sections if needed.

Check whether `notes/reviews/PRE_SUBMISSION_REVIEW_[YYYY-MM-DD].md` exists. If so, append `-v2`, `-v3`, etc.

Save to: `notes/reviews/PRE_SUBMISSION_REVIEW_[YYYY-MM-DD].md`

**Report structure:**

```markdown
# Pre-Submission Referee Report

**Paper**: [Title]
**Authors**: [Authors]
**Date**: [Today's date]
**Review Standard**: [TARGET_JOURNAL]

---

## Overall Assessment
[3-4 sentences: what the paper does, principal strength, most critical issue]

**Preliminary Recommendation**: [from Agent 6]

---

## 1. Contribution & Referee Assessment
[Agent 6 output]

## 2. Unsupported Claims & Identification Integrity
[Agent 3 output]

## 3. Internal Consistency & Cross-Reference Verification
[Agent 2 output]

## 4. Equations, Notation & Specification Consistency
[Agent 4 output]

## 5. Tables, Figures & Documentation
[Agent 5 output]

## 6. Spelling, Grammar & Style
[Agent 1 output]

---

## Priority Action Items

Collect all tagged items. Triage: CRITICAL from Agents 3 and 6 first, then remaining CRITICAL by agent order, then MAJOR, then MINOR.

**CRITICAL**:
1. ...

**MAJOR**:
4. ...

**MINOR**:
8. ...
```

After saving, report to the user:
1. Path to saved report
2. Preliminary recommendation from Agent 6
3. Top 5 priority action items
4. Issue counts by severity
