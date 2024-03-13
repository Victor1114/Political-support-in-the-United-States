#### Preamble ####
# Purpose: Testst data the 2020 Cooperative Election Study (CES)
# Author: Yuchen Chen
# Contact: victorchen.chen@mail.utoronto.ca
# License: MIT
# Date: 10 March 2024
# Prerequisites: -

#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Test data ####

simulated_data <- read.csv("data/simulated_data/simulated_data.csv")

test_that("Check class",{
  expect_type(simulated_data$race, "character")
  expect_type(simulated_data$gender, "character")
  expect_type(simulated_data$region, "character")
  expect_type(simulated_data$supports_biden, "character")
})

test_that("Check number of observations is correct",{
  expect_equal(nrow(simulated_data), 1000)
})

test_that("Check ages",{
  expect_contains(simulated_data$birthyr, c("18-29","30-44","45-64","> 64"))
})