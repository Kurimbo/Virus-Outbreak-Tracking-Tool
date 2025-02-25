# Software Engineering: VOTS Virus Outbreak Tracking System
# Authors: Van Nguyen, Elias Ciudad, Amy Torres
# Function of this code is data cleaning for fatality cases for COVID 19 in Bexar County
#

# LIBRARIES #####
source("bin/R/fatality_cases/libraries.R")
#comment
# READING DATA ####
# Read all four sheets into separate data frames
texas_fatality_cases_2020 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 Fatality Count Data by County.xlsx", sheet = 1, skip = 2)
texas_fatality_cases_2021 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 Fatality Count Data by County.xlsx", sheet = 2, skip = 2)
texas_fatality_cases_2022 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 Fatality Count Data by County.xlsx", sheet = 3, skip = 2)
texas_fatality_cases_2023 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 Fatality Count Data by County.xlsx", sheet = 4, skip = 2)

colnames(texas_fatality_cases_2020) #checking column names
head(texas_fatality_cases_2020) #viewing output 


# Store datasets in a list
texas_fatality_cases_combined <- list(texas_fatality_cases_2020,
                                      texas_fatality_cases_2021,
                                      texas_fatality_cases_2022,
                                      texas_fatality_cases_2023)

length(texas_fatality_cases_combined) #checking output of '4' to see if there is any duplicates

#Ensure "County" is the First Column
for (i in seq_along(texas_fatality_cases_combined)) {
  colnames(texas_fatality_cases_combined[[i]])[1] <- "County"
}

#Check if "County" exists in all datasets
for (i in seq_along(texas_fatality_cases_combined)) {
  print(paste("Dataset", i, "Has 'County':", "County" %in% colnames(texas_fatality_cases_combined[[i]])))
}

#Removing "DISCLAIMER: All data are provisional..."
for (i in seq_along(texas_fatality_cases_combined)) {
  texas_fatality_cases_combined[[i]] <- texas_fatality_cases_combined[[i]] %>%
    filter(!County %in% c("DISCLAIMER", "County", NA))
}

# Merge all datasets
texas_fatality_cases_cleaned <- bind_rows(texas_fatality_cases_combined)

#Checking if merging was successful
print(dim(texas_fatality_cases_cleaned))  # Should return number of rows and columns

# Extract Only Bexar County
bexar_fatalities <- texas_fatality_cases_cleaned %>%
  filter(County == "Bexar")

# Convert wide format (dates as columns) to long format (dates as rows)
bexar_fatalities_long <- bexar_fatalities %>%
  pivot_longer(
    cols = -County,  # Exclude County column from transformation
    names_to = "Date",  # Store column names as Date
    values_to = "fatality_cases_per_day"  # Store values in a new column
  )

# Convert date from character to Date format (assuming MM/DD/YYYY format in original file)
bexar_fatalities_long <- bexar_fatalities_long %>%
  mutate(Date = mdy(Date))

# Extract Year, Month, and Week
bexar_fatalities_long <- bexar_fatalities_long %>%
  mutate(year = year(Date),
         month = month(Date),
         week = week(Date))

# Save the processed data to a CSV file
write.csv(bexar_fatalities_long, "Datasets/processed/texas_fatality_cases_new.csv", row.names = FALSE)


#Check if Bexar County exists
print(nrow(filter(texas_fatality_cases_cleaned, County == "Bexar")))

# Check final output
print(head(bexar_fatalities_long))
print(dim(bexar_fatalities))  # Should show number of rows and columns
print(colnames(bexar_fatalities))  # Should have correct column names

