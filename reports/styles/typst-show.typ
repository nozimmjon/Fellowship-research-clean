// Professional policy brief — typst show rules
// Designed for clean, elegant A4 output with colored callout boxes

#let primary = rgb("#1b6ca8")
#let accent = rgb("#c56b00")
#let bg-light = rgb("#f0f5fa")
#let bg-warm = rgb("#fef7f0")
#let text-color = rgb("#2c3e50")
#let text-muted = rgb("#6c7a89")

#show: doc => {

  // ── Page ──
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    footer: context {
      v(4pt)
      line(length: 100%, stroke: 0.4pt + luma(210))
      v(3pt)
      set text(7.5pt, fill: text-muted)
      [Intergenerational Educational Mobility in Uzbekistan — Policy Brief]
      h(1fr)
      [#counter(page).display() of #counter(page).final().first()]
    },
  )

  // ── Typography ──
  set text(size: 10pt, fill: text-color, lang: "en", font: "Roboto")
  set par(justify: true, leading: 0.58em, spacing: 0.7em, first-line-indent: 0pt)

  // ── Title banner ──
  {
    rect(
      width: 100%,
      fill: primary,
      inset: (x: 18pt, y: 16pt),
      radius: 2pt,
    )[
      #set text(fill: white)
      #text(16pt, weight: "bold")[Educational Opportunity in Uzbekistan#linebreak()Remains Closely Tied to Family Background]
      #v(4pt)
      #text(10.5pt, style: "italic")[Implications for equity in learning, transition, and completion]
      #v(10pt)
      #line(length: 30%, stroke: 0.5pt + white.transparentize(40%))
      #v(4pt)
      #text(9pt, weight: "medium")[Nozimjon Ortiqov]
      #h(8pt)
      #text(8.5pt)[Center for Economic Research and Reforms  ·  CAP Fellow  ·  April 2026]
    ]
    v(14pt)
  }

  // ── Headings ──
  show heading.where(level: 1): it => {
    v(8pt)
    block(
      above: 12pt,
      below: 8pt,
      stroke: (top: 2pt + primary),
      inset: (top: 6pt),
    )[
      #set text(12pt, weight: "bold", fill: primary)
      #it.body
    ]
  }

  show heading.where(level: 2): it => {
    block(above: 8pt, below: 5pt)[
      #set text(10.5pt, weight: "bold", fill: primary)
      #it.body
    ]
  }

  // ── Callout boxes ──
  // Quarto renders callouts as block-quotes with a specific structure.
  // We style all block-quotes as callout boxes.
  show quote: it => {
    block(
      width: 100%,
      fill: bg-light,
      stroke: (left: 3pt + primary),
      inset: (x: 12pt, y: 8pt),
      radius: (right: 2pt),
      above: 8pt,
      below: 8pt,
    )[
      #set text(9.5pt)
      #it.body
    ]
  }

  // ── Links ──
  show link: set text(fill: primary)

  // ── Figures ──
  show figure: it => {
    set align(center)
    block(above: 10pt, below: 8pt, breakable: false, it)
  }
  show figure.caption: it => {
    set text(8.5pt, fill: text-muted)
    it
  }

  // ── Tables ──
  show table: set text(9pt)

  // ── Lists — tighter ──
  set list(indent: 12pt, body-indent: 6pt, spacing: 5pt)
  set enum(indent: 12pt, body-indent: 6pt, spacing: 5pt)

  // ── Footnotes ──
  set footnote.entry(separator: line(length: 25%, stroke: 0.4pt + luma(200)))
  show footnote.entry: set text(8pt, fill: text-muted)

  doc
}
