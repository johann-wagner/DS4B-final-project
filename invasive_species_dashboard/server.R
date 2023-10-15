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
    "0-00_setup_and_configuration.R",
    echo = TRUE,
    max.deparse.length = 1e4
)

# Read in dashboard_data
dashboard_data <- read_csv(
    "dashboard_data.csv"
)



# RShiny Server -----------------------------------------------------------

# Ref [3]: Define server logic required to draw a histogram
function(input, output, session) {

    thematic_shiny(font = "auto")
    
    # Single zoomable plot (on left)
    ranges <- reactiveValues(x = NULL, y = NULL)
    
    output$spatial_visualisation <- renderPlot({
        
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        ## Create spatial data ---------------------------------------------------
        
        spatial_data <- dashboard_data %>% 
            
            # We only care about a specific species in a specific state
            filter(
                simpleName == species_simple_name,
                state      == state_name
            )
        
        
        
        # Create captial cities ---------------------------------------------------
        # Ref [4]: Plot onto map
        capital_cities_data <- tibble::tribble( 
            ~state,                         ~city,       ~lat,     ~lon,
            "New South Wales",              "Sydney",    -33.8688, 151.2093,
            "Victoria",                     "Melbourne", -37.8136, 144.9631,
            "Queensland",                   "Brisbane",  -27.4698, 153.0251,
            "South Australia",              "Adelaide",  -34.9285, 138.6007,
            "Western Australia",            "Perth",     -31.9505, 115.8605,
            "Tasmania",                     "Hobart",    -42.8821, 147.3272,
            "Northern Territory",           "Darwin",    -12.4634, 130.8456,
            "Australian Capital Territory", "Canberra",  -35.2809, 149.1300,
        ) %>% 
            filter(state == state_name)
        
        
        
        ## Create spatial plot ----------------------------------------------------
        # Ref [1]: Create spatial visualisation of the ACT
        state2021 %>% 
            
            # We only care about a specific state
            filter(state_name_2021 == state_name) %>% 
            ggplot() +
            
            # Ref [1]: Create background polygon of the ACT
            geom_sf(
                aes(geometry = geometry),
                fill = "#E5E4E2"
            ) +
            
            geom_point(
                data = spatial_data,
                aes(
                    x = decimalLongitude,
                    y = decimalLatitude,
                    size = simpleName
                ),
                alpha = 0.6,
                colour = "#1b9e77"
            ) +
            
            geom_point(
                data = capital_cities_data,
                aes(
                    x = lon,
                    y = lat,
                    shape = city
                ),
                colour = "#d95f02",
                size = 4
            ) +
            
            coord_sf(
                xlim = ranges$x,
                ylim = ranges$y,
                expand = FALSE
            ) +
            
            # theme_minimal() +
            
            # Ref [2]
            labs(
                # title = bquote(
                #     "There are" ~
                #         # Extract character string of month with most records
                #         # Ref [3]: The .() allows the object to be called
                #         bold(.({
                #             spatial_data %>% 
                #                 nrow() %>% 
                #                 comma()
                #         })) ~
                #         "records of" ~
                #         bold(.(species_simple_name)) ~
                #         "in" ~
                #         bold(.(state_name))
                # ),
                
                shape = "Capital City",
                
                size = "Invasive Species"
            ) +
            
            theme(
                # Remove axis ticks, text, and grid lines
                axis.title = element_blank(),
                axis.ticks = element_blank(),
                axis.text  = element_blank(),
                panel.grid = element_blank(),
                
                # Add colour to ggplot title
                plot.title = element_text(size = 16),
                
                # Add background to provide colour contrast
                # plot.background = element_rect(
                #     fill   = "grey97",
                #     colour = "white"
                # ),
                
                # Ref [5]: Improve readability
                legend.text      = element_text(size = 14),
                legend.title     = element_text(
                    size = 14,
                    face = "bold"
                    ),
                legend.direction = "vertical",
                legend.background = element_rect(
                    fill = "#E5E4E2",
                    colour = "#708090"
                ),
                
                legend.position = "bottom",
                legend.justification = c("right", "top"),
                legend.box.just = "right",
                legend.margin = margin(6, 6, 6, 6),
                
                # Ref [6]: Panel Background
                panel.background = element_rect(fill = "transparent")
            )
        
        
        
        # References:
        # - [1] https://github.com/wfmackey/absmapsdata/tree/master
        # - [2] https://labs.ala.org.au/posts/2023-05-16_dingoes/post.html
        # - [3] https://stackoverflow.com/questions/72119434/ggplot-create-title-with-superscript-bold-and-with-pasted-variable
        # - [4] https://ggplot2-book.org/maps.html
        # - [5] https://r-graph-gallery.com/239-custom-layout-legend-ggplot2.html
        # - [6] https://www.r-bloggers.com/2022/07/ggplot2-transparent-background-quick-guide/
    })
    
    # Ref [1]: When a double-click happens, check if there's a brush on the plot.
    # If so, zoom to the brush bounds; if not, reset the zoom.
    observeEvent(input$plot1_dblclick, {
        brush <- input$plot1_brush
        if (!is.null(brush)) {
            ranges$x <- c(brush$xmin, brush$xmax)
            ranges$y <- c(brush$ymin, brush$ymax)
            
        } else {
            ranges$x <- NULL
            ranges$y <- NULL
        }
    })
    
    output$temporal_visualisation <- renderPlot({
        # Data Visualisation - Temporal -------------------------------------------
        
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        ## Create temporal data ---------------------------------------------------
        temporal_data <- dashboard_data %>% 
            
            # Use full month name in ggplot title
            mutate(
                month_full_name = eventDate %>%
                    as_date() %>%
                    month(
                        label = TRUE,
                        abbr  = FALSE
                    ) %>%
                    as_factor()
            ) %>%
            
            # We only care about a specific species in a specific state
            filter(
                simpleName == species_simple_name,
                state      == state_name
            ) %>% 
            count(month = month_full_name) %>%
            
            # Ref [7]:
            # Ensure that all months are always displayed
            # even if there is a month with zero records
            complete(month = unique(dashboard_data$eventDate %>% 
                                        as_date() %>% 
                                        month(label = TRUE, abbr = FALSE) %>% 
                                        as_factor()), 
                     fill = list(n = 0)) %>% 
            mutate(
                month_full_name = month,
                month = month_full_name %>% 
                    str_sub(
                        start = 1,
                        end   = 3
                    )
            ) %>% 
            
            # Ref [6]: Add 13th empty month to provide space for percentage scale
            add_row(
                month = "   ",
                n     = 0
            ) %>% 
            
            # Ensure months are ordered in visualisation
            arrange(match(
                month,
                c(
                    "   ", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                )
            )) %>% 
            
            # Calculate Proportion
            mutate(
                # Ensure that all months are always displayed
                # even if there is a month with zero records
                proportion = case_when(
                    n > 0 ~ n / sum(n),
                    .default = 0
                )
            )
        
        
        
        ## Check if zero records ---------------------------------------------------
        
        # Ensure that no plot is shown if there are zero species records in state
        if(nrow(temporal_data) == 1) {
            stop(glue(
                "There are zero records of the ",
                species_simple_name,
                " in ",
                state_name,
                "."
            ))
        }
        
        
        
        # ## Create paramaters for labels -------------------------------------------
        # 
        # # Ref [3]: Calculate the ANGLE of the labels
        # number_of_bar <- nrow(temporal_data)
        # angle <- 90 - 360 * (1:13 - 0.5) / number_of_bar
        # 
        # # Calculate the alignment of labels: right or left
        # # If I am on the left part of the plot, my labels have currently an angle < -90
        # temporal_data$hjust <- ifelse(angle < -90, 1, 0)
        # 
        # # Flip angle BY to make them readable
        # temporal_data$angle <- ifelse(angle < -90, angle + 180, angle)
        
        
        
        ## Create circular barplot -------------------------------------------------
        # Ref [1, 2]
        temporal_data %>% 
            ggplot(aes(
                x    = fct_inorder(month),
                y    = proportion,
                fill = proportion
            )) +
            
            # Create background percentage grid/axis
            geom_hline(
                data = tibble(y = 0:10 * 0.1),
                aes(yintercept = y),
                colour = "lightgray"
            ) +
            
            # Create proportion bar
            geom_bar(
                stat = "identity"
            ) +
            
            # # Create month label
            # geom_text(
            #   aes(
            #     x = fct_inorder(month),
            #     y = proportion + 0.02, # Adjust the y-coordinate for label positioning
            #     label = percent(proportion, accuracy = 1),
            #     hjust = hjust
            #   ),
            #   fontface = "bold",
            #   size = 3,
            #   angle = temporal_data$angle,
            #   inherit.aes = FALSE 
            #   ) +
        
            # Ref [4]: Annotate custom scale inside plot
            annotate(
                x     = 1,
                y     = 0.015,
                size  = 4,
                label = "0%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.115,
                size  = 4,
                label = "10%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.215,
                size  = 4,
                label = "20%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.315,
                size  = 4,
                label = "30%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.415,
                size  = 4,
                label = "40%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.515,
                size  = 4,
                label = "50%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.615,
                size  = 4,
                label = "60%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.715,
                size  = 4,
                label = "70%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.815,
                size  = 4,
                label = "80%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 0.915,
                size  = 4,
                label = "90%",
                geom  = "text",
                color = "grey12",
            ) +
            
            annotate(
                x     = 1,
                y     = 1.015,
                size  = 4,
                label = "100%",
                geom  = "text",
                color = "grey12",
            ) +
            
            scale_fill_viridis_c(option = "C") +
            
            # Ref [6]: Ensure 13th month is center aligned
            coord_polar(start = -0.25) +
            
            # Ref [4]: Scale y axis so bars don't start in the center
            # 0.05 ensures that there will always be a +10% grid circle /
            # There will always be an outer n*10% grid circle
            scale_y_continuous(
                limits = c(-0.1, max(temporal_data$proportion) + 0.07),
                expand = c(0, 0),
                breaks = 1:10 * 0.1
            ) + 
            
            labs(
                # title = bquote(
                #     # Extract character string of month with most records
                #     # Ref [5]: The .() allows the object to be called
                #     bold(.({
                #         temporal_data %>%
                #             filter(n == max(temporal_data$n)) %>%
                #             pull(month_full_name) %>%
                #             as.character()
                #     })) ~
                #         "has the highest proportion of records" ~
                #         bold(.(species_simple_name)) ~
                #         "in" ~
                #         bold(.(state_name))
                # )
            ) +
            
            # theme_minimal() +
            
            theme(
                # Remove axis ticks, text, and grid lines
                axis.title = element_blank(),
                axis.ticks = element_blank(),
                axis.text  = element_blank(),
                panel.grid = element_blank(),
                
                # Use gray text for the percentages
                axis.text.x = element_text(
                    color = "gray12",
                    size = 14,
                    face = "bold"
                    ),
                
                # Fill is ordered by month and already has labels in plot
                # No need for legend
                legend.position = "none",
                
                # Add colour to ggplot title
                plot.title = element_text(size = 16),
                
                panel.background = element_rect(fill = "transparent"),
                
                # Add background to provide colour contrast
                # plot.background = element_rect(
                #     fill   = "grey97",
                #     colour = "white"
                # )
            )
        
        
        
        # References:
        # - [1] https://www.geeksforgeeks.org/circular-barplots-and-customisation-in-r/
        # - [2] https://r-graph-gallery.com/295-basic-circular-barplot.html
        # - [3] https://r-graph-gallery.com/296-add-labels-to-circular-barplot.html
        # - [4] https://r-graph-gallery.com/web-circular-barplot-with-R-and-ggplot2.html
        # - [5] https://stackoverflow.com/questions/72119434/ggplot-create-title-with-superscript-bold-and-with-pasted-variable
        # - [6] https://r-graph-gallery.com/297-circular-barplot-with-groups.html
        # - [7] https://chat.openai.com/share/c907f001-88f6-49ee-afcd-696825e5daf7
    })
    
    # References:
    # - [1] https://shiny.posit.co/r/gallery/interactive-plots/plot-interaction-zoom/
    
    output$dashboard_data_output <- renderTable({
        if(input$show_data) {
            
            # Dynamic Variables
            species_simple_name <- input$simpleName
            state_name <- input$state
            
            ## Create temporal data ---------------------------------------------------
            dashboard_data %>% 
                
                # Use full month name in ggplot title
                mutate(
                    month_full_name = eventDate %>%
                        as_date() %>%
                        month(
                            label = TRUE,
                            abbr  = FALSE
                        ) %>%
                        as_factor()
                ) %>%
                
                # We only care about a specific species in a specific state
                filter(
                    simpleName == species_simple_name,
                    state      == state_name
                ) %>% 
                count(month = month_full_name) %>%
                
                # Ensure that all months are always displayed
                # even if there is a month with zero records
                complete(month = unique(dashboard_data$eventDate %>% 
                                            as_date() %>% 
                                            month(label = TRUE, abbr = FALSE) %>% 
                                            as_factor()), 
                         fill = list(n = 0)) %>% 
                mutate(
                    month_full_name = month,
                    month = month_full_name %>% 
                        str_sub(
                            start = 1,
                            end   = 3
                        )
                ) %>% 
                
                # Add 13th empty month to provide space for percentage scale
                add_row(
                    month = "   ",
                    n     = 0
                ) %>% 
                
                # Ensure months are ordered in visualisation
                arrange(match(
                    month,
                    c(
                        "   ", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                    )
                )) %>% 
                
                # Calculate Proportion
                mutate(
                    # Ensure that all months are always displayed
                    # even if there is a month with zero records
                    proportion = case_when(
                        n > 0 ~ n / sum(n),
                        .default = 0
                    ) %>% 
                        percent()
                ) %>% 
                
                select(month, month_full_name, n, proportion) %>% 
                
                filter(month != "   ")
            
        }
    },
    # Ref [1]
    striped = TRUE,
    spacing = "l",
    align = "lccr",
    digits = 0,
    width = "90%",
    caption = "CAPTION!"
    )
    
    # References:
    # - [1] https://shiny.posit.co/r/getstarted/build-an-app/reactive-flow/render-functions.html
    
    # Create Spatial Title ------------------------------------------------------------
    output$spatial_number <- renderText({
        
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        ## Create spatial data ---------------------------------------------------
        spatial_data <- dashboard_data %>% 
            
            # We only care about a specific species in a specific state
            filter(
                simpleName == species_simple_name,
                state      == state_name
            )
        as.character({
            spatial_data %>% 
                nrow() %>% 
                comma()
        })
        
    })
    
    output$spatial_species_simple_name <- renderText({
        input$simpleName
    })
    
    output$spatial_state_name <- renderText({
        input$state %>% 
            str_c(":")
    })
    

# Create Temporal Title ---------------------------------------------------

    
    output$temporal_month <- renderText({
        
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        ## Create temporal data ---------------------------------------------------
        temporal_data <- dashboard_data %>% 
            
            # Use full month name in ggplot title
            mutate(
                month_full_name = eventDate %>%
                    as_date() %>%
                    month(
                        label = TRUE,
                        abbr  = FALSE
                    ) %>%
                    as_factor()
            ) %>%
            
            # We only care about a specific species in a specific state
            filter(
                simpleName == species_simple_name,
                state      == state_name
            ) %>% 
            count(month = month_full_name) %>%
            
            # Ref [7]:
            # Ensure that all months are always displayed
            # even if there is a month with zero records
            complete(month = unique(dashboard_data$eventDate %>% 
                                        as_date() %>% 
                                        month(label = TRUE, abbr = FALSE) %>% 
                                        as_factor()), 
                     fill = list(n = 0)) %>% 
            mutate(
                month_full_name = month,
                month = month_full_name %>% 
                    str_sub(
                        start = 1,
                        end   = 3
                    )
            ) %>% 
            
            # Ref [6]: Add 13th empty month to provide space for percentage scale
            add_row(
                month = "   ",
                n     = 0
            ) %>% 
            
            # Ensure months are ordered in visualisation
            arrange(match(
                month,
                c(
                    "   ", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                )
            )) %>% 
            
            # Calculate Proportion
            mutate(
                # Ensure that all months are always displayed
                # even if there is a month with zero records
                proportion = case_when(
                    n > 0 ~ n / sum(n),
                    .default = 0
                )
            )
        

        
        as.character(
            {
                temporal_month <- temporal_data %>%
                    filter(n == max(temporal_data$n)) %>%
                    pull(month_full_name) %>%
                    as.character()
                
                if(sum(temporal_data$n) == 0) {
                    temporal_month <- "No month"
                }
                
                temporal_month
            }
        )
    })
    
    output$temporal_species_simple_name <- renderText({
        input$simpleName
    })
    
    output$temporal_state_name <- renderText({
        input$state %>% 
            str_c(":")
    })

# Download Data -----------------------------------------------------------

    # Ref [1]: Create a reactive expression to filter dashboard_data
    download_filtered_data <- reactive({
        # Dynamic Variables
        species_simple_name <- input$simpleName
        state_name <- input$state
        
        filtered <- dashboard_data %>% 
            filter(
                simpleName == species_simple_name,
                state      == state_name
            )
        return(filtered)
    })
    
    output$download_filtered_data <- downloadHandler(
        filename = function() {
            "filtered_dashboard_data.csv"
        },
        content = function(file) {
            write.csv(
                download_filtered_data(),
                file,
                row.names = FALSE
                )
        }
    )
    
    # References:
    # - [1] https://chat.openai.com/share/4d26e796-62b4-4c35-8787-e7e0d26b62e5
    }