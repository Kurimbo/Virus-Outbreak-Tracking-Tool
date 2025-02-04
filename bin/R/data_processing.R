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
texas_confirmed_cases_2020 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx", 
                                        sheet = 1)#, 
                                        #col_types = c("text", rep("date", 301)))
str(texas_confirmed_cases_2020)
texas_confirmed_cases_2021 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 2)
texas_confirmed_cases_2022 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 3)
texas_confirmed_cases_2023 <- read_xlsx("Datasets/Texas COVID-19 New Confirmed Cases by County.xlsx",sheet = 4)

#DATA CLEANING####
##2020 Data
texas_confirmed_cases_2020<- texas_confirmed_cases_2020 %>% 
  melt()

texas_confirmed_cases_2020$variable <- as.Date(as.numeric(as.numeric(texas_confirmed_cases_2020$variable, origin = "2020-03-06")))



texas_confirmed_cases_2020$variable <- texas_confirmed_cases_2020
#as.Date(as.Date(df$date, origin = "1899-12-30"))
str(texas_confirmed_cases_2020)

#DATA PROCESSING####

as_date(texas_confirmed_cases_2020)
#MISC####






