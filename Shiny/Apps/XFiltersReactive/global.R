# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# global.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rm(list = ls())

lapply(
   c("data.table",
     "DT",
     "magrittr",
     "mcf",
     "reactlog",
     "shiny",
     "shinyjs",
     "shinythemes",
     "shinyWidgets",
     "stringr",
     "tidyverse"),
   library, character.only = TRUE)

rootdir <- file.path("C:", "Users", "MK", "Documents", "pCloud_Sync_offline")
# rootdir <- file.path("F:")
datadir <- file.path(rootdir, "Code_Examples", "Data")
appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps")

source(paste(appsdir, "XFiltersReactive", "ui.R", sep = "/"))
source(paste(appsdir, "XFiltersReactive", "server.R", sep = "/"))
source(paste(appsdir, "XFiltersReactive", "modules.R", sep = "/"))

shinyApp(ui = UI, server = SERVER)


