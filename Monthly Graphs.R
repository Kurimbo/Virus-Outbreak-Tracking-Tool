library(shiny)       # For building the interactive web application
library(ggplot2)     # For plotting
library(dplyr)       # For data manipulation
library(readxl)      # For reading Excel files
library(scales)      # For better axis scaling
library(plotly)      # For interactive ggplot visualizations

# ------------------------
# Load and prepare datasets
# ------------------------

# COVID dataset
covid <- read_excel("Datasets/cleaned/Texas_COVID19_Cases_Cleaned.xlsx", sheet = 1) %>%
  rename(Cases = Total_Cases) %>%                      # Standardize column name for consistency
  mutate(Virus = "COVID-19",                          # Add identifier
         Month = as.character(Month))                 # Ensure Month is character for merging later

# Flu dataset
flu <- read_excel("Datasets/cleaned/Flu_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Estimated_Cases) %>%
  mutate(Virus = "Flu",
         Month = as.character(Month))

# TB dataset
tb <- read_excel("Datasets/cleaned/TB_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Total_Cases) %>%
  mutate(Virus = "TB",
         Month = as.character(Month))

# HIV dataset
hiv <- read_excel("Datasets/cleaned/HIV_Cases_Cleaned.xlsx", sheet = 3) %>%
  rename(Cases = Estimated_Cases) %>%
  mutate(Virus = "HIV",
         Month = as.character(Month))

# Combine all datasets into one
all_data <<- bind_rows(covid, flu, tb, hiv)
all_data$County <- trimws(all_data$County)                # Remove whitespace from county names
all_data <- all_data %>% filter(Year %in% c(2020:2023))   # Filter to selected years only

# ------------------------
# Define virus-specific colors for bar plots
# ------------------------
virus_colors <- c(
  "COVID-19" = "steelblue",
  "Flu" = "forestgreen",
  "TB" = "darkred",
  "HIV" = "darkmagenta"
)

# ------------------------
# User Interface (UI)
# ------------------------
ui <- fluidPage(
  titlePanel("Monthly Disease Case Counts by County"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("virus", "Select Virus", choices = unique(all_data$Virus), selected = "COVID-19"),
      selectInput("year", "Select Year", choices = sort(unique(all_data$Year)), selected = 2020),
      uiOutput("county_ui")   # Dynamically generated county list
    ),
    
    mainPanel(
      conditionalPanel(
        condition = "output.noData",
        tags$h4("No data available for the selected filters.", style = "color: red;")
      ),
      plotlyOutput("barPlot")
    )
  )
)

# ------------------------
# Server Logic
# ------------------------
server <- function(input, output, session) {
  
  # Dynamically update county choices based on virus selection
  observeEvent(input$virus, {
    counties <- unique(all_data$County[all_data$Virus == input$virus & all_data$Cases > 0])
    updateSelectInput(session, "county", choices = sort(counties), selected = sort(counties)[1])
  })
  
  # Render county dropdown UI
  output$county_ui <- renderUI({
    selectInput("county", "Select County", choices = sort(unique(all_data$County[all_data$Virus == input$virus & all_data$Cases > 0])))
  })
  
  # Reactive: Filter dataset based on user input
  filtered_data <- reactive({
    df <- all_data %>% 
      filter(Virus == input$virus, Year == input$year, County == input$county)
    
    df <- df %>%
      filter(!is.na(Cases)) %>%
      mutate(
        Month = case_when(                                   # Convert Month to numeric if needed
          is.character(Month) & Month %in% month.abb ~ match(Month, month.abb),
          is.character(Month) & grepl("^\\d+$", Month) ~ as.integer(Month),
          is.numeric(Month) ~ as.integer(Month),
          TRUE ~ NA_integer_
        ),
        Month = ifelse(Month >= 1 & Month <= 12, Month, NA_integer_)
      ) %>%
      filter(!is.na(Month)) %>%
      mutate(
        Month_Label = factor(month.abb[Month], levels = month.abb),   # Create month name labels for x-axis
        tooltip_text = paste("Month:", month.abb[Month], "<br>Cases:", Cases)
      )
    
    df
  })
  
  # Generate bar plot
  output$barPlot <- renderPlotly({
    df <- filtered_data()
    
    # Notify if no data is available
    output$noData <- reactive({ nrow(df) == 0 })
    outputOptions(output, "noData", suspendWhenHidden = FALSE)
    
    if (nrow(df) == 0) return(NULL)
    
    # Create plot
    p <- ggplot(df, aes(x = Month_Label, y = Cases, text = tooltip_text)) +
      geom_col(fill = virus_colors[input$virus]) +
      labs(title = paste("Monthly", input$virus, "Cases in", input$county, input$year),
           x = "Month", y = "Cases") +
      theme_minimal()
    
    ggplotly(p, tooltip = "text")   # Convert ggplot to interactive
  })
}

# ------------------------
# Launch the Shiny app
# ------------------------
shinyApp(ui = ui, server = server)

