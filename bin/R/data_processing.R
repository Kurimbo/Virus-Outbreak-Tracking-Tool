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
#LIBRARIES #####
source("bin/R/libraries.R")
#READING DATA####
texas_confirmed_cases_2020 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx", sheet = 1)#,col_types = c("text",1))#, 
texas_confirmed_cases_2021 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 2)
texas_confirmed_cases_2022 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 3)
texas_confirmed_cases_2023 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 4)
texas_confirmed_cases_combined<- list(texas_confirmed_cases_2020,texas_confirmed_cases_2021,texas_confirmed_cases_2022,texas_confirmed_cases_2023) 
texas_confirmed_cases_combined <- reduce(texas_confirmed_cases_combined)
str(texas_confirmed_cases_combined)
#DATA CLEANING####
##2020 Data
texas_confirmed_cases_combined_long<- texas_confirmed_cases_combined %>% 
  melt()# %>% 
# mutate(variable = as.Date(as.numeric(as.character(variable)), origin = "1899-12-30"))

texas_confirmed_cases_combined_long$variable <- as.numeric(as.character(texas_confirmed_cases_combined_long$variable))

texas_confirmed_cases_2020_long$variable <- as.Date(texas_confirmed_cases_2020_long$variable, origin = "1899-12-30")



texas_confirmed_cases_2020$variable <- texas_confirmed_cases_2020
#as.Date(as.Date(df$date, origin = "1899-12-30"))
str(texas_confirmed_cases_2020)

#DATA PROCESSING####

as_date(texas_confirmed_cases_2020)
#MISC####






