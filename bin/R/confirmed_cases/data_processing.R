#Software Engineering Class
#
#Authors: Elias Ciudad, Van Nguyen, Amy Torres
#
#
#Paths ####

# Libraries -----------
source("bin/R/confirmed_cases/libraries.R")
# Reading Data ---------
texas_confirmed_cases_2020 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 1)
texas_confirmed_cases_2021 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 2)
texas_confirmed_cases_2022 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 3)
texas_confirmed_cases_2023 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 4)
texas_confirmed_cases_combined <- list(texas_confirmed_cases_2020,texas_confirmed_cases_2021,texas_confirmed_cases_2022,texas_confirmed_cases_2023) 
texas_confirmed_cases_combined <- reduce(texas_confirmed_cases_combined,full_join, by = "County") #reduce the list to its components and join on the basis of County (like SQL)
texas_spatial <- st_read("Datasets/spatial/Texas_counties/Texas_County_Boundaries_Detailed.shp")   
  
#str(texas_confirmed_cases_combined)
#is.na(any(col(texas_confirmed_cases_combined))) #

# Confirmed Cases -------
## Data Cleaning ----------
#is.na(any(col(texas_confirmed_cases_combined))) #no missing data, no more action required
#str(texas_confirmed_cases_combined) #look at dataset structure


test<- texas_confirmed_cases_combined %>% 
  melt(id.vars = "County") %>% 
  slice(1:169164) %>% # get 2020-2021 rows only
  mutate(variable = as.numeric(as.character(variable))) %>% 
  mutate(variable = as.Date(variable, origin = "1899-12-30"))

# the years 2022-2023 are in different format. Slice and properly transform the date format 

fix_data_type <- texas_confirmed_cases_combined %>%
  melt(id.vars = "County") %>% 
  slice(169165:50000000) %>% #get 2022-2023 rows only
  mutate(variable = as.numeric(variable)) %>% 
  mutate(variable = variable + 43895) %>% 
  mutate(variable = as.Date(variable, origin = "1899-12-30"))

texas_confirmed_cases_combined_long <- rbind(test,fix_data_type) # rename the columns at the end or now

# renaming them is optional know that
# variable is the date
# value is the number of cases detected on a specific day
# Delete unused datasets

# made a column for year, month and week from the DATE column

texas_confirmed_cases_combined_long <- texas_confirmed_cases_combined_long %>% 
  mutate(year = as.factor(year(texas_confirmed_cases_combined_long$variable)), 
         month = as.factor(month(texas_confirmed_cases_combined_long$variable)), #revisit renaming this to actual name
         week = as.factor(week(texas_confirmed_cases_combined_long$variable))) %>% 
  rename("Date"= variable,
         "confirmed_cases_per_day"=value) 

texas_confirmed_cases_combined_long <-texas_confirmed_cases_combined_long %>% 
  arrange((County))



#write.csv(texas_confirmed_cases_combined_long,"Datasets/processed/texas_confirmed_cases.csv")
#write.csv(texas_confirmed_cases_2020_long,file.path()) if needed,put this path somewhere

# Spatial ----------------
texas_spatial <- texas_spatial %>%  
  st_transform(texas_spatial, crs = 4326) %>% 
  select(CNTY_NM,geometry) %>% 
  rename("County"=CNTY_NM) %>%  
  arrange((County))

# compare county names between geospatial data and confirmed cases.csv
#cnty_nm_comp1 <- texas_spatial$County 
#cnty_nm_comp1[59] <- "DeWitt"
#cnty_nm_comp2 <- unique(texas_confirmed_cases_combined_long$County)
#str_equal(cnty_nm_comp1,cnty_nm_comp2) #strings are equal
#write.csv(x= texas_spatial, file = "Datasets/processed/texas_spatial")
#texas spatial has the county name and geometry
#texas_confirmed_cases_long has the cases per date and county







