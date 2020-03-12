# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# global.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rm(list = ls())

# Load all required packages

lapply(c("mcf",
         "data.table",
         "DT",
         "stringr",
         "tidyverse",
         "magrittr",
         "reactlog",
         "shiny",
         "shinyjs",
         "shinythemes"), library, character.only = TRUE)

# Load 'gapminder' package to get Gapminder data frame

library("gapminder")
# gapminder %>% tbl_str()
# levels(gapminder$continent)

# Load 'ggplot2' package
library("ggplot2")

# Load "colorpicker" package
library("colourpicker")

# Load "plotly" package
library("plotly")

# Define path to the Shiny app directory

appsdir <- file.path("C:", "Users", "MK", "Documents", "pCloud_Sync_offline",
                     "Code_Examples", "Shiny", "Apps")

# Execute code in the following external files

source( paste(appsdir, "XDataExplore", "ui.R", sep = "/") )
source( paste(appsdir, "XDataExplore", "server.R", sep = "/") )

# Run the app

shinyApp(ui = UI, server = SERVER)


#runApp(paste(appsdir, "XDataExplore", sep = "/"))
#setwd(appsdir); runApp("XDataExplore")


