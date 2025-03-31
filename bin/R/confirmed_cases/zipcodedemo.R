# Load Required Libraries
library(shiny)
library(leaflet)
library(dplyr)
library(sf)  # Ensure 'st_bbox()' works

# Load Data Before UI
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/setup.R")

# Ensure merged_data Exists

# UI Component
ui <- fluidPage(
  titlePanel("Bexar County Medical Licensed Professionals"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("County", "Select a county:", choices = texas_spatial$County)  
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map", leafletOutput("map")),
        tabPanel("Demo Tab"), #plotOutput("county_plot1")),
        tabPanel("License Type") #plotOutput("county_plot2"))
      )
    )
  )
)

# Server Component
server <- function(input, output, session) {
  source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/setup.R")
  
  # Reactive Dataset Based on User Selection
  texas_spatial <- reactive({
   # req(input$County)
    texas_spatial[texas_spatial$County == input$County,]
  })
  
  # Update County Selection Dropdown Dynamically
  observe({
    updateSelectInput(session, "County", choices = texas_spatial$County)
  })
  
  # Render Leaflet Map
  output$map <- renderLeaflet({
    ts <- texas_spatial()
    
   # if (nrow(ts) == 0) {
  #    return(NULL)  # No data to display
  #  }
    
    map <- leaflet(ts) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        stroke = TRUE, smoothFactor = 0.1,
        fillOpacity = 0.2,
        layerId = ~County
      )
  })
  leafletOutput("map")
}

# Run the Shiny App
shinyApp(ui, server)
