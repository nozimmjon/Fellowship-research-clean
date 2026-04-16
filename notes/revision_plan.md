# Comprehensive Revision Plan — Main Paper

**Paper:** "Intergenerational Educational Mobility in Uzbekistan"
**Source:** `reports/00_main.qmd` + `reports/includes/literature_review_section.md`
**Based on:** Two full econ-write audits (2026-04-15), scoring 74/100
**Goal:** Reach 85+ through targeted structural and prose revisions

---

## I. Title

**Current:** "Intergenerational Educational Mobility in Uzbekistan"
**Problem:** Says what the paper studies, not what it finds. No time dimension.

**Action:** Replace with one of:
- "Family Background Still Shapes Educational Attainment in Uzbekistan" (states finding)
- "Educational Persistence Across Generations in Uzbekistan, 2010–2023" (adds time dimension)
- "Parental Education and Children's Attainment in Uzbekistan: Evidence from Three LiTS Waves"

**File:** `00_main.qmd`, line 2

---

## II. Abstract

**Current problems:**
- Opens with method ("This paper studies...using the LiTS"), not with motivation or finding
- Ends with method ("locked measures, transparent missingness audits, and region-clustered inference with wild-bootstrap robustness")
- "Missingness sensitivity and few-cluster bootstrap inference preserve the qualitative wave ordering" is not an abstract sentence
- No "why it matters" sentence
- "Locked bundle" is undefined jargon
- At the 150-word ceiling with most words spent on robustness, not findings

**Action:** Rewrite following the 4-part formula:
1. **What:** Uzbekistan combines rapid educational expansion with no prior multi-wave evidence on whether family background is losing its grip on attainment (1–2 sentences)
2. **How:** LiTS repeated cross-sections, 2010–2022-23, rank-rank framework (1 sentence)
3. **Findings:** The persistence slope, the transition fact (87% tertiary persistence), parental education as strongest predictor, Module C disruption finding (2–3 sentences)
4. **Why it matters:** Policy implication in one sentence

Target: 120–140 words. No method-heavy closing sentence.

**File:** `00_main.qmd`, lines 165–167

---

## III. Introduction

**Current structure (broken):**
- P1: Throat-clearing ("Educational mobility links family background to the allocation of opportunity")
- P2: Uzbekistan context + HE expansion facts
- P3: Literature gap ("no reproducible multi-wave profile exists")
- P4: Three contributions + results (buried in 90-word sentence)
- P5: Generic roadmap

**Current problems:**
- P1 is pure throat-clearing — could open any mobility paper
- Main finding not stated until P4, embedded in a run-on sentence
- No literature review inside the introduction (delegated entirely to Section 2)
- No comparative framing (the Hertz et al. 0.20–0.60 range appears only in Discussion)
- Roadmap is generic ("Section 2 positions the paper...")
- Introduction is only ~500 words — too short for the formula but also missing key components

**Action:** Rewrite following the Head/Bellemare formula:

### P1: HOOK (striking fact)
Open with the HE expansion numbers (119→222 institutions, 441K→1.4M students) and immediately pose the tension: does broader access translate into more equal opportunity? Or use the transition fact: "In 2022–23, 87 percent of respondents from university-educated families in Uzbekistan also reached university."

### P2: RESEARCH QUESTION + MAIN RESULT
"This paper uses three waves of the Life in Transition Survey (2010, 2016, 2022–23) to provide the first multi-wave profile of intergenerational educational mobility in Uzbekistan. The rank-rank persistence slope rises from 0.134 in 2010 to 0.307 in 2016 — a statistically significant increase — and stands at 0.252 in 2022–23." Place in comparative context: "These levels fall in the moderate-to-high range for developing countries (Hertz et al. 2008 report correlations spanning 0.20–0.60 across settings)."

### P3: ECONOMIC MAGNITUDE
Add one paragraph translating the slope: "At the 2016 slope of 0.307, a child whose parents are at the 25th percentile of the educational distribution is predicted to reach the [X]th percentile, compared to the [Y]th percentile for a child at the 75th parental percentile." This is a one-line calculation from the regression.

### P4: ADDITIONAL RESULTS
Module B: parental education is the most stable predictor across all nested specifications. Module C: pandemic-era disruption was widespread and mothers carried the support burden, but the adjusted parental-education gap is fragile.

### P5–6: LITERATURE REVIEW & VALUE ADDED (2–3 paragraphs)
Move the core of Section 2's content here. Focus on 5–7 closest papers:
- Hertz et al. (2008): cross-country correlations — Uzbekistan's benchmark
- Narayan et al. (2018): developing-country mobility patterns
- Aydemir and Yazici (2019): Turkey as middle-income comparator
- Brück and Esenaliev (2018): Kyrgyzstan as Central Asian comparator
- Torche (2015) / Strömberg and Engzell (2025): measurement sensitivity
- World Bank diagnostics: sector evidence but no intergenerational profile

Build toward "however": "For Uzbekistan, the evidence base remains weighted toward sector diagnostics. No reproducible multi-wave mobility profile exists." Then state three contributions.

### P7: ROADMAP (specific)
"Section 2 introduces the rank-rank framework and the six-category education harmonization. Section 3 shows that the 2010-to-2016 persistence increase survives all three nested specifications and that parental education is the most stable pooled correlate. Section 4 presents a bounded child-module extension on pandemic-era disruption. Section 5 discusses policy implications, and Section 6 concludes."

**Target:** 3–4 pages, ~1,200–1,500 words.

**Files:** `00_main.qmd`, lines 169–179

---

## IV. Literature Review (Section 2)

**Current problems:**
- Exists as a standalone Section 2, separate from the introduction
- ~1,000 words — too long for a descriptive paper
- "Identification Limits and Contribution" subsection partly duplicates the empirical strategy
- Some passages are defensive positioning rather than narrative

**Action:**
1. Move the core narrative (5–7 closest papers + value-added statement) INTO the introduction (see Section III above)
2. Retain Section 2 only if needed for institutional background on Uzbekistan — otherwise merge remaining content into the introduction and delete the standalone section
3. If retained as a short section, rename to "Institutional Context" and keep to ~400 words: post-Soviet education system, the 2017 reform wave, regional disparities, tertiary bottleneck
4. Cut the "Identification Limits" subsection — this material belongs in the empirical strategy section

**Files:** `00_main.qmd` line 181–183; `reports/includes/literature_review_section.md`

---

## V. Data and Measurement (Section 3)

**Current problems:**
- No summary statistics table (N, mean, SD for key variables)
- Module C parent-proxy discussion is too detailed for readers who haven't yet encountered Module C
- Covariate selection rule (20%/10% gate) is stated but not defended
- The harmonization robustness check ("a harmonization-specific check that replaces the back-converted 2010 max-parent years...") belongs in the appendix, not the main data section
- Does not state whether regressions are weighted

**Actions:**
1. **Add a summary statistics table** after the current Table 1 (sample composition):
   - Variables: own education years, parental education years (max-parent), age, female indicator, urban indicator
   - Columns: by wave (2010, 2016, 2022-23) + pooled
   - Report N, mean, SD
   - Define every variable in table notes
2. **Move Module C proxy discussion** to Section 7 (Module C results), where the reader has context for why it matters
3. **Add one sentence defending the covariate gate**: e.g., "The 20 percent pooled / 10 percent per-wave thresholds are conservative enough to exclude variables with severe wave-specific missingness while retaining controls with reasonable population coverage."
4. **Move the harmonization robustness check** to the appendix; keep only the headline conclusion in the main text ("the rank-based national series is stable under alternative parent constructions; see Appendix D2")
5. **State explicitly** whether Module B regressions use survey weights: "All pooled regressions are estimated with survey weights."
6. **Absorb missingness limitation here** (from current Section 9): the paragraph on missingness concentrated in 2010 belongs in Section 3.3, near the missingness diagnostics

**File:** `00_main.qmd`, lines 185–226

---

## VI. Empirical Strategy (Section 4)

**Current problems:**
- The "compact notation" paragraph defines 10 symbols ($Y_{iw}$, $P_{iw}$, $U_i$, $F_i$, $X_i$, $D_{ti}$, $\mu_r$, $\lambda_c$, $\tau_w$, $L_i$) in one dense paragraph
- Module B pooled equation (Eq. 2) is described verbally but not displayed
- Module C estimation rules (15 observations, 2 events/non-events) are implementation details

**Actions:**
1. **Spread the notation** across the three module subsections — define each symbol where it is first used, not all at once
2. **Display Eq. 2** as a standalone equation — it is the core pooled specification
3. **Move Module C estimation rules** to appendix or to a footnote
4. **Absorb the cross-section limitation here** (from current Section 9): "Because LiTS waves are repeated cross-sections rather than a panel, changes over time reflect population-level shifts rather than within-family dynamics."

**File:** `00_main.qmd`, lines 228–259

---

## VII. Results (Sections 5–7)

### Section 5: Descriptive Results

**Current problems:**
- Rank-rank slopes stated again (4th time by this point)
- "The main takeaway is that..." formula used 3–4 times
- Transition matrix table mixes 2010, 2016, and partial 2022 rows — hard to parse

**Actions:**
1. **Report slopes here for the first full presentation with CIs** — this is the one place for the full table. Remove the duplicate from the abstract and the "raw versus conditional" subsection in Section 6
2. **Delete "The main takeaway is that..." sentences** — let the preceding paragraph speak for itself
3. **Consider separate panels by wave** for the transition matrix, or at minimum a clearer visual separator

### Section 6: Correlates of Educational Mobility

**Current problems:**
- Section 6.3 ("Raw Versus Conditional Trend Interpretation") restates slopes a 5th time
- The HBS expansion-intensity comparison (Section 6.6–6.7) feels grafted on — introduced late with a new data source and classification

**Actions:**
1. **Cut Section 6.3** or reduce to 2 sentences: "Conditioning on region, cohort, and demographics does not overturn the descriptive profile. The extended conditional slopes track the raw slopes closely."
2. **Move HBS expansion content** earlier — either into the Data section as institutional context or into a separate short subsection before the Module B results, so the reader understands the expansion environment before seeing the correlates
3. **Add economic magnitude** paragraph here (if not in intro): translate the parental coefficient from the attainment model into years of schooling. "A one-standard-deviation increase in parental education score is associated with [X] additional years of own education."

### Section 7: Module C

**Current problems:**
- Over-hedged: "bounded descriptive evidence, not as a stable adjusted mechanism and not as a causal design" — triple negation
- The bridge paragraph explaining why Module C uses a different parent proxy should move here from the Data section

**Actions:**
1. **Lead with the finding**: "Stoppage rates are nearly identical across parental-education groups: [X]% among lower-parent households versus [Y]% among higher-parent households." Then qualify
2. **Reduce hedging to one clear statement**: "Module C provides descriptive evidence on disruption patterns. Its small sample (N ≈ 180) does not support adjusted estimates or causal claims."
3. **Move the Module C proxy discussion** from the Data section to here
4. **Absorb Module C fragility limitation** here (from current Section 9)

**File:** `00_main.qmd`, lines 261–729

---

## VIII. Discussion and Conclusion (Sections 8–10)

**Current problems:**
- Discussion (Section 8) opens by restating findings already in the results
- Comparative perspective (Hertz et al.) arrives too late — should be in the intro
- Policy implications are generic — could describe any country
- Separate Limitations section (Section 9) projects defensiveness
- Conclusion (Section 10) restates findings a 4th+ time
- Three separate ending sections (Discussion, Limitations, Conclusion) where one would suffice

**Actions:**
1. **Merge Sections 8, 9, and 10 into a single "Discussion and Conclusion" section** (~1.5 pages)
2. **Structure:**
   - P1–2: Interpret the findings in a new way — don't restate, interpret. "The persistence of family-background effects despite rapid expansion suggests that supply-side reforms alone are insufficient." Connect to the returns-to-education channel in one sentence
   - P3: Uzbekistan-specific policy implications — pick 1–2 that flow directly from the evidence (maternal support burden from Module C; regional dispersion from Module A; the tertiary bottleneck)
   - P4: Address the "real or artifactual?" question about 2010–2016 in 2–3 sentences. State preferred interpretation
   - P5: Future work — panel data, administrative records, quasi-experimental reform evaluation (keep the current good content)
3. **Delete** the standalone Limitations section. All five limitations should be absorbed into body sections:
   - Cross-section caveat → Empirical Strategy (Section 4)
   - Max-parent collapse → Data (Section 3) or Education Measures
   - Missingness/recall → Data (Section 3)
   - Emigration selection → Discussion paragraph
   - Module C fragility → Module C results (Section 7)
4. **Move comparative framing** to the introduction (already covered in Section III above) — keep only a brief reference here: "As noted in the introduction, these persistence levels place Uzbekistan in the moderate-to-high range internationally."

**File:** `00_main.qmd`, lines 731–769

---

## IX. Tables and Figures

**Actions:**
1. **Add summary statistics table** (see Section V above)
2. **Transition matrix**: consider separate panels by wave or add visual separators
3. **Consider a coefficient plot** for Module B key coefficients across the three nested specifications — may communicate the stability more effectively than the current table
4. **Update the technical appendix title** if the main paper title changes

**Files:** `00_main.qmd` (table code blocks); `10_technical_appendix.qmd` (title)

---

## X. Writing / Prose Pass

### A. Mechanical cleanup

| Issue | Find | Replace/Action |
|-------|------|----------------|
| Slope repetition | Grep for `rank_rank_slope` inline values | Keep in: abstract (1×), intro (1×), results table (1×). Cut all other inline restatements |
| "Descriptive and associational" | Grep for `descriptive`, `associational`, `non-causal`, `bounded` | Keep ≤4 total: intro (1×), empirical strategy (1×), Module C (1×), closing note (1×) |
| "The main takeaway is that..." | Grep for `main takeaway` | Delete all instances — let paragraphs speak for themselves |
| "Locked" undefined | First occurrence | Add parenthetical: "a pre-specified ('locked') bundle of measures held constant across all waves" |
| "The safest interpretation is therefore that..." | Grep for `safest interpretation` | Rephrase or cut — state the interpretation directly |
| "Should be read as..." | Grep for `should be read as` | Reduce from 4× to ≤1× |
| Formula roadmap | Lines 179 | Replace with specific-content roadmap |
| Over-hedging | General pass | One hedge per finding, then move on |

### B. Anti-LLM voice discipline

The paper must read as written by a non-native researcher with perfect English — precise, formal, structured, but unmistakably human. The previous editing pass (2026-04-12) eliminated the worst LLM markers, but several patterns have crept back or were not fully addressed. Apply the following rules throughout every rewritten section:

**Voice target:** Non-native academic with command of English. Think of a Central Asian researcher who studied in Europe — formal, slightly compact syntax, occasionally blunt, never flashy. Not a native speaker imitating casualness; not an AI imitating an academic.

**Concrete rules:**

1. **Banned words and phrases** — grep and eliminate on sight:
   - "delve," "landscape," "multifaceted," "notably," "leverage" (as verb), "pivotal," "groundbreaking," "shed light on," "pave the way," "nuanced," "comprehensive," "in-depth," "holistic," "overarching"
   - "It is worth noting that," "It should be noted that," "Importantly," "Interestingly," "Crucially"
   - "This paper contributes to the literature by" — say what you find, not that you "contribute"
   - "A growing body of literature" — name the papers or don't mention them

2. **Sentence length variation** — mix deliberately:
   - Short declarative sentences (8–12 words): "The 2016 slope is the highest in the series." / "Parental education dominates every specification."
   - Medium sentences with one qualification (15–22 words)
   - Occasional longer sentences with em-dashes or parenthetical asides (25–30 words) — real academics use these
   - **Never** three consecutive sentences of similar length. If a paragraph has five medium sentences, break one in two or combine two into one

3. **Paragraph openings** — vary aggressively:
   - Do NOT start consecutive paragraphs with the same syntactic pattern (e.g., "The X shows..." / "The Y suggests..." / "The Z implies...")
   - Allow some paragraphs to open with a short blunt sentence: "This matters." / "The evidence is thin." / "Three facts stand out."
   - Occasionally start with a conditional: "If the 2010 slope is attenuated by measurement error, the 2010–2016 increase is smaller than reported."
   - Never start a paragraph with "Moreover," "Furthermore," "Additionally," "In addition" — these are padding words that signal list-writing, not argument-building

4. **Transitions** — allow natural friction:
   - Not every section transition needs a bridging sentence. A period and a new topic sentence is fine
   - Avoid the AI pattern of "[Topic sentence restating what came before]. [Sentence bridging to next topic]. [New topic sentence]." — cut the middle sentence
   - Where a transition is genuinely needed, use a short one: "The pooled models tell the same story." / "Module C is more limited."

5. **Hedging calibration:**
   - Hedge once per finding. Do not hedge the same finding twice in the same paragraph
   - Use specific hedges: "The 2010 estimate is less precise because of higher missingness" rather than generic "these results should be interpreted with caution"
   - Preferred hedging constructions: "likely reflects," "one interpretation is," "consistent with but not proof of," "the data do not rule out"
   - Avoid: "it is important to note that," "caution is warranted," "should be read as"

6. **Contractions:** Zero. Never use contractions in the manuscript

7. **Specific > generic:**
   - Name the dataset, agency, country, region. Never write "the data" when you can write "the LiTS sample" or "the 2016 wave"
   - Name actual numbers. Never write "a substantial increase" when you can write "a 13-percentage-point increase"
   - Name the comparison. Never write "comparable to other settings" when you can write "comparable to Kyrgyzstan and Turkey"

8. **Allow imperfection:**
   - Not every claim needs a citation. If a fact is common knowledge in the field, state it without a reference
   - Not every paragraph needs to end with a summary sentence. Some paragraphs just present evidence and stop
   - Occasional one-sentence paragraphs are fine for emphasis
   - A slightly rough transition between sections is more human than a perfectly smooth one

9. **Field-specific vocabulary:**
   - Use naturally: "rank-rank slope," "persistence," "extensive margin," "conditional association," "transition matrix," "within-wave," "pooled specification"
   - Do NOT overuse: using "persistence" 40 times when "parent-child gradient," "intergenerational association," or "the slope" would vary the register

10. **Final test:** After each section is rewritten, read it aloud. If it sounds like a committee wrote it, rewrite the opening sentence. If every paragraph sounds equally confident, add one moment of honest uncertainty. If no sentence surprises you, the writing is too smooth

---

## XI. Define "Locked"

**Action:** On first use (currently in abstract), add: "a pre-specified ('locked') bundle of measures — the rank-rank slope, upward mobility, downward mobility, and same-category persistence — held constant across all waves and specifications."

**File:** `00_main.qmd`, abstract + first use in intro

---

## XII. Economic Magnitude Calculation

**Action:** Compute and add one paragraph with this structure:

> "At the 2016 persistence slope of 0.307, a child whose parents are at the 25th percentile of the educational distribution is predicted to reach the [X]th percentile of own education, compared to the [Y]th percentile for a child at the 75th parental percentile. The implied gap of [Y − X] percentile points is equivalent to roughly [Z] years of schooling at the sample mean."

This requires: (a) the regression intercept from the 2016 rank-rank model, and (b) the mapping from percentile ranks to years at the sample distribution. The pipeline already has both.

**File:** `00_main.qmd`, add in either the Introduction or Section 5.2 (National Mobility Metrics)

---

## XIII. New Section Structure (Post-Revision)

| Current | Proposed |
|---------|----------|
| 1. Introduction (500 words, no lit review) | 1. Introduction (1,200–1,500 words, includes lit review + value added) |
| 2. Related Literature (1,000 words, standalone) | *Absorbed into Introduction; possibly retain ~400 words as "Institutional Context"* |
| 3. Data and Measurement | 2. Data and Measurement (add summary stats table, absorb missingness limitation) |
| 4. Empirical Strategy | 3. Empirical Strategy (spread notation, display Eq. 2, absorb cross-section caveat) |
| 5. Descriptive Results | 4. Descriptive Results (cut "main takeaway" formulas) |
| 6. Correlates of Educational Mobility | 5. Correlates of Educational Mobility (cut Section 6.3, add economic magnitude) |
| 7. Bounded LiTS IV Child Module Extension | 6. Pandemic-Era Disruption (lead with finding, reduce hedging, absorb proxy discussion + fragility limitation) |
| 8. Discussion and Policy Implications | 7. Discussion and Conclusion (merge Sections 8–10, Uzbekistan-specific policy, address "real or artifactual?") |
| 9. Limitations (standalone) | *Dissolved into body sections* |
| 10. Conclusion | *Merged into Section 7* |

**Net effect:** 10 sections → 7 sections. Tighter, less repetitive, more confident.

---

## XIV. Implementation Order

| Phase | Tasks | Effort |
|-------|-------|--------|
| **Phase 1: Structure** | Merge Sections 8–10; dissolve Limitations; move lit review into intro; decide on Section 2 fate | High |
| **Phase 2: Abstract + Intro** | Rewrite abstract (4-part formula); rewrite intro (Head/Bellemare formula with lit review). Apply anti-LLM voice from first sentence | High |
| **Phase 3: Magnitude** | Compute economic magnitude from pipeline; add paragraph to intro or results | Low |
| **Phase 4: Data section** | Add summary stats table; move Module C proxy discussion; state weighting; defend covariate gate; absorb missingness limitation | Medium |
| **Phase 5: Prose pass** | Cut repetition (slopes 6→3, "descriptive" 15→4); define "locked"; cut "main takeaway"; reduce hedging. Full anti-LLM scan per Section X.B | Medium |
| **Phase 6: Voice pass** | Read every rewritten section aloud. Check sentence-length variation, paragraph-opening variety, hedge calibration. Apply the 10-point anti-LLM checklist from Section X.B to every paragraph | Medium |
| **Phase 7: Title** | Choose new title | Trivial |
| **Phase 8: Verify** | Re-render; check cross-references; run revision checklist; final LLM-marker grep | Low |

**Estimated total effort:** 2–3 focused sessions.

**Voice rule for all phases:** Every rewritten paragraph must pass the three tests from `feedback_prose_voice.md`: (1) non-native with perfect English, (2) not detectable as LLM-written, (3) human. When in doubt, make the sentence shorter and more direct rather than longer and more qualified.

---

## XV. Expected Score After Revision

| Component | Current | Target | Key change |
|-----------|---------|--------|------------|
| Title | 68 | 85 | States finding or adds time dimension |
| Abstract | 63 | 85 | 4-part formula, finding-first, policy sentence |
| Introduction | 60 | 88 | Head/Bellemare formula, lit review inside, magnitude |
| Literature review | 78 | 82 | Absorbed into intro; tighter |
| Data | 78 | 88 | Summary stats table, weighting stated, limitations absorbed |
| Empirical strategy | 75 | 82 | Notation spread, Eq. 2 displayed, cross-section caveat |
| Results | 75 | 85 | Economic magnitude, repetition cut, Module C tighter |
| Discussion/conclusion | 68 | 85 | Merged, Uzbekistan-specific, no standalone Limitations |
| Tables/figures | 72 | 80 | Summary stats added |
| Writing | 70 | 85 | Repetition cut, "locked" defined, hedging calibrated |
| **Overall** | **74** | **85** | |
