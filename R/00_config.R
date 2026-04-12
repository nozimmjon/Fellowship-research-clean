options(stringsAsFactors = FALSE)

find_project_root <- function(start = getwd()) {
  path <- normalizePath(start, winslash = "/", mustWork = TRUE)
  repeat {
    markers <- c("_targets.R", "FellowshipResearch.Rproj")
    if (all(file.exists(file.path(path, markers)))) {
      return(path)
    }
    parent <- dirname(path)
    if (identical(parent, path)) {
      stop("Project root not found. Open FellowshipResearch.Rproj or run from project directory.")
    }
    path <- parent
  }
}

PROJECT_ROOT <- find_project_root()

discover_raw_data_root <- function(project_root = PROJECT_ROOT) {
  local_raw <- file.path(project_root, "data", "raw")
  sibling_legacy_raw <- file.path(dirname(project_root), "Fellowship research", "data", "raw")
  env_raw <- Sys.getenv("FELLOWSHIP_RAW_DATA_ROOT", unset = "")

  has_required_lits_waves <- function(path) {
    if (!nzchar(path) || !dir.exists(path)) {
      return(FALSE)
    }

    lits_dir <- file.path(path, "lits")
    required <- list(
      `2010` = c(
        file.path(lits_dir, "lits_ii.csv"),
        file.path(lits_dir, "lits2.dta")
      ),
      `2016` = c(
        file.path(lits_dir, "lits_iii.dta"),
        file.path(lits_dir, "lits_iii.csv")
      ),
      `2022` = c(
        file.path(lits_dir, "lits_iv_dta", "lits_iv.dta")
      )
    )

    all(vapply(required, function(paths) any(file.exists(paths)), logical(1)))
  }

  has_payload <- function(path) {
    if (!nzchar(path) || !dir.exists(path)) {
      return(FALSE)
    }

    has_data_files <- function(d) {
      if (!dir.exists(d)) {
        return(FALSE)
      }

      files <- list.files(
        d,
        recursive = TRUE,
        full.names = TRUE,
        all.files = TRUE,
        no.. = TRUE,
        include.dirs = FALSE
      )
      if (length(files) == 0) {
        return(FALSE)
      }

      keep <- !tolower(basename(files)) %in% c(".gitkeep", "readme.md")
      any(keep)
    }

    subdirs <- file.path(path, c("lits", "hbs", "admin"))
    any(vapply(subdirs, has_data_files, logical(1)))
  }

  candidates <- unique(c(env_raw, local_raw, sibling_legacy_raw))
  for (candidate in candidates) {
    if (has_required_lits_waves(candidate)) {
      return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
    }
  }

  for (candidate in candidates) {
    if (has_payload(candidate)) {
      return(normalizePath(candidate, winslash = "/", mustWork = TRUE))
    }
  }

  normalizePath(local_raw, winslash = "/", mustWork = FALSE)
}

PROJ_PATHS <- list(
  raw_data = discover_raw_data_root(PROJECT_ROOT),
  processed_data = file.path(PROJECT_ROOT, "data", "processed"),
  metadata = file.path(PROJECT_ROOT, "data", "metadata"),
  outputs = file.path(PROJECT_ROOT, "outputs"),
  tables = file.path(PROJECT_ROOT, "outputs", "tables"),
  figures = file.path(PROJECT_ROOT, "outputs", "figures"),
  models = file.path(PROJECT_ROOT, "outputs", "models"),
  reports = file.path(PROJECT_ROOT, "reports"),
  scripts = file.path(PROJECT_ROOT, "R"),
  r_libs = file.path(PROJECT_ROOT, "r_libs")
)

ANALYSIS_SAMPLE <- list(
  age_min = 25L,
  age_max = 64L
)

EDUCATION_LEVELS <- c(
  "no_formal",
  "primary",
  "lower_secondary",
  "upper_secondary",
  "post_secondary_non_tertiary",
  "tertiary"
)

UZB_REGIONS <- c(
  "Andijan",
  "Bukhara",
  "Fergana",
  "Jizzakh",
  "Karakalpakstan",
  "Khorezm",
  "Namangan",
  "Navoiy",
  "Qashqadaryo",
  "Samarkand",
  "Sirdaryo",
  "Surkhandarya",
  "Tashkent",
  "Tashkent City"
)

ensure_project_dirs <- function() {
  dirs <- unlist(PROJ_PATHS, use.names = FALSE)
  for (d in dirs) {
    if (!dir.exists(d)) {
      dir.create(d, recursive = TRUE, showWarnings = FALSE)
    }
  }
  invisible(TRUE)
}

activate_local_lib <- function() {
  lib_path <- PROJ_PATHS$r_libs
  if (!dir.exists(lib_path)) {
    dir.create(lib_path, recursive = TRUE, showWarnings = FALSE)
  }
  .libPaths(c(lib_path, .libPaths()))
  invisible(.libPaths())
}
