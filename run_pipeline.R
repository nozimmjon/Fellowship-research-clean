source("R/00_config.R")
activate_local_lib()
source("R/01_packages.R")
source("R/20_ingest_data.R")

check_required_packages()
ensure_project_dirs()

required_frozen_artifacts <- function() {
  c(
    file.path("data", "processed", "lits_harmonized.csv"),
    file.path("outputs", "tables", "module_a_summary_metrics.csv"),
    file.path("outputs", "tables", "module_b_model_coefficients.csv"),
    file.path("outputs", "tables", "module_c_mechanism_summary.csv")
  )
}

assert_frozen_artifacts <- function(paths = required_frozen_artifacts()) {
  missing <- paths[!file.exists(paths)]
  if (length(missing) > 0) {
    stop(
      paste0(
        "Required LiTS raw inputs were not found, and key precomputed artifacts are missing.\n",
        "Missing paths:\n  - ",
        paste(missing, collapse = "\n  - "),
        "\nSet FELLOWSHIP_RAW_DATA_ROOT and rebuild, or provide precomputed artifacts."
      ),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

run_targets_with_fallback <- function() {
  tryCatch(
    {
      assert_required_lits_inputs()
      # Run in-process for compatibility with restricted environments.
      targets::tar_make(callr_function = NULL)
      message("Pipeline completed by rebuilding from raw inputs.")
      invisible("rebuilt_from_raw")
    },
    error = function(e) {
      msg <- conditionMessage(e)
      if (!grepl("Required LiTS raw inputs were not found.", msg, fixed = TRUE)) {
        stop(e)
      }
      message(msg)
      message("LiTS raw inputs unavailable. Checking key precomputed artifacts...")
      assert_frozen_artifacts()
      message("Key artifacts are available; skipping tar_make.")
      invisible("using_precomputed_artifacts")
    }
  )
}

run_targets_with_fallback()
