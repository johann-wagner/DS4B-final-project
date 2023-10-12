### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: DATA CLEANING                                        ###
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





# Data Cleaning - Excluded Data --------------------------------------------

# Initialise/Create empty excluded_data tibble
excluded_data <- tibble()

# Excluded Data
excluded_data <- raw_rabbits %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_rabbits %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_rabbits %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_foxes %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_foxes %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_foxes %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_cane_toads %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_cane_toads %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_cane_toads %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_cats %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_cats %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_cats %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_horses %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_horses %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_horses %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_pigs %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_pigs %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_pigs %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()

# Excluded Data
excluded_data <- raw_red_fire_ants %>% 
  add_na_date_to_excluded_data()

excluded_data <- raw_red_fire_ants %>% 
  add_na_spatial_to_excluded_data()

excluded_data <- raw_red_fire_ants %>% 
  filter(if_all(
    c(eventDate, decimalLatitude, decimalLongitude), ~ !is.na(.))
  ) %>% 
  create_state_column() %>% 
  add_not_within_abs_map_to_excluded_data()





# Save Excluded Data -----------------------------------------------------------

excluded_data %>% 
  write_csv(
    here(
      "processed_data",
      "excluded_data.csv"
      )
  )