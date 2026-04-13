// typst-show.typ — Full policy-brief styling.
// Owns: page setup, typography, title banner, heading show rules, callout boxes,
// figure/table/footnote styling.  typst-template.typ is a passthrough only.

#let primary    = rgb("#1b6ca8")
#let accent     = rgb("#c56b00")
#let bg-light   = rgb("#f0f5fa")
#let bg-warm    = rgb("#fef7f0")
#let text-color = rgb("#2c3e50")
#let text-muted = rgb("#6c7a89")

// Font stack: Roboto is ideal; fall back to common Windows/Linux/macOS fonts
// so the brief renders cleanly even without Roboto installed.
#let body-font = ("Roboto", "Segoe UI", "Calibri", "Arial")

#show: doc => {

  // ── Page ──────────────────────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    footer: context {
      v(4pt)
      line(length: 100%, stroke: 0.4pt + luma(210))
      v(3pt)
      set text(7.5pt, fill: text-muted)
      [Center for Economic Research and Reforms · CAP Fellowship]
      h(1fr)
      [#counter(page).display() of #counter(page).final().first()]
    },
  )

  // ── Typography ────────────────────────────────────────────────────────────
  set text(size: 10pt, fill: text-color, lang: "en", font: body-font)
  set par(justify: true, leading: 0.58em, spacing: 0.7em, first-line-indent: 0pt)

  // ── Title banner ──────────────────────────────────────────────────────────
  {
    rect(
      width: 100%,
      fill: primary,
      inset: (x: 18pt, y: 16pt),
      radius: 2pt,
    )[
      #set text(fill: white)
      #text(16pt, weight: "bold")[
        Uzbekistan Expanded Higher Education.#linebreak()Did Equality of Opportunity Follow?
      ]
      #v(4pt)
      #text(10.5pt, style: "italic")[Evidence from three waves of household survey data, 2010–2023]
      #v(10pt)
      #line(length: 30%, stroke: 0.5pt + rgb("#ffffff").transparentize(40%))
      #v(4pt)
      #text(9pt, weight: "medium")[Nozimjon Ortiqov]
      #h(8pt)
      #text(8.5pt)[Center for Economic Research and Reforms #sym.dot.c CAP Fellow #sym.dot.c April 2026]
    ]
    v(14pt)
  }

  // ── Headings ──────────────────────────────────────────────────────────────
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

  // ── Callout / block-quote boxes ───────────────────────────────────────────
  // Quarto renders .callout-note in Typst via its own callout function.
  // We also style raw block-quotes (> …) the same way as a fallback.
  show quote: it => {
    block(
      width: 100%,
      fill: bg-light,
      stroke: (left: 3pt + primary),
      inset: (x: 12pt, y: 9pt),
      radius: (right: 2pt),
      above: 9pt,
      below: 9pt,
    )[
      #set text(9.5pt)
      #it.body
    ]
  }

  // ── Horizontal rules → subtle dividers ───────────────────────────────────
  show line: it => {
    v(4pt)
    block(width: 100%, stroke: (top: 0.5pt + luma(210)))[#v(0pt)]
    v(4pt)
  }

  // ── Links ─────────────────────────────────────────────────────────────────
  show link: set text(fill: primary)

  // ── Figures ───────────────────────────────────────────────────────────────
  show figure: it => {
    block(
      above: 12pt,
      below: 8pt,
      breakable: false,
      width: 100%,
    )[
      #set align(center)
      #it
    ]
  }
  show figure.caption: it => {
    set text(8.5pt, fill: text-muted)
    it
  }

  // ── Tables ────────────────────────────────────────────────────────────────
  // Style tables to look like clean stat displays
  show table: it => {
    set text(9.5pt)
    block(
      above: 8pt,
      below: 10pt,
      width: 100%,
      stroke: none,
    )[
      #it
    ]
  }
  set table(
    stroke: none,
    inset: (x: 4pt, y: 5pt),
  )

  // ── Lists — tighter spacing ───────────────────────────────────────────────
  set list(indent: 12pt, body-indent: 6pt, spacing: 5pt)
  set enum(indent: 12pt, body-indent: 6pt, spacing: 5pt)

  // ── Footnotes ─────────────────────────────────────────────────────────────
  set footnote.entry(
    separator: line(length: 25%, stroke: 0.4pt + luma(200)),
  )
  show footnote.entry: set text(8pt, fill: text-muted)

  doc
}
