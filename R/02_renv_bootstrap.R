bootstrap_renv <- function(
    lockfile = file.path(PROJECT_ROOT, "renv.lock"),
    library = PROJ_PATHS$r_libs
) {
  if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv")
  }

  if (!file.exists(lockfile)) {
    stop("renv.lock is missing. Regenerate and commit it before using bootstrap_renv().", call. = FALSE)
  }

  dir.create(library, recursive = TRUE, showWarnings = FALSE)
  renv::restore(
    project = PROJECT_ROOT,
    library = library,
    lockfile = lockfile,
    prompt = FALSE
  )

  invisible(TRUE)
}

snapshot_renv <- function(lockfile = file.path(PROJECT_ROOT, "renv.lock")) {
  if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv")
  }

  renv::snapshot(
    project = PROJECT_ROOT,
    lockfile = lockfile,
    prompt = FALSE
  )

  invisible(lockfile)
}
