# Outcome Harmonization Audit

- Target age window: `18_24`.
- Working analytical sample: `no_migration_signal`.
- Candidate outcomes audited: current enrollment in any education; current enrollment in tertiary education; tertiary completion; years of schooling; completed upper secondary or more; post-secondary / tertiary entry proxy; upward mobility proxy.
- Raw education source fields `edu_enrolled`, `edu_highest`, and `edu_years` appear in all five HBS years; `edu_complete` appears only in 2024 and 2025.

- In the full linked 18-24 sample, usable linked observations appear in survey years `2021, 2025`.
- In the chosen `no_migration_signal` sample, usable observations appear in survey years `2025`.
- That means no candidate outcome can rescue repeated multi-year support inside the current working sample if the sample itself only appears in one survey year.

- Best conceptually aligned candidate after the audit: `current enrollment in tertiary education`, but it is only supported in `2025` within the chosen working sample.
- No candidate outcome passes the repeated-year rescue rule for Model B. The exploratory design therefore remains at Model A only.

Interpretation: the outcome fields themselves are not the only issue. The current chosen sample collapses to one survey year under the existing linkage and migration restrictions, so an outcome-only rescue does not restore a multi-year quasi-experimental design.
