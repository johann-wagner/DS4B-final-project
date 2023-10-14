#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Setup and Configuration -------------------------------------------------

source(
    "0-00_setup_and_configuration.R",
    echo = TRUE,
    max.deparse.length = 1e4
)

# Read in dashboard_data
# To acquire the most-up-to-date data, you must run all the .R files in the
# scripts folder in the DS4B-final-project GitHub repository.
dashboard_data <- read_csv(
    "dashboard_data.csv"
)



# RShiny UI ---------------------------------------------------------------

# Ref [1, 2]: Define UI for application
fluidPage(themeSelector(),

    # Application title Panel
    titlePanel("Invasive Species Dashboard"),

    # Introduction Panel
    fluidRow(
        column(6,
               wellPanel(
                   h2("Introduction")
               )
        ),
        column(6,
               wellPanel(
                   h2("123")
               )
        )
    ),
    
    # Sidebar with a select input for species and state
    sidebarLayout(
        
        # Sidebar Panel
        sidebarPanel(
            width = 3,
            h4(strong("Dynamic Variables")),
            helpText(
                "Select a specific invasive",
                strong("species"),
                "and",
                strong("state/territory"),
                "from the dropdown lists below."
            ),
            
            br(),
            
            selectInput("simpleName",
                        label = "Invasive Species",
                        choices = unique(dashboard_data$simpleName)
                        ),
            
            selectInput("state",
                        label = "State/Territory",
                        choices = list(
                            "New South Wales",
                            "Victoria",
                            "Queensland",
                            "South Australia",
                            "Western Australia",
                            "Tasmania",
                            "Northern Territory",
                            "Australian Capital Territory"
                        ),
                        selected = "Australian Capital Territory"
            ),
            
            checkboxInput("show_data",
                          label = "Show temporal data table",
                          value = FALSE
                          ),
            
            # Ref [3]: Download Data
            h4(strong("Download Data")),
            h5(strong("Downloading Filtered Data")),
            p("If you would like to conduct your own data analysis, then you can download the filtered data below."),
            helpText("Select species and state/territory variables, then hit 'Download Filtered Data'."),
            downloadButton("download_filtered_data", "Download Filtered Data"),
            
            br(),
            
            h5(strong("Downloading All Data")),
            p(
                "If you would like to conduct your own data analysis",
                strong(em("on the entire dataset")),
                "then you can download the whole dataset below."),
            helpText("Hit 'Download All Data'."),
            downloadButton("download_all_data", "Download All Data")
        ),

        # Main Panel
        mainPanel(
            width = 9,
            fluidRow(
                column(6,
                       wellPanel(
                           # Spatial Visualisation
                           h3("Spatial Visualisation"),
                           p(
                               "The below visualisation spatially showcases the number of records for a specific invasive animal",
                               strong("species"),
                               "in a specific",
                               strong("state/territory.")
                           ),
                           br(),
                           plotOutput(
                               "spatial_visualisation",
                               height = 550,
                               dblclick = "plot1_dblclick",
                               brush = brushOpts(
                                   id = "plot1_brush",
                                   resetOnNew = TRUE
                               )
                               )
                       )
                       ),
                       
                column(6,
                       wellPanel(
                           # Temporal Visualisation
                           h3("Temporal Visualisation"),
                           p(
                               "The below visualisation temporally showcases the proportion of records for a specific invasive animal in a specific state/territory by month.",
                               "Each coloured bar represents the proportion of records in that specific month with colour showing the relative magnitudes of the proportions."
                           ),
                           p("- A brighter, yellow colour indicates a higher proportion."),
                           p("- A darker, red colour indicates a relatively lower proportion."),
                           br(),
                           plotOutput("temporal_visualisation")
                       )
                       ),
                
                # # Data Table
                # h4("Count of invasive species by month"),
                # tableOutput("dashboard_data_output")
                )
            )
        )
    )

# References:
# - [1] https://mastering-shiny.org/basic-app.html
# - [2] https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/
# - [3] https://chat.openai.com/share/4d26e796-62b4-4c35-8787-e7e0d26b62e5

# General Websites that assisted creating RShiny:
# - [1] https://www.christophenicault.com/post/improve_shiny_ui/