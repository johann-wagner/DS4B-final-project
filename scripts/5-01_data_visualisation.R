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

source(
  here::here(
    "scripts",
    "1-01_data_loading.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Cleaning ------------------------------------------------------------

source(
  here::here(
    "scripts",
    "2-01_data_cleaning.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Wrangling ------------------------------------------------------------

source(
  here::here(
    "scripts",
    "3-01_data_wrangling.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Manipulation ---------------------------------------------------------

source(
  here::here(
    "scripts",
    "4-01_data_manipulation.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)





# Data Visualisation ------------------------------------------------------

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
