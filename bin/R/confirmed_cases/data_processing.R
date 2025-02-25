#Software Engineering Class
#
#Authors: Elias Ciudad, Van Nguyen, Amy Torres
#
#
#
#
#
#
#
#
#
#
#Paths ####

# Libraries -----------
source("bin/R/libraries.R")
# Reading Data ---------
texas_confirmed_cases_2020 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 1)#,col_types = c("text",1))#, 
texas_confirmed_cases_2021 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 2)
texas_confirmed_cases_2022 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 3)
texas_confirmed_cases_2023 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 4)
texas_confirmed_cases_combined <- list(texas_confirmed_cases_2020,texas_confirmed_cases_2021,texas_confirmed_cases_2022,texas_confirmed_cases_2023) #
texas_confirmed_cases_combined <- reduce(texas_confirmed_cases_combined,full_join, by = "County") #reduce the list to its components and join on the basis of County (like SQL)

str(texas_confirmed_cases_combined)
is.na(any(col(texas_confirmed_cases_combined))) #

texas_by_zipcode <- read.csv("Datasets/pre_processing/COVID-19_Cases__Tests__and_Deaths_by_ZIP_Code_-_Historical.csv")

# Confirmed Cases -------

## Data Cleaning ----------

is.na(any(col(texas_confirmed_cases_combined))) #no missing data, no more action required

str(texas_confirmed_cases_combined) #look at dataset structure


test<- texas_confirmed_cases_combined %>% 
  melt(id.vars = "County") %>% 
  slice(1:666) %>% # get 2020-2021 rows only
  mutate(variable = as.numeric(as.character(variable))) %>% 
  mutate(variable = as.Date(variable, origin = "1899-12-30"))

# the years 2022-2023 are in different format. Slice and properly transform the date format 

fix_data_type <- texas_confirmed_cases_combined %>%
  melt(id.vars = "County") %>% 
  slice(667:1161) %>% #get 2022-2023 rows only
  mutate(variable = as.numeric(variable)) %>% 
  mutate(variable = variable + 43895) %>% 
  mutate(variable = as.Date(variable, origin = "1899-12-30"))

texas_confirmed_cases_combined_long <- rbind(test,fix_data_type) # rename the columns at the end or now

# renaming them is optional know that
# variable is the date
# value is the number of cases detected on a specific day


# made a column for year, month and week from the DATE column

texas_confirmed_cases_combined_long <- texas_confirmed_cases_combined_long %>% 
  mutate(year = as.factor(year(texas_confirmed_cases_combined_long$variable)), 
         month = as.factor(month(texas_confirmed_cases_combined_long$variable)), #revisit renaming this to actual name
         week = as.factor(week(texas_confirmed_cases_combined_long$variable))) %>% 
  rename("Date"= variable,
         "confirmed_cases_per_day"=value)


write.csv(texas_confirmed_cases_combined_long,"Datasets/processed/texas_confirmed_cases_new.csv")


#write.csv(texas_confirmed_cases_2020_long,file.path()) if needed,put this path somewhere

#okay I think I found a big problem, the dataset is now clean BUT it needs to be used for a graph in C++
## Data Processing ------------


# Zipcode Data #####
str(texas_by_zipcode)
texas_by_zipcode <- texas_by_zipcode %>% 
  select(ZIP.Code,Week.Number,Week.Start,Week.End,Cases...Weekly,Cases...Cumulative,Deaths...Weekly,Deaths...Cumulative) %>% 
  janitor::clean_names() #%>% 

length(unique(texas_by_zipcode$zip_code))

texas_by_zipcode
## Data Cleaning
# Spatial ----------------

bexar_spatial <- st_read("Datasets/spatial/Bexar_County_ZIP_Code_Areas.shp") %>%  
  st_transform(bexar_spatial, crs = 4326) %>% 
  select(ZIP, Lng,Lat)


geo_coordinates_bexar <- bexar_spatial %>%
  dplyr::select(ZIP, Lng, Lat)%>% # don't change this ZIP
  rename(zipcode = ZIP) # don't change this ZIP either
# st_crs(geo_coordinates_bexar) check for spatial coordinates IF they were kept

bexar_county_medical_licenses <- bexar_county_medical_licenses %>% 
  rename(zipcode = practice_zip) %>% # rename column for consistency
  left_join(geo_coordinates_bexar, by = "zipcode")

##### Fill in-null values for coordinates####

bexar_county_medical_licenses_full_value <- bexar_county_medical_licenses %>%
  filter(!is.na(Lng))

# head(bexar_county_medical_licenses_full_value)

##### Continue with GeoSpatial Data####

bexar_county_medical_licenses_sf <- bexar_county_medical_licenses_full_value %>%
  st_as_sf(crs = 4326, remove = FALSE) %>%  # Use EPSG 4326 (WGS84) as the CRS
  mutate(Lng = as.numeric(Lng)) %>% 
  mutate(Lat = as.numeric(Lat))





