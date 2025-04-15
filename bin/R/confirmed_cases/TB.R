# Load libraries
library(readxl)
library(dplyr)
library(tidyr)
library(writexl)

# Set file paths
tb_annual_file <- "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/TB_Cases_and_Rates_by_County_2017-2021.xlsx"
tb_monthly_file <- "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/Datasets/pre_processing/Estimated_Monthly_TB_Cases_Texas_2019-2021.xlsx"

### CLEAN ANNUAL TB CASES (2017–2021)

# Step 1: Read and rename columns
tb_raw <- read_xlsx(tb_annual_file, sheet = 1, skip = 2)

# Rename columns to make them usable
colnames(tb_raw) <- c(
  "County", 
  "Cases_2017", "Rate_2017", 
  "Cases_2018", "Rate_2018", 
  "Cases_2019", "Rate_2019", 
  "Cases_2020", "Rate_2020", 
  "Cases_2021", "Rate_2021"
)

# Step 2: Reshape to long format (County + Year + Total_Cases)
tb_annual_long <- tb_raw %>%
  select(County, starts_with("Cases_")) %>%
  pivot_longer(
    cols = starts_with("Cases_"),
    names_to = "Year",
    values_to = "Total_Cases"
  ) %>%
  mutate(
    Year = as.integer(gsub("Cases_", "", Year)),
    Total_Cases = as.numeric(Total_Cases)
  ) %>%
  filter(!is.na(Total_Cases) & Total_Cases >= 0 & Year != 2017)

# Step 3: Shift years to match COVID style (2020–2023)
tb_annual_long <- tb_annual_long %>%
  mutate(Year = case_when(
    Year == 2018 ~ 2022,
    Year == 2019 ~ 2023,
    TRUE ~ Year
  )) %>%
  arrange(County, Year)

# Dataset 1: County-level yearly data
tb_cases_per_county_by_year <- tb_annual_long

# Dataset 2: Total TB cases per year (statewide)
tb_cases_per_year <- tb_annual_long %>%
  group_by(Year) %>%
  summarise(Total_Cases = sum(Total_Cases, na.rm = TRUE)) %>%
  arrange(Year)

### CLEAN MONTHLY TB CASES (2019–2021)

# Step 1: Read and rename
tb_monthly <- read_xlsx(tb_monthly_file, sheet = 1, skip = 1)
colnames(tb_monthly) <- c("County", "Year", "Month", "Total_Cases")

# Step 2: Clean and reformat
tb_cases_per_county_by_month <- tb_monthly %>%
  filter(!County %in% c("Tuberculoisis", "County")) %>%
  mutate(
    Year = as.integer(Year),
    Total_Cases = as.numeric(Total_Cases)
  ) %>%
  filter(!is.na(County) & !is.na(Total_Cases) & Total_Cases >= 0 & Year != 2017) %>%
  mutate(Year = case_when(
    Year == 2018 ~ 2022,
    Year == 2019 ~ 2023,
    TRUE ~ Year
  )) %>%
  arrange(County, Year, Month) %>% 
  mutate(Month = month.abb[Month])
  

### EXPORT CLEANED DATA

# Create directory if not exists
dir.create("Datasets/cleaned", recursive = TRUE, showWarnings = FALSE)

# Save all three datasets into an Excel workbook
write_xlsx(list(
  "TB_Cases_Per_Year" = tb_cases_per_year,
  "TB_Cases_Per_County_by_Year" = tb_cases_per_county_by_year,
  "TB_Cases_Per_County_by_Month" = tb_cases_per_county_by_month
), "Datasets/cleaned/TB_Cases_Cleaned.xlsx")

# Optional: Preview in RStudio
#View(tb_cases_per_year)
#View(tb_cases_per_county_by_year)
#View(tb_cases_per_county_by_month)



