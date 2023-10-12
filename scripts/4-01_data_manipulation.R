### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: DATA MANIPULATION                                    ###
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





# Data Manipulation -------------------------------------------------------=

dashboard_data <- cleaned_data %>% 
  
  create_state_column() %>% 
  
  mutate(
    
    # Create colloquial/non-scientific name for each species
    simpleName = case_when(
      scientificName %in% c(
        "Oryctolagus cuniculus",
        "Oryctolagus cuniculus cuniculus"
        )                                        ~ "European Rabbit",
      scientificName %in% c(
        "Vulpes vulpes",
        "Vulpes vulpes vulpes")                  ~ "European Red Fox",
      scientificName == "Rhinella marina"        ~ "Cane Toad",
      scientificName == "Felis catus"            ~ "Feral Cat",
      scientificName == "Equus (Equus) caballus" ~ "Feral Horse",
      scientificName %in% c(
        "Sus scrofa",
        "Sus scrofa domesticus"
        )                                        ~ "Feral Pig",
      scientificName == "Solenopsis invicta"     ~ "Red Imported Fire Ant"
      ),
    
    # Create month column
    month = eventDate %>% 
      as_date() %>% 
      month()
    )





# Save Dashboard Data -----------------------------------------------------------

dashboard_data %>% 
  write_csv(
    here(
      "processed_data",
      "dashboard_data.csv"
    )
  )