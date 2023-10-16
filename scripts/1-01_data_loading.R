### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: DATA LOADING                                         ###
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

raw_rabbits <- load_galah_occurrence_data(
  species_name = "Oryctolagus cuniculus"
)

raw_foxes <- load_galah_occurrence_data(
  species_name = "vulpes vulpes"
)

raw_cane_toads <- load_galah_occurrence_data(
  species_name = "rhinella marina"
)

raw_cats <- load_galah_occurrence_data(
  species_name = "felis catus"
)

raw_horses <- load_galah_occurrence_data(
  species_name = "equus caballus"
)

raw_pigs <- load_galah_occurrence_data(
  species_name = "sus scrofa"
)

raw_red_fire_ants <- load_galah_occurrence_data(
  species_name = "solenopsis invicta"
)





# Save Raw Data -----------------------------------------------------------

raw_rabbits %>% 
  write_csv(
    here(
      "raw_data",
      "raw_rabbits_data.csv"
      )
  )

raw_foxes %>% 
  write_csv(
    here(
      "raw_data",
      "raw_foxes_data.csv"
    )
  )

raw_cane_toads %>% 
  write_csv(
    here(
      "raw_data",
      "raw_cane_toads_data.csv"
    )
  )

raw_cats %>% 
  write_csv(
    here(
      "raw_data",
      "raw_cats_data.csv"
    )
  )

raw_horses %>% 
  write_csv(
    here(
      "raw_data",
      "raw_horses_data.csv"
    )
  )

raw_pigs %>% 
  write_csv(
    here(
      "raw_data",
      "raw_pigs_data.csv"
    )
  )

raw_red_fire_ants %>% 
  write_csv(
    here(
      "raw_data",
      "raw_red_fire_ants_data.csv"
    )
  )





# Tidy Data ---------------------------------------------------------------

tidied_data <- raw_rabbits %>% 
  bind_rows(
    raw_foxes,
    raw_cane_toads,
    raw_cats,
    raw_horses,
    raw_pigs,
    raw_red_fire_ants
  )





# Save Tidied Data -----------------------------------------------------------

tidied_data %>% 
  write_csv(
    here(
      "processed_data",
      "tidied_data.csv"
    )
  )
