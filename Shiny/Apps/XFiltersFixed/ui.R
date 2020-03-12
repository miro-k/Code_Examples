# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

UI <- fluidPage(

    sidebarLayout(

        sidebarPanel( # ==================================================================

            fileInput(
                inputId = "datafile",
                label = "Select a data file"),

            checkboxInput(
                inputId = "chk_filters_enabled",
                label = "Turn filters on",
                value = FALSE),

            conditionalPanel(
                condition = "input.chk_filters_enabled",

                checkboxInput(
                    inputId = "chk_filter_1",
                    label = "id_group",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_1",
                    uiOutput(outputId = "filter_1")
                ),

                checkboxInput(
                    inputId = "chk_filter_2",
                    label = "id_row",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_2",
                    uiOutput(outputId = "filter_2")
                ),

                checkboxInput(
                    inputId = "chk_filter_3",
                    label = "x_date",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_3",
                    uiOutput(outputId = "filter_3")
                ),

                checkboxInput(
                    inputId = "chk_filter_4",
                    label = "x_numeric",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_4",
                    uiOutput(outputId = "filter_4")
                ),

                checkboxInput(
                    inputId = "chk_filter_5",
                    label = "x_factor",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_5",
                    uiOutput(outputId = "filter_5")
                ),

                checkboxInput(
                    inputId = "chk_filter_6",
                    label = "x_logical",
                    value = FALSE),

                conditionalPanel(
                    condition = "input.chk_filter_6",
                    uiOutput(outputId = "filter_6")
                )
            )
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
