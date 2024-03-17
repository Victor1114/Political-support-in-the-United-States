#### Preamble ####
# Purpose: Creat a model of 2020 Cooperative Election Study (CES)
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 10 March 2024
# Prerequisites: -


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
political_preferences <-
  stan_glm(
    factor(voted_for) ~ gender + race + age + region,
    data = ces2020,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept =
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

#### Save model ####
saveRDS(
  political_preferences,
  file = "models/first_model.rds"
)


