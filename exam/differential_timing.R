################################################################################
# name: differential_timing.R
# author: scott cunningham (baylor)
# description: creates exam dataset for st. gallen
# last updated: july 4, 2025
################################################################################

set.seed(1234)
setwd("/Users/scunning/St-Gallen/exam")
getwd()

# Parameters
n_years <- 30  # 1995-2024
n_towns <- 40
n_firms_per_town <- 25
total_firms <- n_towns * n_firms_per_town  # 1000 firms

# Create the base dataset
stgallen <- expand.grid(
  year = 1995:2024,
  firm_id = 1:(n_towns * n_firms_per_town)
)

# Add town and treatment assignments
stgallen <- stgallen |>
  within({
    # Assign towns (40 towns, 25 firms each)
    town = 1 + (firm_id - 1) %/% n_firms_per_town
    
    # Assign treatment groups (10 towns per group)
    group = 1 + (town - 1) %/% 10
    
    # Treatment dates by group
    treat_date = c(2001, 2005, 2009, 2013)[group]
    
    # Time since treatment
    time_til = year - treat_date
    
    # Treatment status
    treat = (time_til >= 0)
    
    # Treatment effect coefficients by group
    te_coeff = c(15, 12, 9, 6)[group]
    
    # Base outcome (firm fixed effects + time trends)
    firms_fe = rnorm(length(unique(firm_id)), 0, 1)[firm_id]  # firm fixed effects
    year_fe = (year - 1995) * 0.5  # time trend
    
    # Error term
    e = rnorm(length(year), 0, 0.5)
    
    # Treatment effect (only when treated)
    treatment_effect = ifelse(treat, te_coeff * (time_til + 1), 0)
    
    # Final outcome
    y_d = 10 + firms_fe + year_fe + treatment_effect + e
  })

# Verify the structure
cat("Dataset structure:\n")
cat("Total observations:", nrow(stgallen), "\n")
cat("Years:", min(stgallen$year), "to", max(stgallen$year), "\n")
cat("Number of firms:", length(unique(stgallen$firm_id)), "\n")
cat("Number of towns:", length(unique(stgallen$town)), "\n")

# Verify ATT(g,t) pattern for a few key years
cat("\nExpected ATT(g,t) for key years:\n")
test_years <- c(2001, 2005, 2009, 2013)
for(g in 1:4) {
  treat_yr <- c(2001, 2005, 2009, 2013)[g]
  coeff <- c(15, 12, 9, 6)[g]
  cat("Group", g, "(treat_date =", treat_yr, "):\n")
  for(yr in test_years) {
    if(yr >= treat_yr) {
      expected_att <- coeff * (yr - treat_yr + 1)
      cat("  ATT(", treat_yr, ",", yr, ") =", expected_att, "\n")
    } else {
      cat("  ATT(", treat_yr, ",", yr, ") = 0 (pre-treatment)\n")
    }
  }
  cat("\n")
}


# Save the dataset
write.csv(stgallen, "stgallen_exam_data.csv", row.names = FALSE)
cat("\nDataset saved as 'stgallen_exam_data.csv'\n")

