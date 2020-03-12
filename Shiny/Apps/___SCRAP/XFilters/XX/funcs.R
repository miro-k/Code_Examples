
assign_filter_value <- function(df_varname, varname) {
   if (class(df_varname) == "factor" ) {
      selectInput(inputId = "filter_value_selector",
                  label = varname,
                  choices = levels(df_varname),
                  selected = levels(df_varname),
                  multiple = TRUE)
   } else if (class(df_varname) == "logical" ) {
      selectInput(inputId = "filter_value_selector",
                  label = varname,
                  choices = c(TRUE, FALSE),
                  selected = "",
                  multiple = FALSE)
   } else if (class(df_varname) == "numeric") {
      sliderInput(inputId = "filter_value_selector",
                  label = varname,
                  min = min(df_varname),
                  max = max(df_varname),
                  value = c(min, max))
   } else if ((class(df_varname)) == "Date") {
      dateRangeInput(inputId = "filter_value_selector",
                     label = varname,
                     min = min(df_varname),
                     max = max(df_varname),
                     start = min(df_varname),
                     end = max(df_varname))
   } else {
      textInput(inputId = "filter_value_selector",
                label = varname,
                value = "")
   }
}


apply_filter <- function(check_filter, df, varname, filter_value) {
      if (check_filter){
         if (class(df[[varname]]) == "factor") {
            df %>% filter(!!sym(varname) %in% filter_value)
         } else if (class(df[[varname]]) == "logical") {
            df %>% filter(!!sym(varname) == filter_value)
         } else if (class(df[[varname]]) == "numeric") {
            df %>% filter(between(!!sym(varname), filter_value[1], filter_value[2]))
         } else if (class(df[[varname]]) == "Date") {
            df %>% filter(between(!!sym(varname), filter_value[1], filter_value[2]))
         } else if (class(df[[varname]]) == "character" & filter_value != "") {
            df %>% filter(!!sym(varname) == filter_value)
         } else {
            df
         }
      } else {
         df
      }
}



# rm(list = ls())
# dat <- readRDS("~/pCloud_Sync_offline/Code_Examples/Data/test_data.rds")
# assign_filter_value(dat, "x_numeric")
