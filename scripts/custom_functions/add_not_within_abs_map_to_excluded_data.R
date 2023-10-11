### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: add_not_within_abs_map_to_excluded_data              ###
###                                                                          ###
### ############################################################################
### ############################################################################





# add_not_within_abs_map_to_excluded_data ---------------------------------

### Purpose:
# To add NA values from the derived state column into the excluded data dataset.
# Note: This does not remove/filter any data from the input data, this only 
#       adds data to the excluded_data dataset.

add_not_within_abs_map_to_excluded_data <- function(species_all_states_clean) {
  
  add_excluded <- species_all_states_clean %>% 
    
    filter(is.na(state)) %>% 
    
    # Add excluded_notes
    mutate(
      date           = Sys.Date(),
      excluded_notes = "These data points are not within any of the 8 states and territories ABS borders. They are either overseas data points or are just off the coastline of Australia."
    )
  
  excluded_data <- bind_rows(excluded_data, add_excluded)
  return(excluded_data)
}