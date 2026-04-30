# Load packages----
library(shiny)
library(bslib)
library(ggplot2)
library(tidyr)

# Load data
raidpace_df <- read.csv("data/raidpace.csv",
                        header = TRUE,
                        sep = ",",
                        stringsAsFactors = FALSE)

# Convert to pivotlonger table with temporary progression name
raidpace_df <- raidpace_df %>% pivot_longer(
  cols = !raid,
  names_to = "raid_week",
  values_to = "temp_progression",
  values_drop_na = TRUE
)

# New permanent column
raidpace_df$progression <- NA

# Convert all fractional entries to decimals
for (i in seq_len(nrow(raidpace_df))){
  raidpace_df[i, "progression"] =
    eval(parse(text = raidpace_df[i, "temp_progression"]))
}

# Delete temp column
raidpace_df$temp_progression <- NULL
