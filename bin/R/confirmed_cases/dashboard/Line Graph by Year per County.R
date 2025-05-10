# Load libraries
library(shiny)
library(dplyr)
library(readxl)
library(ggplot2)
library(plotly)  # for interactive plots

# Function to read and tag virus with optional sheet number
read_virus_data <- function(file_name, virus_name, sheet_num = 1) {
  data <- read_excel(file_name, sheet = sheet_num)
  
  # Rename Total_Cases to Cases if needed
  if ("Total_Cases" %in% colnames(data)) {
    data <- data %>% rename(Cases = Total_Cases)
  }
  
  data <- data %>% mutate(Virus = virus_name)
  
  # HIV-specific: keep only 2018–2021 and remap 2018 → 2022, 2019 → 2023
  if (virus_name == "HIV") {
    data <- data %>%
      filter(Year %in% c(2018, 2019, 2020, 2021)) %>%
      mutate(Year = as.numeric(Year)) %>%
      mutate(Year = case_when(
        Year == 2018 ~ 2022,
        Year == 2019 ~ 2023,
        TRUE ~ Year
      ))
  }
  
  return(data)
}

# Read and combine datasets
all_data <- bind_rows(
  read_virus_data("Datasets/cleaned/Texas_COVID19_Cases_Cleaned.xlsx", "COVID-19", sheet_num = 2),
  read_virus_data("Datasets/cleaned/Flu_Cases_Cleaned.xlsx", "Flu", sheet_num = 1),
  read_virus_data("Datasets/cleaned/HIV_Cases_Cleaned.xlsx", "HIV", sheet_num = 1),
  read_virus_data("Datasets/cleaned/TB_Cases_Cleaned.xlsx", "TB", sheet_num = 2)
)

# Standardize columns
all_data <- all_data[c("County", "Year", "Cases", "Virus")] %>%
  mutate(
    Year = as.numeric(Year),
    Cases = as.numeric(Cases)
  )

# UI
ui <- fluidPage(
  titlePanel("Virus Outbreak Tracking System - Line Graph by County and Year"),
  sidebarLayout(
    sidebarPanel(
      selectInput("county", "Select County:",
                  choices = sort(unique(all_data$County)),
                  selected = "Bexar"),
      selectInput("virus", "Select Virus:",
                  choices = sort(unique(all_data$Virus)),
                  selected = "COVID-19")
    ),
    mainPanel(
      plotlyOutput("linePlot")
    )
  )
)

# Server
server <- function(input, output) {
  filtered_data <- reactive({
    all_data %>%
      filter(County == input$county, Virus == input$virus)
  })
  
  output$linePlot <- renderPlotly({
    data <- filtered_data()
    
    p <- ggplot(data, aes(x = Year, y = Cases,
                          text = paste("Year:", Year,
                                       "<br>Cases:", Cases))) +
      geom_line(group = 1, color = "#2c7fb8", size = 1) +
      geom_point(size = 2, color = "#2c7fb8") +
      theme_minimal() +
      labs(
        title = paste("Case Trends for", input$virus, "in", input$county),
        x = "Year", y = "Number of Cases"
      ) +
      scale_x_continuous(breaks = sort(unique(data$Year)))
    
    ggplotly(p, tooltip = "text")  # show custom hover info
  })
}

# Run app
shinyApp(ui = ui, server = server)
