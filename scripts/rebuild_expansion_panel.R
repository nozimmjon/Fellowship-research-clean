source("R/00_config.R")

ensure_project_dirs()

input_path <- file.path(PROJ_PATHS$raw_data, "admin", "uzbekistan_expansion_treatment_panel_final.csv")
output_path <- file.path(PROJ_PATHS$processed_data, "uzbekistan_expansion_panel.csv")

if (!file.exists(input_path)) {
  stop(
    paste0(
      "Missing required admin source file: ",
      normalizePath(input_path, winslash = "/", mustWork = FALSE)
    ),
    call. = FALSE
  )
}

panel_raw <- read.csv(input_path, stringsAsFactors = FALSE)

required_cols <- c(
  "geography",
  "academic_year_start",
  "admissions_bachelor_per_1000_youth_20_24",
  "hei_count_per_1000_youth_20_24",
  "students_total_per_1000_youth_20_24",
  "expansion_index_main",
  "high_expansion_region_main"
)

missing_cols <- setdiff(required_cols, names(panel_raw))
if (length(missing_cols) > 0) {
  stop(
    paste0(
      "Source file is missing required columns: ",
      paste(missing_cols, collapse = ", ")
    ),
    call. = FALSE
  )
}

panel <- panel_raw[
  panel_raw$academic_year_start >= 2020 & panel_raw$academic_year_start <= 2024,
  required_cols
]

panel$admin_region <- as.character(panel$geography)
panel$academic_year_start_for_merge <- as.integer(panel$academic_year_start)
panel$admissions_bachelor_per_1000_youth_20_24 <- as.numeric(panel$admissions_bachelor_per_1000_youth_20_24)
panel$hei_count_per_1000_youth_20_24 <- as.numeric(panel$hei_count_per_1000_youth_20_24)
panel$students_total_per_1000_youth_20_24 <- as.numeric(panel$students_total_per_1000_youth_20_24)
panel$expansion_index_main <- as.numeric(panel$expansion_index_main)
panel$high_expansion_region <- as.integer(panel$high_expansion_region_main)

panel <- panel[
  order(panel$admin_region, panel$academic_year_start_for_merge),
  c(
    "admin_region",
    "academic_year_start_for_merge",
    "admissions_bachelor_per_1000_youth_20_24",
    "hei_count_per_1000_youth_20_24",
    "students_total_per_1000_youth_20_24",
    "expansion_index_main",
    "high_expansion_region"
  )
]

write.csv(panel, output_path, row.names = FALSE)
message("Wrote: ", normalizePath(output_path, winslash = "/", mustWork = FALSE))
