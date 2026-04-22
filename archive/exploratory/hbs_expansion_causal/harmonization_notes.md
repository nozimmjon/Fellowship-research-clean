# Harmonization Notes

The exploratory HBS expansion module is isolated from the frozen LiTS main paper and from the older HBS supplement.

## HBS person-level construction

- The harmonized file uses the annual HBS roster as the person spine and left-joins education, migration, household weights, internet, migration/remittance, multigenerational, and dwelling-based welfare fields.
- `survey_year`, `household_id`, and `person_id` are retained as the person identifiers.
- `birth_year` is constructed as `survey_year - age`.
- `region` is harmonized from the HBS province labels and then mapped to the admin treatment geography.
- `currently_enrolled` comes from `edu_enrolled`.
- `tertiary_enrolled_proxy` flags currently enrolled respondents whose education labels indicate a tertiary track.
- `tertiary_completed_proxy` is a conservative proxy based on tertiary-level labels plus completion or non-enrollment status when available.
- Parent linkage follows the conservative co-resident son/daughter rule, using head/spouse education with a minimum 12-year age gap.
- `welfare_proxy` is a within-year standardized housing-space proxy built from dwelling area per capita, with rooms per capita as fallback.

## Admin treatment inputs

- `uzbekistan_expansion_treatment_panel_final.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_bachelor_access_panel_final.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_he_capacity_panel_final.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_youth_population_20_24_panel.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_expansion_source_registry_final.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_expansion_qa_checks_final.csv` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.
- `uzbekistan_university_expansion_final.xlsx` loaded from `C:/Users/n.ortiqov/Desktop/Fellowship research/data/raw/admin`.

- Current treatment variables are merged with `academic_year_start = survey_year - 1`, which aligns each calendar-year HBS extract to the academic year in force across most of that survey year.
- Respondent-specific exposure measures additionally average region-level treatment intensity over the years when each respondent was ages 17-20, limited to the observed 2019-2024 admin panel.

## Output isolation

- All new module outputs are written under `outputs/hbs_expansion_causal/` or to dedicated `hbs_expansion_*.parquet` processed files.
