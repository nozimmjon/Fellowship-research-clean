// typst-template.typ — Minimal passthrough.
// All page setup, typography, and styling live in typst-show.typ so there is no
// conflict between the two partials.  The article() function here only accepts
// the standard Quarto parameters (so Quarto can call it) and renders the body.

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (:),
  paper: "a4",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 10pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // typst-show.typ handles set page, set text, title banner, and all show rules.
  // This function is intentionally a passthrough so the two partials do not
  // fight over page/text settings.
  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
