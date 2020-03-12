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
appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps", "XFiltersReactive", "Archive")

# rootdir <- file.path("F:")
# datadir <- file.path(rootdir, "Code_Examples", "Data")
# appsdir <- file.path(rootdir, "Code_Examples", "Shiny", "Apps")

source(paste(appsdir, "XFilters", "ui.R", sep = "/"))
source(paste(appsdir, "XFilters", "server.R", sep = "/"))
source(paste(appsdir, "XFilters", "funcs.R", sep = "/"))

shinyApp(ui = UI, server = SERVER)


# runApp(paste(appsdir, "XFilters", sep = "/")) # Execute from R console

# https://stackoverflow.com/questions/35624413/remove-search-option-but-leave-search-columns-option
# https://stackoverflow.com/questions/31887230/what-is-the-fastest-way-and-fastest-format-for-loading-large-data-sets-into-r
# https://github.com/ggrothendieck/sqldf
# https://appsilon.com/fast-data-loading-from-files-to-r/
# https://bookdown.org/csgillespie/efficientR/input-output.html
# https://github.com/tidymodels/parsnip
# https://stackoverflow.com/questions/24175997/force-no-default-selection-in-selectinput

# Search: executing python code from inside R/Shiny app
# https://rviews.rstudio.com/2018/04/17/reticulated-shiny/
# https://stackoverflow.com/questions/48219732/pass-a-string-as-variable-name-in-dplyrfilter
# https://suzan.rbind.io/2018/02/dplyr-tutorial-3/

