
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
# === Correct File Paths ===
hiv_yearly_file <- "bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV_Cases_Cleaned.xlsx"#_COVID_Format.xlsx"
hiv_monthly_file <- "bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV_Monthly_Data_Simulated.xlsx"

# === Load Yearly Data ===
hiv_cases_per_year <- read_xlsx(path = hiv_yearly_file, sheet = "HIV_Cases_Per_Year")
hiv_cases_per_county_by_year <- read_xlsx(path = hiv_yearly_file, sheet = "HIV_Cases_Per_County_by_Year")

# === Load Monthly Data ===
hiv_cases_per_county_by_month <- read_xlsx(hiv_monthly_file)

hiv_cases_per_county_by_month <- hiv_cases_per_county_by_month%>% 
  mutate(Month = month.abb[Month])
# === Combine and Save to New File ===
write_xlsx(list(
  "HIV_Cases_Per_County_by_Year" = hiv_cases_per_county_by_year,
  "HIV_Cases_Per_Year" = hiv_cases_per_year,
  "HIV_Cases_Per_County_by_Month" = hiv_cases_per_county_by_month
), path = "Datasets/cleaned/HIV_Cases_Cleaned.xlsx")

# View in RStudio if desired
#View(hiv_cases_per_year)
#View(hiv_cases_per_county_by_year)
#View(hiv_cases_per_county_by_month)
  
