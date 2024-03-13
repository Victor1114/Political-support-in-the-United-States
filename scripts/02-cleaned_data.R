#### Preamble ####
# Purpose: Cleaning the data of 2020 Cooperative Election Study (CES) and make table
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 10 March 2024
# Prerequisites: clean the data

####Workspace setup####
library(readr)
library(dplyr)
library(janitor)

#### Clean data ####
ces2020 <- read_csv("data/raw_data/raw_data.csv")

ces2020 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    gender = if_else(gender == 1, "Male", "Female"),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race >= 5 ~ "Other"
    ),
    race = factor(
      race,
      levels = c(
        "White",
        "Black",
        "Hispanic",
        "Asian",
        "Other"
      )
    ),
    region = case_when(
      region == 1 ~ "Northeast",
      region == 2 ~ "Midwest",
      region == 3 ~ "South",
      region == 4 ~ "West"),
    region = factor(
      region,
      levels = c(
        "Northeast",
        "Midwest",
        "South",
        "West"
      )
    ),
    birthyr = case_when(
      birthyr >=1991 ~ "18-29",
      birthyr >=1976 ~ "30-44",
      birthyr >=1956 ~ "45-64",
      birthyr < 1956 ~ "> 64"
    ),
    birthyr = factor(
      birthyr,
      levels = c(
        "18-29",
        "30-44",
        "45-64",
        "> 64"
      )
    ),
  ) |>
  select(voted_for, gender, race, birthyr, region)

#### Save data ####
write_csv(ces2020, "data/analysis_data/analysis_data.csv")
