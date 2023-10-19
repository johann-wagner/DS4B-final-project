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

# To easily repel overlapping text labels
### https://ggrepel.slowkow.com/
library(ggrepel)



### Spatial Visualisation ----------------------------------------------------
# To easily manipulate spatial data
### https://r-spatial.github.io/sf/
library(sf)

# This may take a little while to install if you don't have absmapsdata already.
# Whilst I'm only using one shapefile from the package, I thought acquiring
# the data through a package would be more standardised/reproducible than
# downloading it straight from the ABS.
options(timeout = 1000)
# devtools::install_github("wfmackey/absmapsdata")
# To easily access the Australian Bureau of Statistics (ABS) spatial structures
### https://github.com/wfmackey/absmapsdata
library(absmapsdata)

# To easily interact spatial data and ggplot2
### https://paleolimbot.github.io/ggspatial/
library(ggspatial)



### RShiny ------------------------------------------------------------------

# To easily build interactive web applications with R
### https://shiny.posit.co/
library(shiny)

# To easily publish your Shiny apps
### https://rstudio.github.io/rsconnect/
library(rsconnect)

# To easily display R data objects as tables on HTML pages
### https://rstudio.github.io/DT/
library(DT)

# To easily apply themes to RShiny Apps
### https://github.com/rstudio/shinythemes
library(shinythemes)

# To easily provide modern customizable UI themes and dashboards
### https://rstudio.github.io/bslib/
library(bslib)

# To simplify themeing both RShiny UI and ggplot2 outputs
### https://rstudio.github.io/thematic/
library(thematic)



### Misc ---------------------------------------------------------------------
# To easily enable file referencing in project-oriented workflows
### https://here.r-lib.org/
library(here)