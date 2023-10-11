### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: create_state_column                                  ###
###                                                                          ###
### ############################################################################
### ############################################################################





# create_state_column ------------------------------------------------------

### Purpose:
# To create a state column indicating which state each occurrence observation
# was recorded in based on the spatial longitude and latitude data.

create_state_column <- function(species_all_states_clean_input) {
  
  # Make sure both your tibble and shapefile have the same coordinate reference
  # system (CRS)
  species_all_states_clean_sf <- st_as_sf(
    species_all_states_clean_input,
    coords = c("decimalLongitude", "decimalLatitude"),
    crs = st_crs(state2021)
  )
  
  # Create a vector of state/territory names
  state_names <- c(
    "New South Wales",
    "Victoria",
    "Queensland",
    "South Australia",
    "Western Australia",
    "Tasmania",
    "Northern Territory",
    "Australian Capital Territory"
  )
  
  # Initialise empty list
  species_all_states_clean_list <- list()
  
  # Ref [3]: Create a separate tibble for all points within each state and
  # put in list
  for (state_name in state_names) {
    species_state_clean <- species_all_states_clean_sf %>% 
      st_filter({state2021 %>% filter(state_name_2021 == state_name)}) %>% 
      mutate(state = state_name) %>% 
      as_tibble()
    
    species_all_states_clean_list[[state_name]] <- species_state_clean
  }
  
  # Bind all 8 tibbles back into one big tibble
  species_all_states_clean_output <- species_all_states_clean_input %>% 
    
    # Join the new columns (geometry, state) to the input tibble
    left_join(
      {bind_rows(species_all_states_clean_list)},
      join_by(
        eventDate,
        scientificName,
        taxonConceptID,
        recordID,
        dataResourceName,
        occurrenceStatus
      )
    )
  
  return(species_all_states_clean_output)
}



# References:
# - [1] https://rdrr.io/cran/sf/man/st_as_sf.html
# - [2] https://chat.openai.com/share/3e22a588-45d1-4959-923b-ac85da5e34b0
# - [3] https://chat.openai.com/share/81f6f18f-e6e6-4c41-8750-c78e45e0c16e