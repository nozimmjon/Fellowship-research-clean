source("R/00_config.R")
activate_local_lib()
source("R/01_packages.R")
source("R/20_ingest_data.R")

check_required_packages()
ensure_project_dirs()

required_frozen_artifacts <- function() {
  c(
    file.path("data", "processed", "lits_harmonized.csv"),
    file.path("data", "processed", "hbs_linkage_diagnostics.csv"),
    file.path("outputs", "tables", "module_a_summary_metrics.csv"),
    file.path("outputs", "tables", "module_a_subgroup_metrics.csv"),
    file.path("outputs", "tables", "module_a_transition_matrix.csv"),
    file.path("outputs", "tables", "module_a_persistence_by_parent.csv"),
    file.path("outputs", "tables", "tier_a_sample_by_wave.csv"),
    file.path("outputs", "tables", "tier_a_national_trends.csv"),
    file.path("outputs", "tables", "tier_a_subgroup_trends.csv"),
    file.path("outputs", "tables", "tier_a_region_trends.csv"),
    file.path("outputs", "tables", "tier_a_transition_summary.csv"),
    file.path("outputs", "tables", "tier_a_data_completeness.csv"),
    file.path("outputs", "tables", "module_b_model_coefficients.csv"),
    file.path("outputs", "tables", "module_b_key_coefficient_comparison.csv"),
    file.path("outputs", "tables", "module_b_persistence_wave_profiles.csv"),
    file.path("outputs", "tables", "module_b_wave_difference_tests.csv"),
    file.path("outputs", "tables", "module_b_covariate_classification.csv"),
    file.path("outputs", "tables", "module_b_selected_covariates.csv"),
    file.path("outputs", "tables", "module_b_covariate_coverage.csv"),
    file.path("outputs", "tables", "module_b_formulae.csv"),
    file.path("outputs", "tables", "module_c_mechanism_summary.csv"),
    file.path("outputs", "tables", "module_c_mechanism_sample.csv"),
    file.path("outputs", "tables", "module_c_mechanism_coefficients.csv"),
    file.path("outputs", "tables", "module_c_mechanism_coverage.csv"),
    file.path("outputs", "tables", "module_c_mechanism_formulae.csv"),
    file.path("outputs", "tables", "module_c_mechanism_robustness_scenarios.csv"),
    file.path("outputs", "tables", "module_c_mechanism_robustness_coefficients.csv"),
    file.path("outputs", "tables", "empirical_rank_rank_change_tests.csv"),
    file.path("outputs", "tables", "empirical_parent_missingness_by_wave.csv"),
    file.path("outputs", "tables", "empirical_parent_missingness_observables.csv"),
    file.path("outputs", "tables", "empirical_parent_missingness_sensitivity.csv"),
    file.path("outputs", "tables", "empirical_parent_harmonization_robustness.csv"),
    file.path("outputs", "tables", "empirical_common_region_rank_rank.csv"),
    file.path("outputs", "tables", "empirical_subgroup_trend_checks.csv"),
    file.path("outputs", "tables", "empirical_trend_comparison.csv"),
    file.path("outputs", "tables", "hbs_household_support_context.csv"),
    file.path("outputs", "figures", "tier_a_rank_rank_by_wave.png"),
    file.path("outputs", "figures", "tier_a_directional_rates_by_wave.png"),
    file.path("outputs", "figures", "tier_a_upward_by_urban_rural.png"),
    file.path("outputs", "figures", "tier_a_upward_by_gender.png")
  )
}

assert_frozen_artifacts <- function(paths = required_frozen_artifacts()) {
  missing <- paths[!file.exists(paths)]
  if (length(missing) > 0) {
    stop(
      paste0(
        "LiTS raw inputs are unavailable and required precomputed artifacts are missing.\n",
        "Missing paths:\n  - ",
        paste(missing, collapse = "\n  - "),
        "\nProvide raw data to rebuild, or populate these artifacts before running replication."
      ),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

run_targets_with_fallback <- function() {
  message("Running targets pipeline...")
  tryCatch(
    {
      assert_required_lits_inputs()
      targets::tar_make(callr_function = NULL)
      "rebuilt_from_raw"
    },
    error = function(e) {
      msg <- conditionMessage(e)
      if (!grepl("Required LiTS raw inputs were not found.", msg, fixed = TRUE)) {
        stop(e)
      }
      message(msg)
      message("LiTS raw inputs unavailable. Checking precomputed artifacts...")
      assert_frozen_artifacts()
      message("Using precomputed artifacts and continuing with Quarto renders.")
      "render_from_precomputed_artifacts"
    }
  )
}

resolve_quarto <- function() {
  q <- Sys.which("quarto")
  if (!nzchar(q)) {
    candidates <- c(
      "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe",
      "C:/Program Files/Quarto/bin/quarto.exe"
    )
    hits <- candidates[file.exists(candidates)]
    if (length(hits) > 0) {
      q <- hits[[1]]
    }
  }
  if (!nzchar(q)) {
    stop("Quarto executable not found. Install Quarto or add it to PATH.")
  }
  q
}

configure_quarto_r <- function() {
  if (nzchar(Sys.getenv("QUARTO_R", unset = ""))) {
    return(invisible(Sys.getenv("QUARTO_R")))
  }

  rscript_bin <- normalizePath(
    file.path(R.home("bin"), "Rscript.exe"),
    winslash = "/",
    mustWork = FALSE
  )
  if (file.exists(rscript_bin)) {
    Sys.setenv(QUARTO_R = rscript_bin)
  }

  invisible(Sys.getenv("QUARTO_R", unset = ""))
}

render_report <- function(quarto_bin, input_file) {
  if (!file.exists(input_file)) {
    stop("Report source file not found: ", input_file, call. = FALSE)
  }
  message("Rendering: ", input_file)
  out <- system2(
    quarto_bin,
    args = c("render", input_file),
    stdout = TRUE,
    stderr = TRUE
  )
  if (length(out) > 0) {
    cat(paste(out, collapse = "\n"), "\n")
  }
  status <- attr(out, "status")
  if (is.null(status)) {
    status <- 0L
  }
  if (!identical(as.integer(status), 0L)) {
    stop(
      sprintf("Quarto render failed for %s with exit status %s.", input_file, as.integer(status)),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

pipeline_mode <- run_targets_with_fallback()
quarto_bin <- resolve_quarto()
configure_quarto_r()
reports_to_render <- c(
  "reports/00_main.qmd",
  "reports/10_technical_appendix.qmd",
  "reports/20_policy_brief.qmd",
  "reports/30_slides.qmd"
)

invisible(lapply(reports_to_render, function(f) render_report(quarto_bin, f)))

message("Replication completed (mode: ", pipeline_mode, ").")
