library(contdid)
library(haven)
library(dplyr)
library(ggplot2)

# Set working directory (R equivalent of your Stata cd command)
setwd("/Users/scunning/collegio-carlo-alberto/labs/abortion clinic")

# Load and prep data
df <- read_dta("abortion_jhr.dta") %>%
  mutate(
    travel_distance = travel_distance * 100,  # Convert to miles
    id = fips_code,
    time_period = year,
    Y = aborttotal
  )

# Keep only the transition periods (like your Stata code)
df <- df %>% filter(time_period %in% c(2013, 2014))

# Create treatment assignment (mimicking your Stata logic)
epsilon <- 10  # Your threshold

travel_wide <- df %>%
  select(id, time_period, travel_distance) %>%
  pivot_wider(
    names_from = time_period, 
    values_from = travel_distance,
    names_prefix = "travel_"
  ) %>%
  filter(!is.na(travel_2013) & !is.na(travel_2014)) %>%
  mutate(
    dose_change = travel_2014 - travel_2013,  # This matches your "dose"
    # Treatment assignment based on your logic
    treated = dose_change > epsilon,
    D = ifelse(treated, dose_change, 0),      # Dose = 0 for controls
    G = ifelse(treated, 2014, 0)             # Treatment timing
  ) %>%
  select(id, D, G)

# Check the treatment assignment
cat("Treatment assignment summary:\n")
table(travel_wide$G, useNA = "ifany")
cat("Dose summary by treatment group:\n")
travel_wide %>%
  group_by(G) %>%
  summarise(
    n_units = n(),
    min_dose = min(D),
    max_dose = max(D),
    mean_dose = mean(D)
  ) %>%
  print()

# Merge back to panel data
df <- df %>%
  left_join(travel_wide, by = "id")

# Run continuous DiD
cd_result <- cont_did(
  yname = "Y",
  tname = "time_period",
  idname = "id",
  dname = "D",
  gname = "G", 
  data = df,
  target_parameter = "level",
  aggregation = "dose",
  treatment_type = "continuous",
  control_group = "notyettreated"
)

summary(cd_result)

# Plot the dose-response curve
ggcont_did(cd_result, type = "att") +
  labs(
    title = "ATT(d): Effect by Distance Increase",
    x = "Distance Increase (miles)", 
    y = "Effect on Abortion Count"
  )