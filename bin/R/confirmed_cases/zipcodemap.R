

# Load Data (Adjust paths as needed)
bexar_county_medical_licenses_sf <- readRDS("path/to/bexar_county_medical_licenses_sf.rds")


ui <- fluidPage(
  titlePanel("Bexar County Medical Licensed Professionals"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Select a dataset:", choices = c("Physicians", "Nurses")),
      selectInput("county", "Select a county/city:", choices = unique(bexar_county_medical_licenses_sf$practice_county))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Map", leafletOutput("map")),
        tabPanel("Age Distribution", plotOutput("zipcode_age_plot")),
        tabPanel("License Type", plotOutput("zipcode_license_plot"))
      )
    )
  )
)
