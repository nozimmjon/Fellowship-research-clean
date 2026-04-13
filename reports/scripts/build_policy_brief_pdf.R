# build_policy_brief_pdf.R
# Extracts inline values for the standalone typst policy brief and pre-renders the expansion chart.
# Run from project root: Rscript reports/scripts/build_policy_brief_pdf.R

source("R/91_manuscript_helpers.R")
load_main_manuscript_context(".")

module_c_summary <- read_csv_safe(file.path("outputs", "tables", "module_c_mechanism_summary.csv"))
transition_summary <- read_csv_safe(file.path("outputs", "tables", "tier_a_transition_summary.csv"))
hbs_support_context <- read_csv_safe(file.path("outputs", "tables", "hbs_household_support_context.csv"))
rank_change_tests <- read_csv_safe(file.path("outputs", "tables", "empirical_rank_rank_change_tests.csv"))
expansion_panel <- utils::read.csv(file.path("data", "processed", "uzbekistan_expansion_panel.csv"))
lits_harmonized <- read_csv_safe(file.path("data", "processed", "lits_harmonized.csv"))

mech_est <- function(outcome, group = "overall", group_value = "all") {
  rows <- module_c_summary[
    module_c_summary$outcome == outcome &
      module_c_summary$group == group &
      module_c_summary$group_value == group_value, ]
  as.numeric(rows$estimate[1])
}

hbs_val <- function(metric) as.numeric(hbs_support_context$national[hbs_support_context$metric == metric][1])

rc <- function(comp, col) {
  rows <- rank_change_tests[rank_change_tests$comparison == comp, ]
  rows[[col]][1]
}

tv <- function(wy, pl, ol) {
  rows <- transition_summary[
    transition_summary$wave_year == wy &
      transition_summary$parent_ed_level == pl &
      transition_summary$own_ed_level == ol, ]
  rows$share[1]
}

fmt3 <- function(x) sprintf("%.3f", as.numeric(x))
fmtp <- function(x) sprintf("%.1f%%", 100 * as.numeric(x))

# ── Extract values ──
vals <- data.frame(
  key = c(
    "persistence_2010", "persistence_2016", "persistence_2022",
    "change_2010_2016", "change_2010_2016_p",
    "change_2016_2022", "change_2016_2022_p",
    "stopped_covid", "any_remote_challenge",
    "support_mother", "support_father",
    "challenge_internet", "challenge_device",
    "tertiary_persistence",
    "edu_spending", "tutoring", "remittances", "internet_access",
    "sample_n"
  ),
  value = c(
    fmt3(metric_est("rank_rank_slope", 2010)),
    fmt3(metric_est("rank_rank_slope", 2016)),
    fmt3(metric_est("rank_rank_slope", 2022)),
    fmt3(rc("2010_to_2016", "estimate")),
    fmt3(rc("2010_to_2016", "p.value")),
    fmt3(rc("2016_to_2022", "estimate")),
    fmt3(rc("2016_to_2022", "p.value")),
    fmtp(mech_est("education_stopped_covid")),
    fmtp(mech_est("any_remote_challenge")),
    fmtp(mech_est("support_mother")),
    fmtp(mech_est("support_father")),
    fmtp(mech_est("challenge_internet")),
    fmtp(mech_est("challenge_device")),
    fmtp(tv(2022, "tertiary", "tertiary")),
    fmtp(hbs_val("education_spending_positive")),
    fmtp(hbs_val("has_tutoring")),
    fmtp(hbs_val("has_remittance_hh")),
    fmtp(hbs_val("internet_access_hh")),
    as.character(nrow(lits_harmonized))
  ),
  stringsAsFactors = FALSE
)
write.csv(vals, "reports/brief_values.csv", row.names = FALSE)
message("Wrote reports/brief_values.csv")

# ── Pre-render expansion chart ──
library(ggplot2)
library(patchwork)

nat_agg <- aggregate(
  students_total_per_1000_youth_20_24 ~ academic_year_start_for_merge,
  data = expansion_panel, FUN = mean
)
names(nat_agg) <- c("year", "students")
nat_agg$year_label <- paste0(nat_agg$year, "/", substr(nat_agg$year + 1, 3, 4))

p_a <- ggplot(nat_agg, aes(x = factor(year_label, levels = year_label), y = students)) +
  geom_col(fill = "#1b6ca8", width = 0.55, alpha = 0.85) +
  geom_text(aes(label = round(students)), vjust = -0.3, size = 2.8, color = "grey30") +
  labs(title = "A. National average: students per 1,000 youth (20\u201324)", x = NULL, y = NULL) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
  theme_minimal(base_size = 9) +
  theme(
    panel.grid.major.x = element_blank(), panel.grid.minor = element_blank(),
    plot.title = element_text(size = 8.5, face = "bold"),
    plot.margin = margin(t = 2, b = 0, l = 5, r = 5)
  )

exp_wide <- reshape(
  expansion_panel[expansion_panel$academic_year_start_for_merge %in% c(2020, 2024),
    c("admin_region", "academic_year_start_for_merge", "students_total_per_1000_youth_20_24", "high_expansion_region")],
  idvar = "admin_region", timevar = "academic_year_start_for_merge", direction = "wide"
)
names(exp_wide) <- c("region", "y2020", "high_2020", "y2024", "high_2024")
exp_wide$growth <- round(exp_wide$y2024 / exp_wide$y2020, 1)
exp_wide$high_exp <- factor(ifelse(exp_wide$high_2024 == 1, "High expansion", "Low expansion"),
  levels = c("High expansion", "Low expansion"))
tashkent_row <- exp_wide[exp_wide$region == "Tashkent city", ]
exp_plot <- exp_wide[exp_wide$region != "Tashkent city", ]
exp_plot$region_short <- gsub(" region$| republic$", "", exp_plot$region)
exp_plot$region_short <- gsub("Republic of ", "", exp_plot$region_short)
exp_plot <- exp_plot[order(exp_plot$growth), ]
exp_plot$region_short <- factor(exp_plot$region_short, levels = exp_plot$region_short)

p_b <- ggplot(exp_plot) +
  geom_segment(aes(x = y2020, xend = y2024, y = region_short, yend = region_short), color = "grey70", linewidth = 0.5) +
  geom_point(aes(x = y2020, y = region_short), color = "grey50", size = 2) +
  geom_point(aes(x = y2024, y = region_short, color = high_exp), size = 2) +
  geom_text(aes(x = y2024 + 15, y = region_short, label = paste0(growth, "x")), size = 2.5, hjust = 0, color = "grey30") +
  scale_color_manual(values = c("High expansion" = "#1b6ca8", "Low expansion" = "#c56b00"), name = NULL) +
  labs(
    title = "B. Regional growth: 2020/21 to 2024/25 (excl. Tashkent city)",
    subtitle = paste0("Tashkent city: ", round(tashkent_row$y2020), " \u2192 ", round(tashkent_row$y2024), " (", tashkent_row$growth, "x)"),
    x = "Students per 1,000 youth (20\u201324)", y = NULL
  ) +
  theme_minimal(base_size = 9) +
  theme(
    panel.grid.major.y = element_blank(), panel.grid.minor = element_blank(),
    legend.position = "bottom", legend.margin = margin(t = -5),
    legend.text = element_text(size = 7.5),
    plot.title = element_text(size = 8.5, face = "bold"),
    plot.subtitle = element_text(size = 7.5, color = "grey40"),
    plot.margin = margin(t = 0, b = 2, l = 5, r = 12)
  )

ggsave("outputs/figures/policy_brief_expansion.png", p_a / p_b + plot_layout(heights = c(0.7, 1.5)),
       width = 6.3, height = 4, dpi = 300, bg = "white")
message("Wrote outputs/figures/policy_brief_expansion.png")
