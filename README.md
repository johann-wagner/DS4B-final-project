# DS4B-final-project

## RShiny Dashboard
<img width="1196" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/f10b21f2-e92d-4c34-afac-c821fc5d5083">
<img width="1209" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/305aacd1-98be-4e23-ab17-f5464b98a0f5">
<img width="1196" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/b165cfc5-476f-47a1-aa63-1e3e4c081e15">
<img width="1204" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/5c6f498a-81e5-457c-86a8-14829717a331">

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
    - The [data_cleaning.Rmd](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/data_cleaning.Rmd) file, which showcases the data cleaning thought process and highlights some of the initial data issues with the raw data.
    - There are also several .csv files, including:
      - [tidied_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/tidied_data.csv) is the binded rows of the raw data.
      - [cleaned_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/cleaned_data.csv) is the cleaned data, which removed the excluded data.
      - [dashboard_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/dashboard_data.csv) is the cleaned data with a few extra columns.
      - [excluded_data.csv](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/excluded_data.csv) is the excluded data which were identified in [data_cleaning.Rmd](https://github.com/johann-wagner/DS4B-final-project/blob/main/processed_data/data_cleaning.Rmd).

-  The [raw_data](https://github.com/johann-wagner/DS4B-final-project/tree/main/raw_data) folder includes the seven raw data files. The respective DOIs are listed below:
    1.  [European Rabbits (Oryctolagus cuniculus)](https://doi.org/10.26197/ala.d0da2524-838a-4540-a160-fba8088f4850)
    2.  [European Red Foxes (Vulpes vulpes)](https://doi.org/10.26197/ala.5f700174-e92e-4376-a243-be05ffa93f46)
    3.  [Cane Toads (Rhinella marina)](https://doi.org/10.26197/ala.d6d70c2c-00de-4f76-8ea6-598b9562eb64)
    4.  [Feral Cats (Felis catus)](https://doi.org/10.26197/ala.57a58cdc-88c0-45c1-9260-bd17c6fc4b62)
    5.  [Feral Horses (Equus (Equus) caballus)](https://doi.org/10.26197/ala.c3cebb21-c2e0-41d0-8b5d-f446c2914827)
    6.  [Feral Pigs (Sus scrofa)](https://doi.org/10.26197/ala.952aa727-1915-4c3f-8399-ed940c24bfef)
    7.  [Red Imported Fire Ants (Solenopsis invicta)](https://doi.org/10.26197/ala.74b5dd29-4287-473d-8391-9184c8c62554)

-  The [screenshots](https://github.com/johann-wagner/DS4B-final-project/tree/main/screenshots) folder contains .png files that are used in [final_project.Rmd](https://github.com/johann-wagner/DS4B-final-project/blob/main/final_project.Rmd)

-  The [scripts](https://github.com/johann-wagner/DS4B-final-project/tree/main/scripts) folder contains .R files that load, clean, wrangle, manipulate, and visualise the raw data.
    -  The [custom-functions](https://github.com/johann-wagner/DS4B-final-project/tree/main/scripts/custom_functions) sub-folder contains a bunch of .R files that are functions used in the main .R files.

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

<img width="1055" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/0014bead-a402-4076-a1e9-bcfbd0853e15">

<img width="1055" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/0fe334b6-5cae-4fe8-879b-c15ed2c23dd5">

<img width="1052" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/ed3600e3-e3de-4ac2-8415-1066a2343995">

<img width="1055" alt="image" src="https://github.com/johann-wagner/DS4B-final-project/assets/103425902/c7874577-d2f4-4535-8926-e53452a224fc">

