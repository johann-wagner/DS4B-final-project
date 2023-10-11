### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: load_galah_occurrence_data                           ###
###                                                                          ###
### ############################################################################
### ############################################################################





# load_galah_occurrence_data ----------------------------------------------

### Purpose:
# To load the species occurrence data of any given species within the Atlas
# of Living Australia database.

load_galah_occurrence_data <- function(
  # character string of scientific name of species
  species_name
) {
  species_occurrence <- galah_call() %>%
    
    # To conduct a search for species scientific name
    galah_identify(species_name) %>% # Ref [1]
    
    # Pre-applied filter to ensure quality-assured data
    # the "ALA" profile is designed to exclude lower quality records Ref [2]
    galah_apply_profile(ALA) %>% 
    atlas_occurrences()
  
  return(species_occurrence)
}



# References:
# - [1] https://bie.ala.org.au/species/https://biodiversity.org.au/afd/taxa/692effa3-b719-495f-a86f-ce89e2981652
# - [2] https://galah.ala.org.au/R/reference/galah_apply_profile.html