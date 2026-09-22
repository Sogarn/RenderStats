# Load packages----
library(shiny)
library(bslib)
library(ggplot2)
library(tidyr)

# Gamba----
# Load gambler data 12.1
gamba_121_df <- read.csv("data/gamba-12.1.csv",
                        header = TRUE,
                        sep = ",")
# Convert gambler data to pivotlonger table and fix date format
gamba_121_df <- gamba_121_df %>% pivot_longer(
  cols = !(gambler),
  names_to = "date",
  names_transform = list(date = ~ as.Date(.x, format = "X%m.%d.%Y")),
  values_to = "gold",
  values_drop_na = TRUE,
)

# Load gambler data 12.0
gamba_120_df <- read.csv("data/gamba-12.0.csv",
                         header = TRUE,
                         sep = ",")
# Convert gambler data to pivotlonger table and fix date format
gamba_120_df <- gamba_120_df %>% pivot_longer(
  cols = !(gambler),
  names_to = "date",
  names_transform = list(date = ~ as.Date(.x, format = "X%m.%d.%Y")),
  values_to = "gold",
  values_drop_na = TRUE,
)

# Raid----
# Load raid data
raidpace_df <- read.csv("data/raidpace.csv",
                        header = TRUE,
                        sep = ",",
                        stringsAsFactors = FALSE)

# Convert raid data to pivotlonger table with temporary progression name
raidpace_df <- raidpace_df %>% pivot_longer(
  cols = !c(raid),
  names_to = "raid_week",
  values_to = "temp_progression",
  values_drop_na = TRUE,
  names_prefix = "week."
)

# New permanent column
raidpace_df$progression <- NA

# Convert all fractional entries to decimals  in new column
for (i in seq_len(nrow(raidpace_df))){
  raidpace_df[i, "progression"] =
    eval(parse(text = raidpace_df[i, "temp_progression"]))
}

# Delete temp column
raidpace_df$temp_progression <- NULL