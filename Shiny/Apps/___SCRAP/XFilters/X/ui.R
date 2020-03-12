# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R: Function UI defined here
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

is.odd <- function(x) x %% 2 != 0

UI <- fluidPage(

   # theme = shinytheme("flatly"),
   # theme = shinytheme("darkly"),
   # theme = shinytheme("cerulean"),

   titlePanel(em("On-Demand Data Filters")),

   sidebarLayout(

      sidebarPanel( # --------------------------------------------------------------------
         #
         radioButtons(inputId = "data_source",
                      label = "Select a data source",
                      inline = TRUE,
                      choices = c("Connect to ITRDS" = "itrds",
                                  "Open a data file" = "open_file"),
                      selected = character(0)
                      ),
         #
         conditionalPanel(
            condition = "input.data_source == 'itrds'",
            dateRangeInput(inputId = "itrds_obs",
                           label = "Select ITRDS data")
         ),
         # If data_source = 'open_file', the 'datafile' input will open
         conditionalPanel(
            condition = "input.data_source == 'open_file'",
            fileInput(inputId = "datafile",
                      label = "Select a data file")
         ),
         #
         checkboxInput(inputId = "select_vars",
                       label = "Select variables to keep",
                       value = FALSE ),
         # If select_vars = TRUE, multiple selection from variable names will appear
         conditionalPanel(
            condition = "input.select_vars",
            uiOutput("vars")
         ),
         #
         checkboxInput(inputId = "filter_obs",
                       label = "Filter observations",
                       value = FALSE ),
         # If filter_obs == TRUE, you can select one or more variables to use as filters
         conditionalPanel(
            condition = "input.filter_obs",
            actionButton("action", label = "Action"),
            br(),
            uiOutput("filterset")
         ),
         #
         conditionalPanel(
            condition = "input.obsfilters != '' & input.filter_obs",
            uiOutput("ffactor")
         ),
         #
         checkboxInput(inputId = "search_pattern",
                       label = "Search for patterns in the text",
                       value = FALSE ),
         #
         conditionalPanel(
            condition = "input.search_pattern",
            "ALL REGEX SEARCH DIALOGS WILL BE HERE"
         )
      ),

      mainPanel( # -----------------------------------------------------------------------
         #
         tabsetPanel(
            #
            tabPanel(
               title = "Data Table",
               checkboxInput( inputId = "display_data",
                              label = "Display the data",
                              value = FALSE ),
               br(),
               textOutput(outputId = "no_data_msg"),
               DT::dataTableOutput(outputId = "data_tbl")
            ),
            #
            tabPanel(
               title = "Summary Statistics",
               checkboxInput( inputId = "display_sumstats",
                              label = "Display summary stats",
                              value = FALSE ),
               br(),
               textOutput(outputId = "no_sumstats_msg"),
               DT::dataTableOutput(outputId = "summary_tbl")
            ),
            #
            tabPanel(
               title = "Text Patterns Analysis",
               textOutput("obsfilters"),
               br(),
               textOutput("filter_val"),
               br(),
               textOutput("action")

            )
         )
      )
   )
)
