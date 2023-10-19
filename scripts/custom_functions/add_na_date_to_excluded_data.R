### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: add_na_date_to_excluded_data                         ###
###                                                                          ###
### ############################################################################
### ############################################################################





# add_na_date_to_excluded_data ----------------------------------------------

### Purpose:
# To add NA values from the eventDate column into the excluded data dataset.
# Note: This does not remove/filter any data from the input data, this only
#       adds data to the excluded_data dataset.

add_na_date_to_excluded_data <- function(species_occurrence) {
  add_excluded <- species_occurrence %>%
    filter(is.na(eventDate)) %>%
    # Add excluded_notes
    mutate(
      date           = Sys.Date(),
      excluded_notes = "These data points have a missing eventDate value."
    )

  excluded_data <- bind_rows(excluded_data, add_excluded)
  return(excluded_data)
}