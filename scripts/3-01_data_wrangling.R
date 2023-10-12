### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: DATA WRANGLING                                       ###
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





# Cleaned Data ------------------------------------------------------------

# Remove the excluded_data from tidied_data
cleaned_data <- tidied_data %>% 
  anti_join(
    excluded_data,
    join_by(recordID)
  )





# Save Cleaned Data -----------------------------------------------------------

cleaned_data %>% 
  write_csv(
    here(
      "processed_data",
      "cleaned_data.csv"
    )
  )