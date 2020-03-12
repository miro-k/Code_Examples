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
appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps")

# rootdir <- file.path("F:")
# datadir <- file.path(rootdir, "Code_Examples", "Data")
# appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps")

source(paste(appsdir, "XNoteMiner", "regex_ptrns.R", sep = "/"))
source(paste(appsdir, "XNoteMiner", "ui.R", sep = "/"))
source(paste(appsdir, "XNoteMiner", "server.R", sep = "/"))

shinyApp(ui = UI, server = SERVER)





# ********************************************************************************************************
# ********************************************************************************************************
# ********************************************************************************************************

# df <- readRDS(paste(datadir, "test_data_01.rds", sep = "/")) %>%
#     mutate(x_factor = recode(x_factor, Categ.A = "A", Categ.B = "B", Categ.C = "C"))
#
# saveRDS(df, paste(datadir, "fake_dataset.rds", sep = "/"))

