
# Load Data Processing Script (Ensure the file exists before sourcing)
#Software Engineering Class

#Authors: Elias Ciudad, Van Nguyen, Amy Torres
#
#
# I am adding all the .R files to this

# Defining constants for modifications and copy/paste 



#Reading Spatial Data
library(ggplot2)
library(tidyverse)
library(usethis)
library(git2r)
library(stats)
library(readxl)
library(readr)
library(lubridate)
library(reshape2)
library(openxlsx)
library(sf)
library(janitor)
library(Matrix)
library(ggplot2)
library(dplyr)
library(lubridate)
library(readr)
library(tidyverse)
library(readxl)
library(writexl)

texas_spatial <- st_read("bin/R/confirmed_cases/dashboard/publishable_dashboard/Texas_County_Boundaries_Detailed.shp")   

source("bin/R/confirmed_cases/dashboard/publishable_dashboard/Covid-19.R")
source("bin/R/confirmed_cases/dashboard/publishable_dashboard/Flu.R")
source("bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV.R")
source("bin/R/confirmed_cases/dashboard/publishable_dashboard/TB.R")

# Confirmed Cases

covid <- read_excel("bin/R/confirmed_cases/dashboard/publishable_dashboard/Texas_COVID19_Cases_Cleaned.xlsx", sheet = 1) %>%
  rename(Cases = Total_Cases) %>%                      # Standardize column name for consistency
  mutate(Virus = "COVID-19",                          # Add identifier
         Month = as.character(Month))                 # Ensure Month is character for merging later

# Flu dataset
flu <- read_excel("bin/R/confirmed_cases/dashboard/publishable_dashboard/Flu_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Estimated_Cases) %>%
  mutate(Virus = "Flu",
         Month = as.character(Month))

# TB dataset
tb <- read_excel("bin/R/confirmed_cases/dashboard/publishable_dashboard/TB_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Total_Cases) %>%
  mutate(Virus = "TB",
         Month = as.character(Month))

# HIV dataset
hiv <- read_excel("bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Estimated_Cases) %>%
  mutate(Virus = "HIV",
         Month = as.character(Month))

# Combine all datasets into one
all_data <<- bind_rows(covid, flu, tb, hiv)
all_data$County <- trimws(all_data$County)                # Remove whitespace from county names

all_data <- all_data %>% 
  filter(Year %in% c(2020:2023)) %>%   # Filter to selected years only
  mutate(State = "Texas")

all_data$Month <- factor(all_data$Month,levels = month.abb[])
             


virus_colors <- c(
  "COVID-19" = "steelblue",
  "Flu" = "forestgreen",
  "TB" = "darkred",
  "HIV" = "darkmagenta"
)

# Spatial ----------------
texas_spatial <- texas_spatial %>%  
  st_transform(texas_spatial, crs = 4326) %>% 
  select(CNTY_NM,geometry) %>% 
  rename("County"=CNTY_NM) %>%  
  arrange((County)) %>% 
  mutate(State = "Texas")


rm(texas_confirmed_cases_2020)
rm(texas_confirmed_cases_2021)
rm(texas_confirmed_cases_2022)
rm(texas_confirmed_cases_2023)
rm(tb_raw)

#rm(tb_raw)
#rm(tb_raw)
#rm(texas_confirmed_cases_combined)

# UI Component

#choices = unique(merged_data$County)
#head(merged_data)
