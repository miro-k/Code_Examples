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
         "shinythemes",
         "ggplot2",
         "plotly"), library, character.only = TRUE)

# Load 'shinydashboard' package

library("shinydashboard")

# Define path to the Shiny app directory

appsdir <- file.path("C:", "Users", "MK", "Documents", "pCloud_Sync_offline",
                     "Code_Examples", "Shiny", "Apps")

# Execute code in the following external files

source( paste(appsdir, "XDashboard", "ui.R", sep = "/") )
source( paste(appsdir, "XDashboard", "server.R", sep = "/") )

# Run the app

shinyApp(ui = UI, server = SERVER)

# runApp(paste(appsdir, "XDashboard", sep = "/"))
# setwd(appsdir); runApp("XDashboard")


