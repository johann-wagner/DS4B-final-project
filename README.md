# DS4B-final-project

## Purpose
This is a repository to store the R Codebase used to produce the Final Project for DS4B 2023. The details of the Assignment instructions are further down this README.md file.

## Project Management using GitHub
-   [GitHub Issues](https://github.com/johann-wagner/DS4B-final-project/issues) were used to manage and implement new features and documentation.
-   GitHub Branching was used for most major Issues (see [Branch History](https://github.com/johann-wagner/DS4B-final-project/blob/main/README.md#branch-history) below).
-   GitHub Releases were used to distinguish major developments of the RShiny App.
-   GitHub Projects and Milestones were used to manage work timelines [Data Science for Biologists (DS4B)](https://github.com/users/johann-wagner/projects/2).

## Repository Content

-   The [invasive_species_dashboard](https://github.com/johann-wagner/DS4B-final-project/tree/main/invasive_species_dashboard) folder contains the entire self-contained RShiny dashboard codebase and data.
-   The [processed_data](https://github.com/johann-wagner/DS4B-final-project/tree/main/processed_data) folder includes:
  - A [data_cleaning.Rmd](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/data_cleaning.Rmd) file, which showcases the data cleaning thought process and highlights some of the initial data issues with the raw data.
  - There are also several .csv files, including:
    - [tidied_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/tidied_data.csv) is the binded rows of the raw data.
    - [cleaned_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/cleaned_data.csv) is the cleaned data, which removed the excluded data.
    - [dashboard_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/dashboard_data.csv) is the cleaned data with a few extra columns.
    - [excluded_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/excluded_data.csv) is the excluded data which were identified in [data_cleaning.Rmd](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/data_cleaning.Rmd).

## The Brief
Your task is to:

-  choose a dataset or combination of datasets
-  develop some questions/aims related to that dataset, including appropriate background research
-  use R to address those questions/aims
-  write your findings into a report of up to 2000 words and 10 figures
-  summarise your findings in a poster which you will present in the week 12 workshop

Ideally, you should choose a combination of dataset and questions/aims that are interesting to you, because the more interesting you find it, the better your work will be!

## Branch History
Version control using Git was trialed for this assignment, as I wanted to learn more about the uses of Pull Requests and Merging Branches. I used SourceTree to visualise all of my commits/pushes/branch merges.

...
