# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# global.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rm(list = ls())

lapply( c("data.table",
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

# rootdir <- file.path("F:")
# datadir <- file.path(rootdir, "Code_Examples", "Data")


df <- readRDS(paste(datadir, "fake_dataset.rds", sep = "/"))

df %>% tbl_str()


final_regex <- "required|astonished"
#final_regex <- "required"
input_select_text <- "x_text"


df2 <- df %>%
    mutate( pattern_match =
                str_extract_all(!!sym(input_select_text),
                                regex( pattern = final_regex,
                                       ignore_case = TRUE)) %>%
                lapply(., paste, collapse = ", ") %>%
                as.character() )
