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
fluidPage(

  # Set theme
  theme = shinytheme("sandstone"),

  # Introduction Panel
  fluidRow(
    column(
      12,
      wellPanel(
        h2(strong("Invasive Species Dashboard")),
        p(
          "This RShiny App Dashboard creates two visualisations (spatial and temporal) for seven invasive animal species in Australia.",
          "You can select one of the seven animal species and one of the eight state/territory values to change the visualisation outputs."
        ),
        p("More information on the development of this App can be found on the GitHub Repository: https://github.com/johann-wagner/DS4B-final-project")
      )
    ),
  ),

  # Sidebar with a select input for species and state
  sidebarLayout(

    # Sidebar Panel
    sidebarPanel(
      width = 3,
      h3("Dashboard Settings"),
      h4(strong("Dynamic Variables")),
      helpText(
        "Select a specific invasive",
        strong("species"),
        "and",
        strong("state/territory"),
        "from the dropdown lists below:"
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

      # checkboxInput("show_data",
      #               label = "Show temporal data table",
      #               value = FALSE
      #               ),

      br(),

      # Ref [3]: Download Data
      h4(strong("Download Data")),
      h5(strong("Downloading filtered data")),
      p(
        "If you would like to conduct your own data analysis, then you can download",
        strong(em("the filtered data")),
        "below."
      ),
      helpText("Select species and state/territory variables, then hit 'Download Filtered Data'."),
      downloadButton("download_filtered_data", "Download Filtered Data"),
      br(),
      br(),
      h5(strong("Downloading the entire dataset")),
      p(
        "If you would like to conduct your own data analysis on",
        strong(em("the entire dataset")),
        "then you can download the whole dataset below."
      ),
      helpText("Hit 'Download All Data'."),
      downloadButton("download_all_data", "Download All Data"),
      br(),
      br(),
      h4(strong("Sources:")),
      p("The DOIs for each species:"),
      p("1.  European Rabbits (https://doi.org/10.26197/ala.d0da2524-838a-4540-a160-fba8088f4850)"),
      p("2.  European Red Foxes (https://doi.org/10.26197/ala.5f700174-e92e-4376-a243-be05ffa93f46)"),
      p("3.  Cane Toads (https://doi.org/10.26197/ala.d6d70c2c-00de-4f76-8ea6-598b9562eb64)"),
      p("4.  Feral Cats (https://doi.org/10.26197/ala.57a58cdc-88c0-45c1-9260-bd17c6fc4b62)"),
      p("5.  Feral Horses (https://doi.org/10.26197/ala.c3cebb21-c2e0-41d0-8b5d-f446c2914827)"),
      p("6.  Feral Pigs (https://doi.org/10.26197/ala.952aa727-1915-4c3f-8399-ed940c24bfef)"),
      p("7.  Red Imported Fire Ants (https://doi.org/10.26197/ala.74b5dd29-4287-473d-8391-9184c8c62554)"),
      p("ABS Australian Statistical Geography Standard (ASGS) Edition 3 (https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026)")
      ),

    # Main Panel
    mainPanel(
      width = 9,
      fluidRow(
        column(
          6,
          wellPanel(
            # Spatial Visualisation
            h3("Spatial Visualisation"),
            h4(strong("Description")),
            p(
              "The below visualisation spatially showcases the number of records for the selected invasive animal",
              strong("species"),
              "in the selected",
              strong("state/territory.")
            ),
            h4(strong("How to zoom in")),
            p(
              "- If you would like to zoom into a specific area, you can hover over the ggplot below and",
              em("click-and-drag"),
              "a light-blue rectangle.",
            ),
            p(
              "- Once drawn,",
              em("double-click"),
              "on the light-blue rectangle to zoom into that specific area.",
            ),
            p(
              "- To return to the original scale,",
              em("double-click"),
              "on the visualisation."
            ),
            h4(
              textOutput("spatial_species_simple_name", container = tags$strong),
              "in",
              textOutput("spatial_state_name", container = tags$strong),
            ),
            h5(
              "There are",
              textOutput("spatial_number", container = tags$strong),
              "records."
            ),
            plotOutput(
              "spatial_visualisation",
              height = 550,
              width = 550,
              dblclick = "plot1_dblclick",
              brush = brushOpts(
                id = "plot1_brush",
                resetOnNew = TRUE
              )
            )
          )
        ),
        column(
          6,
          wellPanel(
            # Temporal Visualisation
            h3("Temporal Visualisation"),
            h4(strong("Description")),
            p(
              "The below visualisation temporally showcases the proportion of records for the selected invasive",
              strong("species"),
              "in the selected",
              strong("state/territory"),
              "by month.",
              "Each coloured bar represents the proportion of records in that specific month with colour showing the relative magnitudes of the proportions."
            ),
            p("- A brighter, yellow colour indicates a relatively higher proportion."),
            p("- A darker, red colour indicates a relatively lower proportion."),
            br(),
            h4(
              textOutput("temporal_species_simple_name", container = tags$strong),
              "in",
              textOutput("temporal_state_name", container = tags$strong),
            ),
            h5(
              textOutput("temporal_month", container = tags$strong),
              "has the highest proportion of records.",
            ),
            plotOutput(
              "temporal_visualisation",
              height = 500,
              width  = 500
            )
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