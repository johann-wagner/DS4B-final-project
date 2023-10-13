### ############################################################################
### ############################################################################
###                                                                          ###
### DS4B-FINAL-PROJECT: SETUP AND CONGFIGURATION                             ###
###                                                                          ###
### ############################################################################
### ############################################################################





# Packages ---------------------------------------------------------------------

### Tidyverse Collection -----------------------------------------------------
# The tidyverse is an opinionated collection of R packages designed for
# data science. All packages share an underlying design philosophy, grammar,
# and data structures.
### https://www.tidyverse.org/
library(tidyverse)



### Data Exploration ---------------------------------------------------------
# To easily display summary statistics
### https://github.com/ropensci/skimr
library(skimr)



### Data Cleaning/Wrangling --------------------------------------------------
# To easily examine and clean dirty data
### https://www.rdocumentation.org/packages/janitor/versions/2.2.0
library(janitor)

# To easily use date-time data
### https://lubridate.tidyverse.org/
library(lubridate)

# To easily handle categorical variables using factors.
### https://forcats.tidyverse.org/
library(forcats)

# To easily interprete strings that are small, fast, and dependency-free
### https://glue.tidyverse.org/
library(glue)



### Data Visualisation -------------------------------------------------------
# To easily use already-made themes for data visualisation
### https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/
library(ggthemes)

# To combine a scatter plot and a 2D density plot
### https://github.com/LKremer/ggpointdensity
library(ggpointdensity)

# To scale and convert data values to perceptual properties
### https://scales.r-lib.org/
library(scales)

# To easily combine simple Markdown and HTML rendering for ggplot2
### https://github.com/wilkelab/ggtext
library(ggtext)



### Spatial Visualisation ----------------------------------------------------
# To easily manipulate spatial data
### https://r-spatial.github.io/sf/
library(sf)

# This may take a little while to install if you don't have absmapsdata already.
# Whilst I'm only using one shapefile from the package, I thought acquiring
# the data through a package would be more standardised/reproducible than
# downloading it straight from the ABS.
options(timeout = 1000)
devtools::install_github("wfmackey/absmapsdata")
# To easily access the Australian Bureau of Statistics (ABS) spatial structures
### https://github.com/wfmackey/absmapsdata
library(absmapsdata)

# To easily interact spatial data and ggplot2
### https://paleolimbot.github.io/ggspatial/
library(ggspatial)



### Misc ---------------------------------------------------------------------
# To easily standardise naming conventions based upon a consistent design
# philosophy
### https://github.com/Tazinho/snakecase
library(snakecase)

# To locate and download species observations from the Atlas of Living
# Australia
### https://galah.ala.org.au/
library(galah)

# To easily enable file referencing in project-oriented workflows
### https://here.r-lib.org/
library(here)





# Custom Functions --------------------------------------------------------


## load_galah_occurrence_data --------------------------------------------
### Purpose:
# To load the species occurrence data of any given species within the Atlas
# of Living Australia database.
source(
  here::here(
    "scripts",
    "custom_functions",
    "load_galah_occurrence_data.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)



## create_state_column -----------------------------------------------------
### Purpose:
# To create a state column indicating which state each occurrence observation
# was recorded in based on the spatial longitude and latitude data.
source(
  here::here(
    "scripts",
    "custom_functions",
    "create_state_column.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)



## add_na_date_to_excluded_data --------------------------------------------
### Purpose:
# To add NA values from the eventDate column into the excluded data dataset.
# Note: This does not remove/filter any data from the input data, this only
#       adds data to the excluded_data dataset.
source(
  here::here(
    "scripts",
    "custom_functions",
    "add_na_date_to_excluded_data.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)



## add_na_spatial_to_excluded_data -----------------------------------------
### Purpose:
# To add NA values from the decimalLatitude and decimalLongitude columns into
# the excluded data dataset.
# Note: This does not remove/filter any data from the input data, this only
#       adds data to the excluded_data dataset.
source(
  here::here(
    "scripts",
    "custom_functions",
    "add_na_spatial_to_excluded_data.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)



## add_not_within_abs_map_to_excluded_data ---------------------------------
### Purpose:
# To add NA values from the derived state column into the excluded data dataset.
# Note: This does not remove/filter any data from the input data, this only
#       adds data to the excluded_data dataset.
source(
  here::here(
    "scripts",
    "custom_functions",
    "add_not_within_abs_map_to_excluded_data.R"
  ),
  echo = TRUE,
  max.deparse.length = 1e4
)






# Provide Valid Email -----------------------------------------------------

# Ref [1]
# Use an Atlas of Australia-registered email (Register at ala.org.au)
galah_config(email = "johann.wagner@gmail.com")

# References:
# - [1] https://labs.ala.org.au/posts/2023-05-16_dingoes/post.html
