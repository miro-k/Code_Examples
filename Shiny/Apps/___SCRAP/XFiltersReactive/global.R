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
datadir <- file.path(rootdir, "Code_Examples", "Data")
appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps", "___SCRAP")

# rootdir <- file.path("F:")
# datadir <- file.path(rootdir, "Code_Examples", "Data")
# appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps")

source(paste(appsdir, "XFiltersReactive", "ui.R", sep = "/"))
source(paste(appsdir, "XFiltersReactive", "server.R", sep = "/"))
#source(paste(appsdir, "XFiltersReactive", "funcs.R", sep = "/"))

shinyApp(ui = UI, server = SERVER)

# df <- readRDS(paste(datadir, "test_data_01.rds", sep = "/"))
# tbl_str(df, n_examples = 0)
# df <- mutate( id_group = as.factor(id_group),
#               id_row = as.factor(id_row) )
# saveRDS(df, paste(datadir, "test_data_02.rds", sep = "/"))
