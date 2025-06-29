# equivalence.R
# author: Scott Cunningham
# description: OLS and Manual equivalence in R

library(dplyr)
library(tidyr)
library(lmtest)
library(sandwich)
library(fixest)

# Load dataset
castle <- haven::read_dta("https://github.com/scunning1975/mixtape/raw/master/castle.dta")

# Filter data
castle_filtered <- castle %>%
  filter(!(effyear %in% c(2005, 2007, 2008, 2009))) %>%
  mutate(post = ifelse(year >= 2006, 1, 0),
         treat = ifelse(effyear == 2006, 1, 0)) %>%
  filter(year %in% c(2005, 2006))

# Manual DID calculation
y11 <- mean(castle_filtered$l_homicide[castle_filtered$post == 1 & castle_filtered$treat == 1], na.rm = TRUE)
y10 <- mean(castle_filtered$l_homicide[castle_filtered$post == 0 & castle_filtered$treat == 1], na.rm = TRUE)
y01 <- mean(castle_filtered$l_homicide[castle_filtered$post == 1 & castle_filtered$treat == 0], na.rm = TRUE)
y00 <- mean(castle_filtered$l_homicide[castle_filtered$post == 0 & castle_filtered$treat == 0], na.rm = TRUE)

DID <- (y11 - y10) - (y01 - y00)
cat("Manual DID estimate:", DID, "\n")

# Example 1: OLS regression with interaction
ols_model <- lm(l_homicide ~ post * treat, data = castle_filtered)
coeftest(ols_model, vcov = vcovCL, cluster = ~sid)

# Example 2: Two-way fixed effects (state and year fixed effects)
fe_model <- feols(l_homicide ~ post:treat | sid + year, cluster = ~sid, data = castle_filtered)
summary(fe_model)

# Example 3: Long difference regression
castle_wide <- castle_filtered %>%
  select(sid, year, l_homicide, treat) %>%
  pivot_wider(names_from = year, values_from = l_homicide, names_prefix = "homicide_") %>%
  mutate(diff = homicide_2006 - homicide_2005)

long_diff_model <- lm(diff ~ treat, data = castle_wide)
coeftest(long_diff_model, vcov = vcovCL, cluster = ~sid)


# Population weights

# Example 1: Weighted OLS regression

# Example 2: Two-way fixed effects with population weights

# Example 3: Weighted long difference regression

