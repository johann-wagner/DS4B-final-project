### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: DATA VISUALISATION                                   ###
###                                                                          ###
### ############################################################################
### ############################################################################





# Setup and Configuration -------------------------------------------------

source(
  here::here(
    "scripts",
    "0-00_setup_and_configuration.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Loading ------------------------------------------------------------

dashboard_data <- read_csv(
  here(
    "processed_data",
    "dashboard_data.csv"
  )
  
)





# Data Visualisation - Spatial --------------------------------------------

species_simple_name <- "Feral Pig"
state_name <- "New South Wales"

# Ref [1]: Create spatial visualisation of the ACT
state2021 %>% 
  filter(state_name_2021 == state_name) %>% 
  ggplot() +
  
  # Ref [1]: Create background polygon of the ACT
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



# References:
# - [1] https://github.com/wfmackey/absmapsdata/tree/master
# - [2] https://labs.ala.org.au/posts/2023-05-16_dingoes/post.html





# Data Visualisation - Temporal -------------------------------------------

## Create temporal data ---------------------------------------------------
temporal_data <- dashboard_data %>% 
  filter(
    simpleName == species_simple_name,
    state      == state_name
  ) %>% 
  count(month) %>% 
  
  # Ensure months are ordered in visualisation
  arrange(match(
    month,
    c(
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    )
  )) %>% 
  
  # Calculate Proportion
  mutate(proportion = n / sum(n))



## Create paramaters for labels -------------------------------------------

# Ref [3]: Calculate the ANGLE of the labels
number_of_bar <- nrow(temporal_data)
angle <- 90 - 360 * (1:12 - 0.5) / number_of_bar

# Calculate the alignment of labels: right or left
# If I am on the left part of the plot, my labels have currently an angle < -90
temporal_data$hjust <- ifelse(angle < -90, 1, 0)

# Flip angle BY to make them readable
temporal_data$angle <- ifelse(angle < -90, angle + 180, angle)



# Create circular barplot -------------------------------------------------
# Ref [1, 2]
temporal_data %>% 
  ggplot(aes(
    x = fct_inorder(month),
    y = proportion,
    fill = fct_inorder(month)
    )) +
  
  # Create background grid
  geom_hline(
    data = tibble(y = 1:10 * 0.1),
    aes(yintercept = y),
    colour = "lightgray"
  ) +
  
  # Create proportion bar
  geom_bar(
    stat = "identity"
    ) +
  
  # Create month label
  geom_text(
    aes(
      x = fct_inorder(month),
      y = proportion + 0.02, # Adjust the y-coordinate for label positioning
      label = percent(proportion, accuracy = 1),
      hjust = hjust
    ),
    fontface = "bold",
    size = 4,
    angle = temporal_data$angle,
    inherit.aes = FALSE 
    ) +

  # Ref [4]: Annotate custom scale inside plot
  annotate(
    x = 0.5,
    y = 0.125,
    size = 3,
    label = "10%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.225,
    size = 3,
    label = "20%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.325,
    size = 3,
    label = "30%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.425,
    size = 3,
    label = "40%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.525,
    size = 3,
    label = "50%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.625,
    size = 3,
    label = "60%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.725,
    size = 3,
    label = "70%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.825,
    size = 3,
    label = "80%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 0.925,
    size = 3,
    label = "90%",
    geom = "text",
    color = "grey12",
  ) +
  
  annotate(
    x = 0.5,
    y = 1.025,
    size = 3,
    label = "100%",
    geom = "text",
    color = "grey12",
  ) +
  
  scale_fill_viridis_d() +
  
  coord_polar(start = 0) +
  
  # Ref[4]: Scale y axis so bars don't start in the center
  scale_y_continuous(
    limits = c(-0.1, max(temporal_data$proportion) + 0.1),
    expand = c(0, 0),
    breaks = 1:10 * 0.1
  ) + 
  
  labs(
    title = (
      "Monthly Circular Barplot of"
    )
  )
  
  theme_minimal() +
  
  theme(
    # Remove axis ticks and text
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    
    # Use gray text for the region names
    axis.text.x = element_text(color = "gray12", size = 12),
    
    # Fill is ordered by month and already has labels in plot
    # No need for legend
    legend.position = "none"
  )
  



# References:
# - [1] https://www.geeksforgeeks.org/circular-barplots-and-customisation-in-r/
# - [2] https://r-graph-gallery.com/295-basic-circular-barplot.html
# - [3] https://r-graph-gallery.com/296-add-labels-to-circular-barplot.html
# - [4] https://r-graph-gallery.com/web-circular-barplot-with-R-and-ggplot2.html