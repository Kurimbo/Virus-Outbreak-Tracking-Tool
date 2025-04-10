library(readxl)
library(dplyr)
library(writexl)

# === Correct File Paths ===
hiv_yearly_file <- "Datasets/cleaned/HIV_Cases_Cleaned_COVID_Format.xlsx"
hiv_monthly_file <- "Datasets/pre_processing/HIV_Monthly_Data_Simulated.xlsx"

# === Load Yearly Data ===
hiv_cases_per_year <- read_xlsx(hiv_yearly_file, sheet = "HIV_Cases_Per_Year")
hiv_cases_per_county_by_year <- read_xlsx(hiv_yearly_file, sheet = "HIV_Cases_Per_County_by_Year")

# === Load Monthly Data ===
hiv_cases_per_county_by_month <- read_xlsx(hiv_monthly_file)

# === Combine and Save to New File ===
write_xlsx(list(
  "HIV_Cases_Per_County_by_Year" = hiv_cases_per_county_by_year,
  "HIV_Cases_Per_Year" = hiv_cases_per_year,
  "HIV_Cases_Per_County_by_Month" = hiv_cases_per_county_by_month
), path = "Datasets/cleaned/HIV_Cases_Cleaned.xlsx")

# View in RStudio if desired
View(hiv_cases_per_year)
View(hiv_cases_per_county_by_year)
View(hiv_cases_per_county_by_month)
  
