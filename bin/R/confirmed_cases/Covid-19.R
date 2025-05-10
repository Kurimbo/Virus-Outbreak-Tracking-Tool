# Load necessary libraries
library(ggplot2)
library(dplyr)
library(lubridate)
library(readr)
library(tidyverse)
library(readxl)
library(writexl)

# Read in datasets (skip first two rows to remove extra headers)
texas_confirmed_cases_2020 <- read_xlsx(path = "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 1, skip = 2)
texas_confirmed_cases_2021 <- read_xlsx(path = "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 2, skip = 2)
texas_confirmed_cases_2022 <- read_xlsx(path = "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 3, skip = 2)
texas_confirmed_cases_2023 <- read_xlsx(path = "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 4, skip = 2)

# Ensure first column is correctly labeled as 'County'
colnames(texas_confirmed_cases_2020)[1] <- "County"
colnames(texas_confirmed_cases_2021)[1] <- "County"
colnames(texas_confirmed_cases_2022)[1] <- "County"
colnames(texas_confirmed_cases_2023)[1] <- "County"

# Function to fix column names (Handles both Excel serial dates and MM/DD/YYYY)
convert_to_dates <- function(columns) {
  numeric_columns <- suppressWarnings(as.numeric(columns))  # Attempt numeric conversion
  numeric_columns <- numeric_columns[!is.na(numeric_columns)]  # Remove NAs
  
  # Convert Excel serial numbers to proper dates
  converted_dates <- as.character(as.Date(numeric_columns, origin = "1899-12-30"))
  
  # Convert MM/DD/YYYY format to YYYY-MM-DD
  corrected_columns <- ifelse(grepl("^\\d{2}/\\d{2}/\\d{4}$", columns),
                              format(as.Date(columns, format = "%m/%d/%Y"), "%Y-%m-%d"),
                              converted_dates)
  
  return(corrected_columns)
}

# Convert column names for each dataset before merging
colnames(texas_confirmed_cases_2020)[-1] <- convert_to_dates(colnames(texas_confirmed_cases_2020)[-1])
colnames(texas_confirmed_cases_2021)[-1] <- convert_to_dates(colnames(texas_confirmed_cases_2021)[-1])
colnames(texas_confirmed_cases_2022)[-1] <- convert_to_dates(colnames(texas_confirmed_cases_2022)[-1])
colnames(texas_confirmed_cases_2023)[-1] <- convert_to_dates(colnames(texas_confirmed_cases_2023)[-1])

# Add a Year column to each dataset before merging
texas_confirmed_cases_2020 <- texas_confirmed_cases_2020 %>% mutate(Year = 2020)
texas_confirmed_cases_2021 <- texas_confirmed_cases_2021 %>% mutate(Year = 2021)
texas_confirmed_cases_2022 <- texas_confirmed_cases_2022 %>% mutate(Year = 2022)
texas_confirmed_cases_2023 <- texas_confirmed_cases_2023 %>% mutate(Year = 2023)

# Merge datasets into one
texas_confirmed_cases_combined <- bind_rows(
  texas_confirmed_cases_2020,
  texas_confirmed_cases_2021,
  texas_confirmed_cases_2022,
  texas_confirmed_cases_2023
)

# Pivot dataset from wide format to long format
texas_confirmed_cases_long <- texas_confirmed_cases_combined %>%
  pivot_longer(
    cols = -c(County, Year),  # Keep County & Year as identifiers
    names_to = "Date",
    values_to = "Cases"
  ) %>%
  mutate(
    Date = as.Date(Date),  # Ensure Date is in proper format
    Month = month(Date, label = TRUE)  # Extract Month
  ) %>%
  filter(!is.na(Date) & !is.na(Cases) & Cases > 0)  # Remove missing values

# **Final Check: Ensure all years are included**
if (!all(c(2020, 2021, 2022, 2023) %in% unique(texas_confirmed_cases_long$Year))) {
  cat("WARNING: Some years are missing from the dataset!\n")
}

# Aggregate: Total cases per county by month
covid_cases_per_county_by_month <- texas_confirmed_cases_long %>%
  group_by(County, Year, Month) %>%
  summarise(Total_Cases = sum(Cases, na.rm = TRUE), .groups = "drop") %>%
  arrange(County, Year, Month)

# Aggregate: Total cases per county by year
covid_cases_per_county_by_year <- texas_confirmed_cases_long %>%
  group_by(County, Year) %>%
  summarise(Total_Cases = sum(Cases, na.rm = TRUE), .groups = "drop") %>%
  arrange(County, Year)

# Aggregate: Total cases per year (overall)
covid_cases_per_year <- texas_confirmed_cases_long %>%
  group_by(Year) %>%
  summarise(Total_Cases = sum(Cases, na.rm = TRUE), .groups = "drop") %>%
  arrange(Year)

# Create output directory if it doesn’t exist
dir.create("Datasets/cleaned", recursive = TRUE, showWarnings = FALSE)

# Save cleaned data to an Excel file
write_xlsx(list(
  "Covid_Cases_Per_County_By_Month" = covid_cases_per_county_by_month,
  "Covid_Cases_Per_County_By_Year" = covid_cases_per_county_by_year,
  "Covid_Total_Cases_Per_Year" = covid_cases_per_year
), "Datasets/cleaned/Texas_COVID19_Cases_Cleaned.xlsx")


# **Final Check: Print unique years to confirm all years are included**
print(unique(covid_cases_per_county_by_month$Year))  # Should include 2022 and 2023
print(unique(covid_cases_per_county_by_year$Year))  # Should include 2022 and 2023
print(unique(covid_cases_per_year$Year))  # Should include 2022 and 2023

# Open the cleaned data in RStudio
#View(covid_cases_per_county_by_month)
#View(covid_cases_per_county_by_year)
#View(covid_cases_per_year)
