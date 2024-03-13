#### Preamble ####
# Purpose: Get data the 2020 Cooperative Election Study (CES) and make table
# Author: Yuchen Chen
# Email: victorchen.chen@mail.utoronto.ca
# Date: 10 March 2024
# Prerequisites: download data


#### Workspace setup ####
library(dataverse)
library(dplyr)

#### Download data ####
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, gender, race, birthyr, region)

#### Save data ####
write_csv(ces2020, "data/raw_data/raw_data.csv")

