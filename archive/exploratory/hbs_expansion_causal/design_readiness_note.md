# Design Readiness Note

- Preferred linkage window: `18_24`.
- Preferred outcome: `tertiary enrollment`.
- Linkage pass at the window level: `TRUE`.
- Outcome-maturity pass at the window level: `TRUE`.
- Residence-stability samples compared: full linked sample; no migration-signal sample; conservative likely-stayer sample based on explicit residence-history cues.

- `Full linked sample`: N = 8,224; effective link rate = 22.4%; immigrant share = 26.3%; ambiguity share = 43.4%; ambiguity reduction vs full = 0.0%; cell median = 68.5; cell share >=10 = 100.0%; overall pass = `FALSE`.
- `No migration-signal sample`: N = 4,114; effective link rate = 11.2%; immigrant share = 0.0%; ambiguity share = 14.1%; ambiguity reduction vs full = 29.2%; cell median = 48.5; cell share >=10 = 95.2%; overall pass = `TRUE`.
- `Conservative likely-stayer sample`: N = 3,542; effective link rate = 9.6%; immigrant share = 0.0%; ambiguity share = 0.0%; ambiguity reduction vs full = 43.4%; cell median = 39.5; cell share >=10 = 95.2%; overall pass = `FALSE`.

- Binding constraint: `none`.
- Chosen analytical sample for a gated next step: `no_migration_signal`.

A residence-stability restriction materially reduced exposure-region ambiguity while preserving enough usable cells. The next unlocked step is Model A only.
