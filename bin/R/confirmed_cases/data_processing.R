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
#PATHS####

#LIBRARIES #####
source("bin/R/libraries.R")
#READING DATA####
texas_confirmed_cases_2020 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 1)#,col_types = c("text",1))#, 
texas_confirmed_cases_2021 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 2)
texas_confirmed_cases_2022 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 3)
texas_confirmed_cases_2023 <- read_xlsx("Datasets/pre_processing/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 4)
texas_confirmed_cases_combined <- list(texas_confirmed_cases_2020,texas_confirmed_cases_2021,texas_confirmed_cases_2022,texas_confirmed_cases_2023)
texas_confirmed_cases_combined <- reduce(texas_confirmed_cases_combined,full_join, by = "County")
str(texas_confirmed_cases_combined)
View(texas_confirmed_cases_combined)
#DATA CLEANING####
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
#DATA PROCESSING####


#MISC####






