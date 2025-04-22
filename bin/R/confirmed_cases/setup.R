library(shiny)
library(leaflet)
library(sf)
library(dplyr)
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
library(plotly)

# Load Data Processing Script (Ensure the file exists before sourcing)
#Software Engineering Class

#Authors: Elias Ciudad, Van Nguyen, Amy Torres
#
#
# I am adding all the .R files to this

# Defining constants for modifications and copy/paste 



#Reading Spatial Data
texas_spatial <- st_read("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/spatial/Texas_counties/Texas_County_Boundaries_Detailed.shp")   

source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/Covid-19.R")
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/Flu.R")
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/HIV.R")
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/TB.R")

# Confirmed Cases

covid <- read_excel("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/cleaned/Texas_COVID19_Cases_Cleaned.xlsx", sheet = 1) %>%
  rename(Cases = Total_Cases) %>%                      # Standardize column name for consistency
  mutate(Virus = "COVID-19",                          # Add identifier
         Month = as.character(Month))                 # Ensure Month is character for merging later

# Flu dataset
flu <- read_excel("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/cleaned/Flu_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Estimated_Cases) %>%
  mutate(Virus = "Flu",
         Month = as.character(Month))

# TB dataset
tb <- read_excel("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/cleaned/TB_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Total_Cases) %>%
  mutate(Virus = "TB",
         Month = as.character(Month))

# HIV dataset
hiv <- read_excel("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/cleaned/HIV_Cases_Cleaned.xlsx", sheet = 3) %>%
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

# Data for second UI tab

read_virus_data <- function(file_name, virus_name, sheet_num = 1) {
  data <- read_excel(file_name, sheet = sheet_num)
  
  # Rename Total_Cases to Cases if needed
  if ("Total_Cases" %in% colnames(data)) {
    data <- data %>% rename(Cases = Total_Cases)
  }
  
  data <- data %>% mutate(Virus = virus_name)
  
  # HIV-specific: keep only 2018–2021 and remap 2018 → 2022, 2019 → 2023
  if (virus_name == "HIV") {
    data <- data %>%
      filter(Year %in% c(2018, 2019, 2020, 2021)) %>%
      mutate(Year = as.numeric(Year)) %>%
      mutate(Year = case_when(
        Year == 2018 ~ 2022,
        Year == 2019 ~ 2023,
        TRUE ~ Year
      ))
  }
  
  return(data)
}

# Read and combine datasets
line_data <- bind_rows(
  read_virus_data("Datasets/cleaned/Texas_COVID19_Cases_Cleaned.xlsx", "COVID-19", sheet_num = 2),
  read_virus_data("Datasets/cleaned/Flu_Cases_Cleaned.xlsx", "Flu", sheet_num = 1),
  read_virus_data("Datasets/cleaned/HIV_Cases_Cleaned.xlsx", "HIV", sheet_num = 1),
  read_virus_data("Datasets/cleaned/TB_Cases_Cleaned.xlsx", "TB", sheet_num = 2)
)

# Standardize columns
line_data <- line_data[c("County", "Year", "Cases", "Virus")] %>%
  mutate(
    Year = as.numeric(Year),
    Cases = as.numeric(Cases)
  )

#choices = unique(merged_data$County)
#head(merged_data)
