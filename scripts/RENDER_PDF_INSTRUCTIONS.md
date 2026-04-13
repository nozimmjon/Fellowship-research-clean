# Render Policy Brief PDF via WeasyPrint

The standalone HTML is ready at:
`outputs/rendered/reports/policy_brief_standalone.html`

It is self-contained (all images embedded as base64, all CSS inlined). No external dependencies needed beyond WeasyPrint.

## Steps

1. Install WeasyPrint if not already installed:
```
pip install weasyprint
```

2. Render the PDF:
```
weasyprint outputs/rendered/reports/policy_brief_standalone.html outputs/rendered/reports/policy_brief_final.pdf
```

3. Copy to archive:
```
cp outputs/rendered/reports/policy_brief_final.pdf archive/releases/policy_brief_final.pdf
```

## Expected output

- A4 format, ~5 pages, Georgia serif font
- Blue headings with top borders
- Summary box with left blue border
- Recommendation blocks with left blue borders
- Endnotes section at the end
- Page numbers in footer

## Notes

- WeasyPrint requires GTK/Pango libraries. On Linux and macOS these are typically available. On Windows, a full MSYS2 or conda environment is needed.
- The HTML file does not need internet access to render. Everything is embedded.
- If the content changes, rebuild the HTML first: `python scripts/build_standalone_html.py` (requires the Quarto HTML at `outputs/rendered/reports/20_policy_brief.html` to exist).
