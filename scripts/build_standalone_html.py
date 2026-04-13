"""Build standalone policy brief HTML with embedded images for WeasyPrint PDF conversion."""
import base64
import os
import re

os.chdir(os.path.join(os.path.dirname(__file__), ".."))

def b64img(path):
    with open(path, "rb") as f:
        return base64.b64encode(f.read()).decode()

fig1 = b64img("outputs/figures/fig1_regional_final.png")
fig2 = b64img("outputs/figures/tier_a_rank_rank_by_wave.png")

# Read rendered Quarto HTML and extract prose
with open("outputs/rendered/reports/20_policy_brief.html", "r", encoding="utf-8") as f:
    html = f.read()

# Extract text content from the callout box
summary_match = re.search(r'<div class="callout-body-container callout-body">\s*<p>(.*?)</p>\s*</div>', html, re.DOTALL)
summary_text = summary_match.group(1).strip() if summary_match else ""

# Extract all section content
sections = re.findall(r'<section[^>]*class="level2"[^>]*>(.*?)</section>', html, re.DOTALL)

# Extract footnotes
fn_matches = re.findall(r'<li id="fn\d+"><p>(.*?)<a href', html, re.DOTALL)
footnotes_html = "\n".join(f"<li>{fn.strip()}</li>" for fn in fn_matches)

# Build section HTML with figure replacements
section_html = ""
for sec in sections:
    sec = sec.replace('src="../outputs/figures/fig1_regional_final.png"',
                      f'src="data:image/png;base64,{fig1}"')
    sec = sec.replace('src="../outputs/figures/tier_a_rank_rank_by_wave.png"',
                      f'src="data:image/png;base64,{fig2}"')
    # Convert h2 headings
    sec = re.sub(r'<h2[^>]*>(.*?)</h2>', r'<h2>\1</h2>', sec)
    # Convert quarto figure wrappers to plain figures
    sec = re.sub(r'<div[^>]*class="quarto-float[^"]*"[^>]*>\s*<figure[^>]*>\s*<div[^>]*>', '<figure>', sec)
    sec = re.sub(r'</div>\s*<figcaption[^>]*class="quarto-float[^"]*"[^>]*>', '<figcaption>', sec)
    sec = re.sub(r'</figcaption>\s*</figure>\s*</div>', '</figcaption></figure>', sec)
    # Wrap recommendation paragraphs
    sec = re.sub(r'<p>(<strong>\d\.)', r'<div class="rec"><p>\1', sec)
    # Close rec divs (before next rec or section end)
    parts = sec.split('<div class="rec">')
    if len(parts) > 1:
        new_parts = [parts[0]]
        for i, part in enumerate(parts[1:], 1):
            if i < len(parts) - 1:
                new_parts.append('<div class="rec">' + part + '</div>')
            else:
                new_parts.append('<div class="rec">' + part + '</div>')
        sec = "".join(new_parts)
    section_html += sec

# Handle the closing note (after <hr>)
hr_split = section_html.rsplit("<hr>", 1)
if len(hr_split) == 2:
    section_html = hr_split[0] + "<hr>" + hr_split[1].replace("<p><em>", '<p class="note"><em>').replace("</em></p>", "</em></p>")

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
}
p {
  margin: 0 0 8pt 0;
  text-align: justify;
}
.summary-box {
  background: #f0f5fa;
  border-left: 3pt solid #1b6ca8;
  padding: 12pt 14pt;
  margin: 0 0 14pt 0;
  font-size: 10pt;
  line-height: 1.5;
}
.summary-box .label {
  font-weight: bold;
  font-size: 10.5pt;
  color: #1b6ca8;
  display: block;
  margin-bottom: 6pt;
}
figure {
  margin: 14pt 0;
  text-align: center;
  page-break-inside: avoid;
}
figure img {
  max-width: 100%;
  height: auto;
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

out = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Uzbekistan Expanded Higher Education. Did Equality of Opportunity Follow?</title>
<style>{CSS}</style>
</head>
<body>

<h1>Uzbekistan Expanded Higher Education.<br>Did Equality of Opportunity Follow?</h1>
<p class="subtitle">Evidence from three waves of household survey data, 2010-2023</p>
<p class="author-line">Nozimjon Ortiqov &middot; Center for Economic Research and Reforms &middot; CAP Fellow &middot; April 2026</p>

<div class="summary-box">
<span class="label">SUMMARY</span>
{summary_text}
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

outpath = "outputs/rendered/reports/policy_brief_standalone.html"
with open(outpath, "w", encoding="utf-8") as f:
    f.write(out)

print(f"Written: {os.path.getsize(outpath):,} bytes to {outpath}")
