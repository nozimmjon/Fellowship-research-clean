"""Build standalone policy brief v2 HTML with embedded images for WeasyPrint PDF conversion.

Reads the Quarto-rendered HTML of 20_policy_brief.qmd and rebuilds it as a
self-contained HTML file with base64-encoded images, inline CSS, and A4 page
rules suitable for WeasyPrint.

Usage:
    python scripts/build_standalone_html.py

Requires: rendered reports/20_policy_brief.html (run quarto render first).
"""
import base64
import os
import re
from html.parser import HTMLParser

os.chdir(os.path.join(os.path.dirname(__file__), ".."))


def b64img(path):
    """Encode an image file as a base64 data URI."""
    with open(path, "rb") as f:
        data = base64.b64encode(f.read()).decode()
    return f"data:image/png;base64,{data}"


# ── Encode all figures used in the brief ──
figures = {
    "fig1_regional_final.png": b64img("outputs/figures/fig1_regional_final.png"),
    "tier_a_rank_rank_by_wave.png": b64img("outputs/figures/tier_a_rank_rank_by_wave.png"),
    "policy_brief_disruption.png": b64img("outputs/figures/policy_brief_disruption.png"),
}

# ── Read the Quarto-rendered HTML ──
rendered_path = "reports/20_policy_brief.html"
if not os.path.exists(rendered_path):
    # Fallback to outputs/rendered location
    rendered_path = "outputs/rendered/reports/20_policy_brief.html"

with open(rendered_path, "r", encoding="utf-8") as f:
    html = f.read()

# ── Extract callout body content ──
def extract_callout(html_src, callout_class):
    """Extract the inner body content from a Quarto callout div."""
    # Find the callout-body-container after the callout class marker
    pattern = (
        rf'<div[^>]*class="[^"]*{callout_class}[^"]*"[^>]*>'
        r'.*?<div class="callout-body-container callout-body">\s*'
        r'(.*?)'
        r'\s*</div>\s*</div>'
    )
    m = re.search(pattern, html_src, re.DOTALL)
    return m.group(1).strip() if m else ""

key_messages_html = extract_callout(html, "callout-note")
success_html = extract_callout(html, "callout-tip")

# ── Extract all level-2 sections ──
sections = re.findall(r'<section[^>]*class="level2"[^>]*>(.*?)</section>', html, re.DOTALL)

# ── Extract footnotes ──
fn_matches = re.findall(r'<li id="fn\d+"[^>]*>\s*<p>(.*?)<a href', html, re.DOTALL)
footnotes_html = "\n".join(f"<li>{fn.strip()}</li>" for fn in fn_matches)

# ── Process sections ──
section_html = ""
for sec in sections:
    # Replace image src with base64
    for fname, b64 in figures.items():
        sec = re.sub(
            rf'src="[^"]*{re.escape(fname)}"',
            f'src="{b64}"',
            sec
        )

    # Also handle Quarto-generated figure images (from R chunks)
    # These have src like "20_policy_brief_files/figure-html/fig-disruption-1.png"
    disruption_chunk = re.search(r'src="([^"]*fig-disruption[^"]*)"', sec)
    if disruption_chunk:
        chunk_path = os.path.join("reports", disruption_chunk.group(1))
        if os.path.exists(chunk_path):
            sec = sec.replace(
                f'src="{disruption_chunk.group(1)}"',
                f'src="{b64img(chunk_path)}"'
            )
        else:
            # Fallback to pre-rendered disruption figure
            sec = sec.replace(
                f'src="{disruption_chunk.group(1)}"',
                f'src="{figures["policy_brief_disruption.png"]}"'
            )

    # Clean up h2 tags
    sec = re.sub(r'<h2[^>]*>(.*?)</h2>', r'<h2>\1</h2>', sec)

    # Convert Quarto figure wrappers to plain figures
    sec = re.sub(r'<div[^>]*class="quarto-float[^"]*"[^>]*>\s*<figure[^>]*>\s*<div[^>]*>', '<figure>', sec)
    sec = re.sub(r'</div>\s*<figcaption[^>]*class="quarto-float[^"]*"[^>]*>', '<figcaption>', sec)
    sec = re.sub(r'</figcaption>\s*</figure>\s*</div>', '</figcaption></figure>', sec)
    # Simpler figure wrapper patterns
    sec = re.sub(r'<div[^>]*class="[^"]*figure[^"]*"[^>]*>', '<figure>', sec)

    # Remove Quarto callout wrappers (already extracted above into key_messages_html / success_html)
    # The Quarto callout markup nests multiple divs (header, icon, title, body),
    # so we count open/close div tags to strip the entire block.
    def strip_callout(html_src, cls):
        """Remove a Quarto callout div by class, handling arbitrary div nesting."""
        pattern = re.compile(rf'<div[^>]*class="[^"]*{cls}[^"]*"[^>]*>', re.DOTALL)
        m = pattern.search(html_src)
        if not m:
            return html_src
        start = m.start()
        depth = 1
        pos = m.end()
        while depth > 0 and pos < len(html_src):
            open_m = re.search(r'<div[\s>]', html_src[pos:])
            close_m = re.search(r'</div>', html_src[pos:])
            if close_m is None:
                break
            if open_m and open_m.start() < close_m.start():
                depth += 1
                pos += open_m.end()
            else:
                depth -= 1
                pos += close_m.end()
        return html_src[:start] + html_src[pos:]

    sec = strip_callout(sec, 'callout-note')
    sec = strip_callout(sec, 'callout-tip')

    # Wrap recommendation paragraphs (bold numbered items)
    # Each rec runs from its bold-numbered <p> to just before the next rec or <hr>
    sec = re.sub(r'<p>(<strong>\d\.)', r'<div class="rec"><p>\1', sec)
    parts = sec.split('<div class="rec">')
    if len(parts) > 1:
        new_parts = [parts[0]]
        for part in parts[1:]:
            # Close the rec div before any <hr> so the closing note stays outside
            if "<hr>" in part:
                hr_idx = part.index("<hr>")
                new_parts.append('<div class="rec">' + part[:hr_idx] + '</div>\n' + part[hr_idx:])
            else:
                new_parts.append('<div class="rec">' + part + '</div>')
        sec = "".join(new_parts)

    section_html += sec

# ── Handle closing note after <hr> ──
hr_split = section_html.rsplit("<hr>", 1)
if len(hr_split) == 2:
    section_html = (
        hr_split[0] + "<hr>"
        + hr_split[1]
            .replace("<p><em>", '<p class="note"><em>')
            .replace("</em></p>", "</em></p>")
    )

# ── CSS ──
CSS = """
@page {
  size: A4;
  margin: 2.5cm;
  @bottom-center {
    content: counter(page);
    font-family: Georgia, "Times New Roman", serif;
    font-size: 9pt;
    color: #6c7a89;
  }
}
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: Georgia, "Times New Roman", serif;
  font-size: 10.5pt;
  line-height: 1.55;
  color: #2c3e50;
  orphans: 3;
  widows: 3;
}
h1 {
  font-size: 18pt;
  font-weight: bold;
  color: #1b6ca8;
  margin: 0 0 4pt 0;
  line-height: 1.25;
}
p.subtitle {
  font-size: 11pt;
  font-style: italic;
  color: #6c7a89;
  margin: 0 0 8pt 0;
}
p.author-line {
  font-size: 9.5pt;
  color: #6c7a89;
  margin: 0 0 18pt 0;
}
h2 {
  font-size: 12.5pt;
  font-weight: bold;
  color: #1b6ca8;
  border-top: 2pt solid #1b6ca8;
  padding-top: 6pt;
  margin: 18pt 0 8pt 0;
  page-break-after: avoid;
}
p {
  margin: 0 0 8pt 0;
  text-align: justify;
}
ul {
  margin: 0 0 8pt 0;
  padding-left: 18pt;
}
li {
  margin-bottom: 4pt;
}
.key-messages {
  background: #f0f5fa;
  border-left: 3pt solid #1b6ca8;
  padding: 12pt 14pt;
  margin: 0 0 14pt 0;
  font-size: 10pt;
  line-height: 1.5;
}
.key-messages .label {
  font-weight: bold;
  font-size: 10.5pt;
  color: #1b6ca8;
  display: block;
  margin-bottom: 6pt;
}
.key-messages ul {
  padding-left: 16pt;
}
.key-messages li {
  margin-bottom: 6pt;
}
.success-box {
  background: #f0faf5;
  border-left: 3pt solid #2a9d8f;
  padding: 12pt 14pt;
  margin: 14pt 0;
  font-size: 10pt;
  line-height: 1.5;
}
.success-box .label {
  font-weight: bold;
  font-size: 10.5pt;
  color: #2a9d8f;
  display: block;
  margin-bottom: 6pt;
}
figure {
  margin: 14pt 0;
  text-align: center;
}
figure img {
  max-width: 100%;
  max-height: 250pt;
  height: auto;
  width: auto;
}
figcaption {
  font-size: 8.5pt;
  color: #6c7a89;
  text-align: left;
  margin-top: 4pt;
  line-height: 1.4;
}
.rec {
  border-left: 3pt solid #1b6ca8;
  padding-left: 12pt;
  margin: 10pt 0;
}
.rec strong { color: #1b6ca8; }
hr {
  border: none;
  border-top: 0.5pt solid #ccc;
  margin: 16pt 0;
}
p.note {
  font-style: italic;
  font-size: 10pt;
  color: #555;
}
.endnotes {
  margin-top: 16pt;
  border-top: 0.5pt solid #ccc;
  padding-top: 8pt;
}
.endnotes h3 {
  font-size: 10.5pt;
  font-weight: bold;
  color: #1b6ca8;
  margin-bottom: 6pt;
}
.endnotes ol {
  font-size: 8.5pt;
  color: #555;
  line-height: 1.45;
  padding-left: 18pt;
}
.endnotes li { margin-bottom: 4pt; }
sup { font-size: 7.5pt; }
"""

# ── Insert success box before the <hr> / closing note ──
# The section_html contains an <hr> followed by the closing note paragraph.
# We want: ... recommendations ... success box ... <hr> ... closing note ...
success_block = f"""<div class="success-box">
<span class="label">What Would Success Look Like?</span>
{success_html}
</div>""" if success_html else ""

# Place success box just before the <hr>
if "<hr>" in section_html and success_block:
    section_html = section_html.replace("<hr>", success_block + "\n<hr>", 1)

# ── Assemble final HTML ──
out = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Uzbekistan Expanded Higher Education. Did Equality of Opportunity Follow?</title>
<style>{CSS}</style>
</head>
<body>

<h1>Uzbekistan Expanded Higher Education.<br>Did Equality of Opportunity Follow?</h1>
<p class="subtitle">Evidence from 2010&ndash;2023</p>
<p class="author-line">Nozimjon Ortiqov &middot; Center for Economic Research and Reforms &middot; CAP Fellow &middot; April 2026</p>

<div class="key-messages">
<span class="label">KEY MESSAGES</span>
{key_messages_html}
</div>

{section_html}

<div class="endnotes">
<h3>Notes</h3>
<ol>
{footnotes_html}
</ol>
</div>

</body>
</html>"""

# ── Write output ──
outdir = os.path.join("outputs", "rendered", "reports")
os.makedirs(outdir, exist_ok=True)
outpath = os.path.join(outdir, "policy_brief_standalone.html")
with open(outpath, "w", encoding="utf-8") as f:
    f.write(out)

print(f"Written: {os.path.getsize(outpath):,} bytes to {outpath}")
