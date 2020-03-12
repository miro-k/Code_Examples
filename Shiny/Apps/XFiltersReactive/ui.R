# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

UI <- fluidPage(
    
    # theme = shinytheme("flatly"),
    # theme = shinytheme("darkly"),
    theme = shinytheme("cerulean"),
    
    titlePanel( h1("Reactive data filters", align = "left") ),

    sidebarLayout(

        sidebarPanel( # ==================================================================
                      
            fileInput(
                inputId = "data_file",
                label = "Select a data file",
                width = "75%"),

            uiOutput(outputId = "filter_1"),
            uiOutput(outputId = "filter_2"),
            uiOutput(outputId = "filter_3"),
            uiOutput(outputId = "filter_4"),
            uiOutput(outputId = "filter_5"),
            uiOutput(outputId = "filter_6")
        ),

        mainPanel( # =====================================================================
            tabsetPanel(
                tabPanel(
                    title = "Data Table",
                    checkboxInput(
                        inputId = "display_data",
                        label = "Display the data",
                        value = FALSE),
                    textOutput(
                        outputId = "nodata_msg"),
                    br(),
                    DT::dataTableOutput(
                        outputId = "data_tbl")
                ),
                tabPanel(
                    title = "Summary Statistics",
                    checkboxInput(
                        inputId = "display_sumstats",
                        label = "Display summary stats",
                        value = FALSE),
                    textOutput(
                       outputId = "nostats_msg"),
                    DT::dataTableOutput(
                        outputId = "summary_tbl")
                )
            )
        )
    )
) # End of UI function
