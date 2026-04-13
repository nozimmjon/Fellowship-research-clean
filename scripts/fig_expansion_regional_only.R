# fig_expansion_regional_only.R
# Standalone Cleveland dot plot of regional higher-education expansion for the
# policy brief.  Panel A (national bar chart) is dropped — stated in text.
#
# Output: outputs/figures/fig1_regional_final.png (6.3 x 4 in, 300 DPI)

library(ggplot2)

# ── Project root ───────────────────────────────────────────────────────────────
script_dir <- tryCatch(
  dirname(normalizePath(sys.frames()[[1]]$ofile, mustWork = FALSE)),
  error = function(e) NULL
)
project_root <- if (!is.null(script_dir) && dir.exists(file.path(script_dir, "..", "data"))) {
  normalizePath(file.path(script_dir, ".."), mustWork = FALSE)
} else if (dir.exists(file.path(getwd(), "data"))) {
  normalizePath(getwd(), mustWork = FALSE)
} else {
  normalizePath("C:/Users/n.ortiqov/Desktop/Fellowship research clean", mustWork = FALSE)
}

data_path   <- file.path(project_root, "data", "processed", "uzbekistan_expansion_panel.csv")
output_path <- file.path(project_root, "outputs", "figures", "fig1_regional_final.png")

stopifnot(file.exists(data_path))

# ── Load & reshape ─────────────────────────────────────────────────────────────
panel <- read.csv(data_path, stringsAsFactors = FALSE)

# Keep only the two endpoint years
end_years <- panel[
  panel$academic_year_start_for_merge %in% c(2020, 2024),
  c("admin_region", "academic_year_start_for_merge",
    "students_total_per_1000_youth_20_24",
    "high_expansion_region", "expansion_index_main")
]

exp_wide <- reshape(
  end_years,
  idvar     = "admin_region",
  timevar   = "academic_year_start_for_merge",
  direction = "wide"
)

# Tidy column names after reshape
names(exp_wide) <- gsub(
  "students_total_per_1000_youth_20_24\\.", "y",
  gsub("high_expansion_region\\.", "high_",
       gsub("expansion_index_main\\.", "idx_", names(exp_wide)))
)
# Expected: admin_region | y2020 | high_2020 | idx_2020 | y2024 | high_2024 | idx_2024

# Growth multiplier (rounded to 1 decimal)
exp_wide$growth <- round(exp_wide$y2024 / exp_wide$y2020, 1)

# High/low classification: use pre-computed composite-index flag for 2024 wave
exp_wide$expansion_group <- factor(
  ifelse(exp_wide$high_2024 == 1, "High expansion", "Low expansion"),
  levels = c("High expansion", "Low expansion")
)

# ── Tashkent city: extract for subtitle, exclude from plot ─────────────────────
tash <- exp_wide[exp_wide$admin_region == "Tashkent city", ]
exp_plot <- exp_wide[exp_wide$admin_region != "Tashkent city", ]

# Tashkent subtitle text (use data values; fallback to user-supplied if missing)
tash_start <- if (nrow(tash) == 1) formatC(round(tash$y2020), big.mark = ",", format = "d") else "1,026"
tash_end   <- if (nrow(tash) == 1) formatC(round(tash$y2024), big.mark = ",", format = "d") else "2,869"
tash_mult  <- if (nrow(tash) == 1) paste0(tash$growth, "x") else "2.8x"

# ── Clean region labels ────────────────────────────────────────────────────────
exp_plot$region_label <- gsub(" region$| republic$", "", exp_plot$admin_region)
exp_plot$region_label <- gsub("^Republic of ", "", exp_plot$region_label)

# Sort by growth multiplier (ascending so highest is at top)
exp_plot <- exp_plot[order(exp_plot$growth), ]
exp_plot$region_label <- factor(exp_plot$region_label, levels = exp_plot$region_label)

# ── Plot ───────────────────────────────────────────────────────────────────────
# Right-margin padding: leave room for multiplier labels
x_max_pad <- max(exp_plot$y2024, na.rm = TRUE) * 1.22

p <- ggplot(exp_plot) +
  # Connecting segment
  geom_segment(
    aes(x = y2020, xend = y2024, y = region_label, yend = region_label),
    color    = "grey72",
    linewidth = 0.55
  ) +
  # Start dot (2020/21) — neutral grey, no legend entry
  geom_point(
    aes(x = y2020, y = region_label),
    color = "grey52",
    size  = 2.0,
    shape = 19
  ) +
  # End dot (2024/25) — colored by expansion group
  geom_point(
    aes(x = y2024, y = region_label, color = expansion_group),
    size  = 2.4,
    shape = 19
  ) +
  # Growth multiplier label
  geom_text(
    aes(x = y2024 + (max(y2024, na.rm = TRUE) * 0.04),
        y = region_label,
        label = paste0(growth, "x")),
    size    = 2.6,
    hjust   = 0,
    color   = "grey28",
    family  = ""
  ) +
  # Manual colour scale
  scale_color_manual(
    values = c("High expansion" = "#1b6ca8", "Low expansion" = "#c56b00"),
    name   = NULL
  ) +
  # Expand x to show labels; clip segments at plot edge
  scale_x_continuous(
    expand = expansion(mult = c(0.02, 0)),
    limits = c(NA, x_max_pad)
  ) +
  labs(
    title    = "Regional higher-education expansion, 2020/21\u2013 2024/25",
    subtitle = paste0(
      "Tashkent city excluded: ", tash_start, " \u2192 ", tash_end,
      " (", tash_mult, ").\u2003Grey dot = 2020/21; colored dot = 2024/25."
    ),
    x = "Students per 1,000 youth (20\u201324)",
    y = NULL
  ) +
  theme_minimal(base_size = 10) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_line(color = "grey90", linewidth = 0.35),
    axis.text.y        = element_text(size = 8.5, color = "grey20"),
    axis.text.x        = element_text(size = 8),
    axis.title.x       = element_text(size = 8.5, margin = margin(t = 5)),
    legend.position    = "bottom",
    legend.margin      = margin(t = 2),
    legend.text        = element_text(size = 8.5),
    plot.title         = element_text(size = 10, face = "bold",   margin = margin(b = 3)),
    plot.subtitle      = element_text(size = 7.8, color = "grey42", margin = margin(b = 6)),
    plot.margin        = margin(t = 8, b = 6, l = 8, r = 20)
  )

# ── Save ───────────────────────────────────────────────────────────────────────
ggsave(
  filename = output_path,
  plot     = p,
  width    = 6.3,
  height   = 4.0,
  dpi      = 300,
  bg       = "white"
)

message("Saved: ", output_path)
