// Policy Brief — Standalone Typst Document
// Intergenerational Educational Mobility in Uzbekistan
// Build: Rscript reports/scripts/build_policy_brief_pdf.R && quarto typst compile reports/policy_brief.typ

// ── Data ──
#let raw_vals = csv("brief_values.csv")
#let vals = {
  let d = (:)
  for row in raw_vals {
    if row.at(0) != "key" { d.insert(row.at(0), row.at(1)) }
  }
  d
}
#let val(key) = vals.at(key)

// ── Colors ──
#let primary = rgb("#1b6ca8")
#let accent = rgb("#c56b00")
#let bg-blue = rgb("#f0f5fa")
#let bg-warm = rgb("#fef7f0")
#let text-main = rgb("#2c3e50")
#let text-muted = rgb("#6c7a89")
#let rule-light = rgb("#dee2e6")

// ── Reusable components ──
#let info-box(title: none, body, border-color: primary, fill-color: bg-blue) = {
  block(
    width: 100%,
    fill: fill-color,
    stroke: (left: 3.5pt + border-color, rest: 0.5pt + rule-light),
    inset: (x: 14pt, y: 10pt),
    radius: 2pt,
    above: 10pt,
    below: 10pt,
  )[
    #if title != none [
      #text(10pt, weight: "bold", fill: border-color)[#title]
      #v(4pt)
    ]
    #body
  ]
}

#let rec-box(letter, title, body) = {
  block(
    width: 100%,
    fill: rgb("#f8f9fa"),
    stroke: (left: 3pt + primary, rest: 0.5pt + rule-light),
    inset: (x: 12pt, y: 8pt),
    radius: 2pt,
    above: 6pt,
    below: 6pt,
  )[
    #text(10pt, weight: "bold", fill: primary)[#letter. #title]
    #v(3pt)
    #set text(9.5pt)
    #body
  ]
}

#let section-heading(title) = {
  v(8pt)
  block(
    above: 10pt,
    below: 6pt,
    stroke: (top: 2.5pt + primary),
    inset: (top: 6pt),
    width: 100%,
  )[
    #text(12.5pt, weight: "bold", fill: primary)[#title]
  ]
}

#let note(body) = {
  text(8pt, fill: text-muted)[#body]
}

// ── Page setup ──
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  footer: context {
    line(length: 100%, stroke: 0.4pt + rule-light)
    v(3pt)
    set text(7.5pt, fill: text-muted)
    [Intergenerational Educational Mobility in Uzbekistan — Policy Brief]
    h(1fr)
    [#counter(page).display() of #counter(page).final().first()]
  },
)

#set text(10pt, fill: text-main, lang: "en", font: "Roboto")
#set par(justify: true, leading: 0.6em, spacing: 0.7em, first-line-indent: 0pt)
#set list(indent: 10pt, body-indent: 6pt, spacing: 5pt)

// ══════════════════════════════════════════════════════════════
// PAGE 1: Title + Key Messages + At a Glance + Context
// ══════════════════════════════════════════════════════════════

// ── Title banner ──
#block(
  width: 100%,
  fill: primary,
  inset: (x: 18pt, y: 14pt),
  radius: 2pt,
)[
  #set text(fill: white)
  #text(16pt, weight: "bold")[Educational Opportunity in Uzbekistan
  Remains Closely Tied to Family Background]
  #v(3pt)
  #text(10.5pt, style: "italic")[Implications for equity in learning, transition, and completion]
  #v(8pt)
  #line(length: 30%, stroke: 0.5pt + white.transparentize(40%))
  #v(3pt)
  #text(9pt, weight: "medium")[Nozimjon Ortiqov]
  #h(6pt)
  #text(8.5pt)[Center for Economic Research and Reforms #sym.dot.c CAP Fellow #sym.dot.c April 2026]
]

#v(10pt)

// ── Key Messages ──
#info-box(title: "Key Messages")[
  #set text(9.5pt)
  - *Family background remains a strong predictor* of educational attainment across all three survey waves (2010, 2016, 2022--23).
  - *The parent--child education link strengthened* between 2010 and 2016; the 2022--23 level is elevated but less precisely estimated.
  - *Pandemic disruption fell heavily on households.* Mothers carried most of the learning-support burden, and lower-resourced homes faced more barriers.
  - *Tertiary expansion is necessary but not sufficient.* A larger system does not automatically become a fairer one.
]

// ── At a Glance ──
#block(
  width: 100%,
  fill: bg-warm,
  stroke: 0.5pt + rule-light,
  inset: (x: 14pt, y: 10pt),
  radius: 2pt,
  above: 6pt,
  below: 10pt,
)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 14pt,
    [
      #text(18pt, weight: "bold", fill: primary)[1.4M+] \
      #text(8.5pt, fill: text-muted)[students enrolled by 2024/25 \
      up from 441K in 2019/20]
    ],
    [
      #text(18pt, weight: "bold", fill: primary)[#val("persistence_2022")] \
      #text(8.5pt, fill: text-muted)[persistence score in 2022--23 \
      family rank still tracks parental rank]
    ],
    [
      #text(18pt, weight: "bold", fill: accent)[#val("any_remote_challenge")] \
      #text(8.5pt, fill: text-muted)[of households face remote-learning barriers during COVID-19]
    ],
  )
]

// ── Opening context ──
Uzbekistan's education system has changed rapidly since 2017. The number of higher education institutions nearly doubled from 119 to 222 between 2019/20 and 2024/25. Total enrolled students rose from roughly 441,000 to over 1.4 million.#footnote[Administrative higher-education series verified from official sources compiled for this project.] But this expansion was not uniform. @fig-expansion shows that most regions remain far below Tashkent city, and the fastest-growing regions started from the lowest base.

// ── Expansion chart ──
#figure(
  image("../outputs/figures/policy_brief_expansion.png", width: 95%),
  caption: [Higher-education expansion in Uzbekistan, 2020/21--2024/25.],
) <fig-expansion>

This expansion should be welcomed. But does broader access translate into more equal opportunity, or does family background still determine who benefits?

// ══════════════════════════════════════════════════════════════
// FINDINGS
// ══════════════════════════════════════════════════════════════

#section-heading[Family Background Still Shapes Educational Outcomes]

The link between parental and own education is strong in every wave.#footnote[The analysis uses the Life in Transition Survey (LiTS) conducted by the EBRD. The 2010 and 2016 waves covered 10 of Uzbekistan's oblasts; the 2022--23 wave expanded to all 14. The analytical sample is #val("sample_n") adults ages 25--64.] The persistence score --- a measure of how closely children's education tracks their parents' --- rises from #val("persistence_2010") in 2010 to #val("persistence_2016") in 2016 and stands at #val("persistence_2022") in 2022--23 (@fig-persistence).#footnote[The persistence score is a within-wave rank--rank slope. Higher values mean children's educational rank follows parental rank more closely --- less mobility. The 2010-to-2016 increase is statistically significant (_p_ < 0.001); the 2016-to-2022 change is not (_p_ = #val("change_2016_2022_p")).]

#figure(
  image("../outputs/figures/tier_a_rank_rank_by_wave.png", width: 75%),
  caption: [Educational persistence across LiTS waves. Higher values indicate a stronger link between parents' and children's education.],
) <fig-persistence>

When the analysis accounts for region, cohort, and wave, parental education remains the strongest predictor of children's attainment. In 2022--23, #val("tertiary_persistence") of respondents from tertiary-educated families also reached tertiary education. Upward movement exists, but the top of the education ladder remains secure for families already positioned there.

#section-heading[Disruption Falls Hardest on Under-Resourced Homes]

The 2022--23 LiTS wave includes a module on children's learning during COVID-19.#footnote[This covers a smaller subsample: respondents with a child enrolled before COVID and non-missing parental schooling. Results describe patterns; they are not causal estimates.] The scale of disruption was large:

- #val("stopped_covid") of households report a child's education stopped during COVID.
- #val("any_remote_challenge") report at least one barrier to remote learning.
- #val("challenge_internet") report internet difficulties; #val("challenge_device") report device constraints.

When formal schooling was interrupted, the burden shifted onto families. Mothers were reported as the primary learning-support channel in #val("support_mother") of cases; fathers in only #val("support_father"). Households with less-educated parents reported more internet and device difficulties. The adjusted stoppage gap by parental education is not stable across specifications --- what the evidence establishes is the scale of household burden, not a causal mechanism.

#section-heading[Expansion Is Growing but Not Yet Fair]

Supplementary household budget data show the environment in which families make education decisions:#footnote[HBS 2021--2025, pooled. Used only for context --- the parent--child linkage rate in HBS is too low for intergenerational mobility estimates.]

- #val("edu_spending") of households report positive education spending.
- #val("tutoring") report tutoring expenditure.
- #val("remittances") receive remittances; #val("internet_access") have internet access.

These are signals that the costs of staying on track sit partly inside the household. When admissions expand, students from better-resourced families are better positioned to benefit.

// ══════════════════════════════════════════════════════════════
// RECOMMENDATIONS
// ══════════════════════════════════════════════════════════════

#section-heading[Three Priorities for the Next Reform Phase]

#rec-box("A", "Protect learning at key transition points")[
  Focus on the stages where students fall behind: late primary to lower secondary, lower to upper secondary, and secondary to post-secondary entry. Diagnostic assessments can identify learning gaps. Structured catch-up support and transition guidance around exam years are higher-yield than generic remediation.
]

#rec-box("B", "Make tertiary expansion equitable, not only larger")[
  Outreach to first-generation applicants should begin in secondary school. At entry, first-year advising and bridge modules help students arriving with weaker preparation. Expansion should be judged not only by admissions counts but by whether disadvantaged students enter, stay, and complete at higher rates.
]

#rec-box("C", "Build an equity-monitoring system")[
  Uzbekistan needs a routine equity dashboard: parental education and household learning conditions from periodic surveys, alongside regional patterns in completion, entry, retention, and graduation from administrative records.
]

// ══════════════════════════════════════════════════════════════
// LIMITS
// ══════════════════════════════════════════════════════════════

#section-heading[Limits of the Evidence]

This brief relies on descriptive and associational evidence from repeated cross-sections. It does not identify the causal effect of post-2017 reforms, university expansion, or pandemic policy responses.#footnote[The companion main paper and technical appendix report full methods, diagnostics, and robustness checks.] The child-module extension covers a small subsample and describes patterns rather than isolates a mechanism.
