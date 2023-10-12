#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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



# Define server logic required to draw a histogram
function(input, output, session) {

    output$spatial_visualisation <- renderPlot({
        
        # Read in dashboard_data
        dashboard_data <- read_csv(here(
            "processed_data",
            "dashboard_data.csv"
        ))
        
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        # Ref [1]: Create spatial visualisation
        state2021 %>% 
            filter(state_name_2021 == state_name) %>% 
            ggplot() +
            
            # Ref [1]: Create background polygon
            geom_sf(
                aes(geometry = geometry)
            ) +
            
            geom_point(
                data = {
                    dashboard_data %>% 
                        filter(
                            simpleName == species_simple_name,
                            state      == state_name
                        )
                },
                aes(
                    x = decimalLongitude,
                    y = decimalLatitude
                ),
                alpha = 0.6
            ) +
            
            coord_sf() +
            
            theme_minimal() +
            
            # Ref [2]
            labs(title = glue(
                species_simple_name,
                " Observations in the ",
                state_name
            ))
        
    })

}



# References:
# - [1] https://github.com/wfmackey/absmapsdata/tree/master
# - [2] https://labs.ala.org.au/posts/2023-05-16_dingoes/post.html
