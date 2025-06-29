# equivalence.R
# author: Scott Cunningham
# description: OLS and Manual are the same

library(haven)
library(dplyr)
library(tidyr)
library(fixest)

# Load dataset
castle <- read_dta("https://github.com/scunning1975/mixtape/raw/master/castle.dta")

# Clean and prep
castle <- castle %>%
  filter(!(effyear %in% c(2005, 2007, 2008, 2009))) %>%
  mutate(
    post = ifelse(year >= 2006, 1, 0),
    treat = ifelse(effyear == 2006, 1, 0)
  ) %>%
  filter(year %in% c(2005, 2006))

# Manual DiD Calculation
manual <- castle %>%
  group_by(treat, post) %>%
  summarise(y = mean(l_homicide, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = c(post), values_from = y, names_prefix = "post_") %>%
  mutate(
    did = (post_1 - post_0)[treat == 1] - (post_1 - post_0)[treat == 0]
  )

cat("Manual DiD estimate:\n")
print(manual$did[1])

# Example 1: OLS regression with interaction
mod1 <- feols(l_homicide ~ post * treat, cluster = ~sid, data = castle)
summary(mod1)

# Example 2: TWFE (state and year FE)
mod2 <- feols(l_homicide ~ i(year) + post * treat | sid, cluster = ~sid, data = castle)
summary(mod2)

# Example 3: Long difference regression
long_diff <- castle %>%
  select(sid, year, l_homicide, treat) %>%
  pivot_wider(names_from = year, values_from = l_homicide, names_prefix = "y") %>%
  mutate(diff = y2006 - y2005)

mod3 <- feols(diff ~ treat, cluster = ~sid, data = long_diff)
summary(mod3)

# Weighted models

# OLS with weights
mod1w <- feols(l_homicide ~ post * treat, cluster = ~sid, weights = ~popwt, data = castle)
summary(mod1w)

# TWFE with weights
mod2w <- feols(l_homicide ~ i(year) + post * treat | sid, cluster = ~sid, weights = ~popwt, data = castle)
summary(mod2w)

# Weighted long difference
long_diff_w <- castle %>%
  select(sid, year, l_homicide, popwt, treat) %>%
  pivot_wider(names_from = year, values_from = c(l_homicide, popwt)) %>%
  mutate(diff = l_homicide_2006 - l_homicide_2005)

mod3w <- feols(diff ~ treat, cluster = ~sid, weights = ~popwt_2005, data = long_diff_w)
summary(mod3w)
mod3w <- feols(diff ~ treat, cluster = ~sid, weights = ~popwt_2005, data = long_diff_w)
summary(mod3w)