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
    here::here(
        "scripts",
        "0-00_setup_and_configuration.R"
    ),
    echo = TRUE,
    max.deparse.length = 1e4
)

library(shiny)

# Read in dashboard_data
dashboard_data <- read_csv(
    "dashboard_data.csv"
)



# Ref [1]: Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Invasive Species Dashboard"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("simpleName",
                        label = "Species Name",
                        choices = unique(dashboard_data$simpleName)
                        ),
            selectInput("state",
                        label = "State Name",
                        choices = unique(dashboard_data$state)
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("spatial_visualisation")
        )
    )
)

# References:
# - [1] https://mastering-shiny.org/basic-app.html