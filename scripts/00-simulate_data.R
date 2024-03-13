#### Preamble ####
# Purpose: Get data the 2020 Cooperative Election Study (CES) and make table
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 10 March 2024
# Prerequisites: -

#### Workspace setup ####
library(tidyverse)

#### Simulate ####
set.seed(853)

num_obs <- 1000

us_political_preferences <- tibble(
  race = sample(0:4, size = num_obs, replace = TRUE),
  birthyr = sample(0:3, size = num_obs, replace = TRUE),
  gender = sample(0:1, size = num_obs, replace = TRUE),
  region = sample(0:3, size = num_obs, replace = TRUE),
  support_prob = ((race + gender + birthyr + region) / 14),
) |>
  mutate(
    supports_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    race = case_when(
      race == 0 ~ "White",
      race == 1 ~ "Black",
      race == 2 ~ "Hispanic",
      race == 3 ~ "Asian",
      race == 4 ~ "Other"
    ),
      birthyr = case_when(
      birthyr == 0 ~ "18-29",
      birthyr == 1 ~ "30-44",
      birthyr == 2 ~ "45-64",
      birthyr == 3 ~ "> 64"
    ),
      region = case_when(
      region == 0 ~ "Northeast",
      region == 1 ~ "Midwest",
      region == 2 ~ "South",
      region == 3 ~ "West"
    ),
    gender = if_else(gender == 0, "Male", "Female")
  ) |>
  select(-support_prob, supports_biden, gender, race, birthyr, region)

#### Save data ####
write.csv(us_political_preferences, "data/simulated_data/simulated_data.csv")


