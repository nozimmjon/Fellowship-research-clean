// Override default title block — our typst-show.typ renders the title in a colored banner
// This template partial suppresses the default Quarto title rendering for typst

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
  fontsize: 10.5pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Apply margin if provided
  set page(
    paper: paper,
    margin: margin,
  )
  set par(justify: true)
  set text(lang: lang, region: region, font: font, size: fontsize)

  // Skip default title rendering — handled by typst-show.typ
  // Skip default author rendering — handled by typst-show.typ

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
