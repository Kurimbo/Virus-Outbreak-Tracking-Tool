
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

# === Load Flu Monthly Data ===
flu_monthly_file <- "Datasets/pre_processing/Simulated_Flu_Cases_By_County_Month.xlsx"
flu_monthly <- read_xlsx(path = flu_monthly_file)


# === Keep only years 2018–2021, and shift 2018 for 2022, and 2019 for 2023 ===
flu_monthly_cleaned <- flu_monthly %>%
  filter(Year %in% c(2018, 2019, 2020, 2021)) %>%
  mutate(Year = case_when(
    Year == 2018 ~ 2022,
    Year == 2019 ~ 2023,
    TRUE ~ Year
  )) %>%
  arrange(County, Year, Month)

# === Cases Per County by Month (same format, just cleaned) ===
flu_cases_per_county_by_month <- flu_monthly_cleaned %>% 
  mutate(Month = month.abb[Month])

# === Cases Per County by Year ===
flu_cases_per_county_by_year <- flu_monthly_cleaned %>%
  group_by(County, Year) %>%
  summarise(Cases = sum(Estimated_Cases), .groups = "drop")


# === Total Cases Per Year ===
flu_cases_per_year <- flu_cases_per_county_by_year %>%
  group_by(Year) %>%
  summarise(Total_Cases = sum(Cases), .groups = "drop")

# === Save to Excel ===
write_xlsx(list(
  "Flu_Cases_Per_County_by_Year" = flu_cases_per_county_by_year,
  "Flu_Cases_Per_Year" = flu_cases_per_year,
  "Flu_Cases_Per_County_by_Month" = flu_cases_per_county_by_month
), path = "Datasets/cleaned/Flu_Cases_Cleaned.xlsx")




# Optional: View results
#View(flu_cases_per_county_by_year)
#View(flu_cases_per_year)
#View(flu_cases_per_county_by_month)
