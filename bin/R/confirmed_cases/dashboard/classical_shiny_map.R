# app.R
library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(ggplot2)
library(bslib)
# Load your data here
source("D:/Academical Things/Programming/R/Workspaces/Virus_Outbreak_Tracking_Tool/bin/R/confirmed_cases/setup.R")

ui <- page_navbar(
  title = "Virus Outbreak Tracking System",
  
  nav_panel(
    title = "Dashboard",  # Add a title to the tab
    
    sidebarLayout(
      sidebarPanel(
        selectInput("State", label = "Select a state:", choices = unique(all_data$State)),
        selectInput("Year", label = "Select Year:", choices = unique(all_data$Year)),
        checkboxGroupInput("Virus", label = "Select Viruses:",
                           choices = unique(all_data$Virus),
                           selected = unique(all_data$Virus))
      ),
      
      mainPanel(
        leafletOutput("map"),
        plotlyOutput("month_county")
      )
    )
  ),
  nav_panel(
    title = "Line Graphs",  # Add a title to the tab
    fluidPage(
      titlePanel("Virus Outbreak Tracking System - Line Graph by County and Year"),
      sidebarLayout(
        sidebarPanel(
          selectInput("County", "Select County:",
                      choices = sort(unique(all_data$County))),
          selectInput("Virus", "Select Virus:",
                      choices = sort(unique(all_data$Virus)))
        ),
        mainPanel(
          plotlyOutput("linePlot")
        )
      )
    )
    
    
  )
)

server <- function(input, output, session) {
  
  # First Tab
  
  spatial_data <- reactive({
    req(input$State)
    texas_spatial %>% filter(State == input$State)
  })
  
  texas_confirmed_cases <- reactive({
    req(input$State)
    all_data %>% filter(State == input$State, Virus %in% input$Virus)#, County == input$County, Year == input$Year)
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
        layerId = ~County,
        label = ~County
      #  fillColor = ~pal_area(Cases)
      ) 
    
  
    # now I need to add a mask here but... about what
    # Calculate a proportion, ranges for new cases per year (which counties have been most affected based on..)
    # Total cases per year?
    # The map is not updated by month, but ON-CLICK
    # 
    
    
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
  
  output$month_county <- renderPlotly({
    
    cd <- county_data()
    
    cases_per_month_county <- cd %>%
      select(County,Month, Year, Cases, Virus) %>%
      filter(Year == input$Year) %>% 
      group_by(County,Month ,Virus) %>%
      summarize(Cases = sum(Cases, na.rm= T), .groups = "drop")

    p<- ggplot(cases_per_month_county, aes(x = Month , y = Cases, fill = Virus)) +
      geom_bar(stat = "identity", position = position_dodge(width=0.8),width = 0.7) +
      theme_minimal() +
      labs(
        title = paste0("Confirmed Cases in County ", unique(cd$County)),
        x = "Month",
        y = "Count"
      )
    
    ggplotly(p, tooltip = "all")

  })
  
  #Second Tab
  
  second_tab_data <- reactive({
    #virus_selected <- input$Virus[1]
    
    line_data %>%
      filter(County == input$County, Virus == input$Virus) 
  })
  
  output$linePlot <- renderPlotly({
    second_data <- second_tab_data()
    
    second <- ggplot(second_data, aes(x = Year, y = Cases, 
                                      
                          text = paste("Year:", Year,
                                       "<br>Cases:", Cases))) +
      
      geom_line(group = 1, color = "#2c7fb8", size = 1) +
      geom_point(size = 2, color = "#2c7fb8") +
      theme_minimal() +
      labs(
        title = paste("Case Trends for", paste(input$Virus, collapse = ", "), "in", input$County),
        x = "Year", y = "Number of Cases"
      ) +
      scale_x_continuous(breaks = sort(unique(second_data$Year)))
    
    ggplotly(second, tooltip = "text")  # show custom hover info
  })

  
}

shinyApp(ui, server)
