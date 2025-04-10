install.packages("shiny")
install.packages("plotly")

library(shiny)
library(plotly)
library(dplyr)
library(tidyr)
library(readr)

# Example data loading (replace this with your actual data)
# Your data should have columns: Month, Disease, CountType, Count
# df <- read_csv("your_data.csv")

# Sample data to test
df <- tibble(
  Month = rep(seq.Date(as.Date("2020-01-01"), as.Date("2020-12-01"), by = "month"), each = 6),
  Disease = rep(c("COVID-19", "Influenza"), each = 3, times = 12),
  CountType = rep(c("Cases", "Deaths", "Hospitalizations"), times = 24),
  Count = sample(100:1000, 72, replace = TRUE)
)

# Convert Month to character to display cleanly on x-axis
df$Month <- format(df$Month, "%Y-%m")

ui <- fluidPage(
  titlePanel("Interactive Disease Count Over Time"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("countType", "Select Count Type:",
                  choices = unique(df$CountType), selected = "Cases"),
      
      checkboxGroupInput("diseases", "Select Diseases:",
                         choices = unique(df$Disease),
                         selected = unique(df$Disease))
    ),
    
    mainPanel(
      plotlyOutput("linePlot")
    )
  )
)

server <- function(input, output) {
  filteredData <- reactive({
    df %>%
      filter(CountType == input$countType, Disease %in% input$diseases)
  })
  
  output$linePlot <- renderPlotly({
    plot_data <- filteredData()
    
    p <- ggplot(plot_data, aes(x = Month, y = Count, color = Disease, group = Disease,
                               text = paste("Disease:", Disease, "<br>Count:", Count))) +
      geom_line() +
      geom_point() +
      labs(x = "Month", y = input$countType, title = paste("Monthly", input$countType, "by Disease")) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p, tooltip = "text")
  })
}

shinyApp(ui, server)

