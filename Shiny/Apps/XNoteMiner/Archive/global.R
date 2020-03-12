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

source(paste(appsdir, "XNoteminer", "regex_ptrns.R", sep = "/"))
source(paste(appsdir, "XNoteminer", "ui.R", sep = "/"))
source(paste(appsdir, "XNoteminer", "server.R", sep = "/"))


shinyApp(ui = UI, server = SERVER)





# ********************************************************************************************************
# ********************************************************************************************************
# ********************************************************************************************************



# rm(list = ls())
# df <- readRDS(paste(datadir, "test_data_01.rds", sep = "/"))
# df2 %>% tbl_str()
#
# df2 <- df %>%
#     mutate( x_factor = recode(x_factor, Categ.A = "A", Categ.B = "B", Categ.C = "C") )
#
#
# packageDescription("mcf")
# ls(package:mcf)
#
# saveRDS(df2, paste(datadir, "fake_dataset.rds", sep = "/"))


# tbl_freq() =============================================================================

# Return(s): a distribution table (counts, proportions, cumulative proporitions) in the
# form of a data frame.

# Argument(s): x = a vector, use_na = {"no", "ifany", "always"}, round_to = number of
# digits to round the proportions to.

# tbl_freq <- function( x,
#                       use_na = "ifany",
#                       round_to = 3,
#                       sort_by = "freq"
# ) {
#
#     freq  <- table(x, useNA = use_na)
#     categ <- ifelse(is.na(rownames(freq)), "_NA", rownames(freq))
#     prop  <- round(prop.table(freq), round_to)
#
#     out <- data.frame(categ, cbind(freq, prop),
#                       row.names = NULL,
#                       stringsAsFactors = FALSE)
#
#     #out <- out[order(out$categ, decreasing = FALSE), ]
#     if (sort_by == "freq") {
#         out <- out[order(out["freq"], decreasing = TRUE), ]
#     } else {
#         out <- out[order(out["categ"], decreasing = FALSE), ]
#     }
#
#     out <- data.frame(out, cum_freq = cumsum(out$freq), cum_prop = cumsum(out$prop))
#
#     options(width = 10000); print.data.frame(out, row.names = FALSE)
#     invisible(out)
# }


# # Examples
#
# df <- data.frame( x = c("a", NA, NA,"b","b","c"),
#                   y = c("d","e","d", NA,"d","e"),
#                   z = c("f","f", NA, NA,"g","g") )
#
# # Input is a single vector, output is a data frame
# tbl_freq(df$x, use_na = "always", round_to = 3)
#
# # Input is a data frame, output is a list of sub-lists of data frames
# tlist <- lapply(df, tbl_freq, use_na = "ifany", round_to = 3)
# str(tlist [1])  # This is a sub-list
# str(tlist[[1]]) # This is a data frame
# DT::datatable(tlist[[1]]) # DT package requires data frames
