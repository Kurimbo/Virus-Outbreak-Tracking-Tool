library(readxl)
library(dplyr)
library(writexl)

# === Correct File Paths ===
hiv_yearly_file <- "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV_Cases_Cleaned.xlsx"#_COVID_Format.xlsx"
hiv_monthly_file <- "D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/dashboard/publishable_dashboard/HIV_Monthly_Data_Simulated.xlsx"

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
  
