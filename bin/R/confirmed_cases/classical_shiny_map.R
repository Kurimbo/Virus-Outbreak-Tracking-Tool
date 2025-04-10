# app.R
library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(ggplot2)

# Load your data here
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/setup.R")

ui <- fluidPage(
  titlePanel("Virus Outbreak Tracking System"),
  sidebarLayout(
    sidebarPanel(
      selectInput("state", label = "Select a state:", choices = unique(texas_confirmed_cases_combined_long$state)),
      selectInput("year", "Select Year:", choices = unique(texas_confirmed_cases_combined_long$year)),
    #  sliderInput("month", "Select Month:", min = 1, max = 12, value = 3, step = 1, ticks = TRUE, animate = TRUE)
    ),
    mainPanel(
      leafletOutput("map"),
      plotOutput("month_county")
    )
  )
)

server <- function(input, output, session) {
  spatial_data <- reactive({
    texas_spatial[texas_spatial$state == input$state, ]
    texas_spatial[texas_spatial$County == input$County, ]
    
  })
  
  texas_confirmed_cases <- reactive({
    texas_confirmed_cases_combined_long[texas_confirmed_cases_combined_long$state == input$state, ]
    texas_confirmed_cases_combined_long[texas_confirmed_cases_combined_long$County == input$County, ]
  #  texas_confirmed_cases_combined_long[texas_confirmed_cases_combined_long$state == input$state, ]
    })
  
  click_county <- eventReactive(input$map_shape_click, {
    input$map_shape_click$id
  })
  
  county_data <- reactive({
    req(click_county())
    filter(texas_confirmed_cases(), County == click_county())
  })
  
  output$map <- renderLeaflet({
    sp <- spatial_data()
    leaflet(sp) %>%
      addProviderTiles("CartoDB.Positron") %>%
      clearShapes() %>%
      addPolygons(
        stroke = TRUE, smoothFactor = 0.1,
        fillOpacity = 0.2,
        layerId = ~County
      )
  })
  
  observe({
    req(click_county())
    proxy <- leafletProxy("map")
    sub <- dplyr::filter(spatial_data(), County == click_county())
    box <- st_bbox(sub) %>% as.vector()
    
    if (nrow(sub) == 0) return(NULL)
    
    proxy %>%
      clearGroup(group = "sub") %>%
      addPolygons(
        data = sub, fill = FALSE, color = "#FFFF00",
        opacity = 1, group = "sub", weight = 1.5
      ) %>%
      fitBounds(
        lng1 = box[1], lat1 = box[2],
        lng2 = box[3], lat2 = box[4]
      )
  })
  
  observeEvent(click_county(), {
    leafletProxy("map") %>%
      removeShape("County") %>%
      addPolygons(
        data = filter(spatial_data(), County == click_county()),
        fill = FALSE, color = "#00FFFF",
        opacity = 1, layerId = "County",
        weight = 1.2
      )
  })
  
  output$month_county <- renderPlot({
    cd <- county_data()
    cases_per_month_county <- cd %>%
      select(County, month, year, confirmed_cases_per_day, disease) %>%
      group_by(County, month, disease) %>%
      summarize(confirmed_cases_per_day = n(), .groups = "drop")
    
    ggplot(cases_per_month_county, aes(x = month, y = confirmed_cases_per_day, fill = disease)) +
      geom_bar(stat = "identity", width = 0.7) +
      theme_minimal() +
      labs(
        title = paste0("Confirmed Cases in County ", unique(cd$County)),
        x = "Month",
        y = "Count"
      )
  })
}

shinyApp(ui, server)
