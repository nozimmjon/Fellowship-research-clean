// Policy Brief v2 — Standalone Typst Document
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

#let success-box(body) = {
  block(
    width: 100%,
    fill: rgb("#f0faf5"),
    stroke: (left: 3.5pt + rgb("#2a9d8f"), rest: 0.5pt + rule-light),
    inset: (x: 14pt, y: 10pt),
    radius: 2pt,
    above: 10pt,
    below: 10pt,
  )[
    #text(10pt, weight: "bold", fill: rgb("#2a9d8f"))[What Would Success Look Like?]
    #v(4pt)
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
    [Center for Economic Research and Reforms · CAP Fellowship]
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
  #text(16pt, weight: "bold")[Uzbekistan Expanded Higher Education.
  Did Equality of Opportunity Follow?]
  #v(3pt)
  #text(10.5pt, style: "italic")[Evidence from 2010–2023]
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
  - *Family background remains a strong predictor* of educational attainment. In 2022–23, #val("tertiary_persistence") of respondents from university-educated families also reached university --- while those from less-educated backgrounds were concentrated at upper-secondary level.
  - *When schools closed, the burden fell on families.* Mothers provided #val("support_mother") of reported learning support. Lower-resourced homes faced more internet and device barriers.
  - *Tertiary expansion is necessary but not sufficient.* A larger system does not automatically become a fairer one. Whether disadvantaged students enter, stay, and complete is what matters.
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
      #text(18pt, weight: "bold", fill: primary)[#val("tertiary_persistence")] \
      #text(8.5pt, fill: text-muted)[of university-educated parents' \
      children also reached university]
    ],
    [
      #text(18pt, weight: "bold", fill: accent)[#val("any_remote_challenge")] \
      #text(8.5pt, fill: text-muted)[of households faced remote-learning \
      barriers during COVID-19]
    ],
  )
]

// ══════════════════════════════════════════════════════════════
// SECTION 1: EXPANSION
// ══════════════════════════════════════════════════════════════

#section-heading[The Expansion Is Real, but Uneven]

Since 2017, Uzbekistan's higher-education system has grown rapidly. The number of institutions rose from 119 in 2019/20 to 222 by 2024/25. Total enrollment increased from about 441,000 to over 1.4 million.#footnote[Administrative higher-education series compiled from official sources. Covers all recognized higher education institutions nationwide.] But this growth was not uniform. The national average more than doubled --- from 73 to 180 students per 1,000 youth aged 20–24 --- yet no region outside Tashkent city has caught up with where the capital started.

#figure(
  image("../outputs/figures/fig1_regional_final.png", width: 95%),
  caption: [Regional higher-education growth, 2020/21 to 2024/25 (excluding Tashkent city).],
) <fig-expansion>

Household resources shape who benefits from new capacity. In high-expansion regions, 26 percent of remittance-receiving households direct remittances toward education, compared with 16 percent in low-expansion regions.#footnote[Descriptive comparison from the Household Budget Survey (2021–2025), split by regional expansion intensity.] About 63 percent of households report positive education spending, and 14 percent pay for tutoring. Expanded capacity and unequal household means operate at the same time.

// ══════════════════════════════════════════════════════════════
// SECTION 2: FAMILY BACKGROUND
// ══════════════════════════════════════════════════════════════

#section-heading[Family Background Still Determines Who Benefits]

Three waves of the Life in Transition Survey make the inequality concrete.#footnote[The Life in Transition Survey (LiTS) is conducted by the EBRD. The 2010 and 2016 waves covered 10 oblasts; 2022–23 expanded to all 14. Analytical sample: 3,155 adults aged 25–64 with non-missing own and parental education.] In 2022–23, #val("tertiary_persistence") of respondents whose parents had university degrees also attained a degree. Those from upper-secondary backgrounds were split between staying at the same level and moving up. For lower-origin families, the sample is too thin for precise estimates --- which is itself revealing about limited access at the bottom.

A persistence score --- measuring how closely children's educational position tracks their parents' --- confirms this picture across waves.#footnote[The persistence score is a within-wave rank–rank slope. Higher values mean children's educational rank follows parental rank more closely. The 2010 wave recorded parental education differently and had higher missingness; sensitivity checks preserve the wave ordering but the 2010 level carries more uncertainty.] It rose from #val("persistence_2010") in 2010 to #val("persistence_2016") in 2016 (a statistically significant increase, _p_ < 0.01), and stood at #val("persistence_2022") in 2022–23. The decline after 2016 is not statistically significant. In broad international comparison, these levels fall in a moderate-to-high range for developing and middle-income countries.#footnote[Hertz et al. (2008) place intergenerational education correlations between about 0.20 and 0.60 across countries. See also Narayan et al. (2018) and Aydemir and Yazici (2019).]

#figure(
  image("../outputs/figures/tier_a_rank_rank_by_wave.png", width: 75%),
  caption: [Persistence score across LiTS waves. Higher values mean children's educational position tracks their parents' more closely.],
) <fig-persistence>

Controlling for region, birth cohort, urban residence, and gender does not change this conclusion. Parental education remains the strongest predictor of attainment in models combining all three survey waves. Urban residents show higher upward mobility than rural residents in every wave, and regional variation is wide --- the 2022–23 persistence score ranged from near zero in some regions to above 0.4 in Tashkent city.

The available evidence does not yet show that expansion is weakening the relationship between parental background and children's attainment. Most adult attainment observed in 2022–23 was shaped before the post-2017 surge in tertiary provision, so the expansion has not yet had time to reshape these survey profiles. But the persistence of family-background effects signals that access alone will not close the gap.

// ══════════════════════════════════════════════════════════════
// SECTION 3: COVID DISRUPTION
// ══════════════════════════════════════════════════════════════

#section-heading[When Schools Closed, Families Were on Their Own]

The 2022–23 LiTS child module covers roughly 180 households with school-age children --- a small subsample, but the disruption it records is large.#footnote[Respondents with a child enrolled before COVID and non-missing parental schooling. Results describe patterns; they are not causal estimates.]

#figure(
  image("../outputs/figures/policy_brief_disruption.png", width: 80%),
  caption: [COVID-19 disruption and household learning support. Source: LiTS IV (2022–23) child module, Uzbekistan subsample (~180 households).],
) <fig-disruption>

#val("stopped_covid") of households reported that a child's education stopped entirely. Nearly three in four faced at least one barrier to remote learning: #val("challenge_internet") cited internet problems, #val("challenge_device") lacked adequate devices. When formal schooling was interrupted, mothers provided most reported learning support --- #val("support_mother") of cases, compared with #val("support_father") for fathers. Families with less-educated parents reported more internet and device difficulties.

The lesson extends beyond pandemics. When formal instruction is interrupted, students from lower-resource families are more exposed. Digital inclusion requires reliable connections, working devices, and a realistic acknowledgment that not all households can substitute for schools equally.

// ══════════════════════════════════════════════════════════════
// SECTION 4: RECOMMENDATIONS
// ══════════════════════════════════════════════════════════════

#section-heading[Three Priorities for the Next Reform Phase]

The evidence in this brief is descriptive. It does not estimate the effect of specific reforms. Even so, it points to three areas where policy can be better matched to the problem the data reveal.

#rec-box("A", "Intervene earlier and at predictable risk points")[
  The pattern is consistent with disadvantage accumulating before tertiary entry. The Ministry of Preschool and School Education and regional education departments should focus on three transitions: end of lower secondary, end of upper secondary, and first year of tertiary. *Near-term (2026–27):* diagnostic assessments tied to remediation at grades 9 and 11, with rural districts prioritized. *Medium-term (2027–29):* structured academic support and transition guidance for students from first-generation and rural backgrounds around national exam years. Concrete indicator: entrance-exam participation and first-year enrollment rates disaggregated by region, gender, and rural-urban status.
]

#rec-box("B", "Judge tertiary expansion by who enters, stays, and finishes")[
  Additional seats do not address information gaps, weaker preparation, or unfamiliarity with application procedures. *Near-term:* the Ministry of Higher Education, Science and Innovation should require new and branch-campus institutions in high-expansion regions to run structured outreach in secondary schools. *Medium-term:* need-based grants, rural dormitory and transport support, and preparatory courses in low-access districts. Academic bridge programs and first-year advising should be standard for students whose parents did not attend university. *Ongoing:* first-year retention monitored as a routine metric; quality assurance scaled with admissions.
]

#rec-box("C", "Build a routine equity-monitoring system")[
  Uzbekistan currently has no regular mechanism for tracking whether opportunity is becoming more equal. *Near-term (2026–27):* the National Statistics Committee, in coordination with the Ministry of Higher Education, Science and Innovation, should publish annual enrollment and completion rates disaggregated by region and gender --- existing administrative data already support this. *Longer-term (2028+):* a dashboard linking administrative records on enrollment, retention, exam participation, and completion with household-survey indicators of parental education, urban-rural residence, and learning conditions.
]

// ── Success criteria ──
#success-box[
  In five years, an effective equity strategy would show: (a) rising first-generation tertiary enrollment, (b) narrowing urban-rural completion gaps, (c) a measurable reduction in the persistence score toward the lower end of the international range, and (d) routine public reporting of disaggregated outcomes. The LiTS data used here cover only three snapshots over 13 years. A system built on administrative records could provide annual updates and flag disparities as they develop.
]

// ══════════════════════════════════════════════════════════════
// LIMITS
// ══════════════════════════════════════════════════════════════

#section-heading[A Note on the Evidence]

This brief draws on patterns in repeated cross-sectional survey data. It does not estimate causal effects of specific reforms. Most adult attainment observed in the surveys was shaped before the post-2017 expansion, so the results establish how strong family-background persistence is but cannot yet tell us whether the expansion is weakening it. The COVID module covers a small subsample and illustrates patterns rather than proves mechanisms. These are real limitations --- but they do not diminish the central finding: family background remains a strong predictor of educational attainment in Uzbekistan, and rapid expansion is occurring alongside a wide opportunity gap. Full methods, diagnostics, and robustness tests are in the companion research paper and technical appendix.
