# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

UI <- fluidPage(

    # theme = shinytheme("flatly"),
    # theme = shinytheme("darkly"),
    # theme = shinytheme("cerulean"),

    titlePanel(
        h1(strong("NoteMiner", em("Interactive", style = "color: #ec7063;")),
           align = "left",
           style = "font-size:50px; color:  #1f618d ; font-family: 'Georgia', serif;")
    ),

    sidebarLayout(

        sidebarPanel( # ==================================================================

            selectInput(
                inputId = "data_source",
                label = NULL,
                choices = c("Select your data source" = "",
                            "Connect to a database" = "database_connection",
                            "Open a data file" = "open_data_file"),
                selected = " ",
                width = "350px",
                multiple = FALSE
            ),

            conditionalPanel(
                condition = "input.data_source =='database_connection'",

                dateRangeInput(
                    inputId = "select_itrds_records",
                    label = "Select ITRDS records between two dates",
                    separator = "to",
                    width = "350px")
            ),

            conditionalPanel(
                condition = "input.data_source =='open_data_file'",

                fileInput(
                    inputId = "data_file",
                    label = NULL,
                    width = "350px"),

                uiOutput(outputId = "select_vars_to_keep")
            ),

            "Select data filters",
            br(),
            br(),

            materialSwitch(
                inputId = "chk_filter_1",
                label = "id_group",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_1",
                uiOutput(outputId = "filter_1")
            ),

            materialSwitch(
                inputId = "chk_filter_2",
                label = "id_row",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_2",
                uiOutput(outputId = "filter_2")
            ),

            materialSwitch(
                inputId = "chk_filter_3",
                label = "x_date",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_3",
                uiOutput(outputId = "filter_3")
            ),

            materialSwitch(
                inputId = "chk_filter_4",
                label = "x_numeric",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_4",
                uiOutput(outputId = "filter_4")
            ),

            materialSwitch(
                inputId = "chk_filter_5",
                label = "x_factor",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_5",
                uiOutput(outputId = "filter_5")
            ),

            materialSwitch(
                inputId = "chk_filter_6",
                label = "x_logical",
                value = FALSE,
                right = TRUE,
                status = "primary"),

            conditionalPanel(
                condition = "input.chk_filter_6",
                uiOutput(outputId = "filter_6")
            ),

            br(),

            downloadButton("btn_download_data", "Download the Data")
        ),

        mainPanel( # =====================================================================

            tabsetPanel(

                tabPanel(
                    title = "Data Table",

                    br(),

                    materialSwitch(
                        inputId = "display_data",
                        label = "Display the data",
                        value = FALSE,
                        right = TRUE,
                        status = "primary"),

                    textOutput(
                        outputId = "nodata_msg"),

                    br(),

                    DT::dataTableOutput(
                        outputId = "data_tbl")
                ),

                tabPanel(
                    title = "Summary Statistics",

                    br(),

                    materialSwitch(
                        inputId = "display_sumstats",
                        label = "Display summary stats",
                        value = FALSE,
                        right = TRUE,
                        status = "primary"),

                    textOutput(
                       outputId = "nostats_msg"),

                    DT::dataTableOutput(
                        outputId = "summary_tbl")
                ),

                tabPanel(
                    title = "Pattern Search",

                    br(),
                    uiOutput(outputId = "text_selection"),

                    br(),
                    materialSwitch(
                        inputId = "chk_add_language_indicator",
                        label = "Add an indicator for French/English?",
                        value = FALSE,
                        right = TRUE,
                        status = "primary"),

                    materialSwitch(
                        inputId = "chk_add_pattern_matches",
                        label = "Add a column of pattern matches?",
                        value = FALSE,
                        right = TRUE,
                        status = "primary",
                        width = "100%"),

                    materialSwitch(
                        inputId = "chk_ignore_case",
                        label = "Is the pattern case-sensitive?",
                        value = FALSE,
                        right = TRUE,
                        status = "primary"),

                    br(),

                    selectInput(
                        inputId  = "pattern_choices",
                        label = NULL,
                        choices = c("Select from pre-defined patterns" = "",
                                    all_regex_patterns),
                        selected = "",
                        width = "500px",
                        multiple = TRUE
                    ),

                    br(),

                    textAreaInput( inputId = "custom_regex",
                                   label = NULL,
                                   value = NULL,
                                   width = "750px",
                                   height = "150px",
                                   placeholder = "Type your regex here" )
                ),

                tabPanel(
                    title = "TESTS",

                    htmlOutput("str_final_regex", style = "font-family: Consolas; font-size:125%"),
                    br()

                )
            )
        )
    )
) # End of UI function
