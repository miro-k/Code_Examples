# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# server.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


SERVER <- function(input, output) {

    df1 <- reactive({
        if (nodata() == FALSE) {
            readRDS(input$data_file$datapath)
        }
    })

    df2 <- reactive({
        df1()
    })

    nodata <- reactive({
        is.null(input$data_file)
    })

    output$nodata_msg <- reactive({
        if (nodata() == TRUE & input$display_data == TRUE) {
            "No data has yet been uploaded."
        }
    })

    output$nostats_msg <- reactive({
        if (nodata() == TRUE & input$display_sumstats == TRUE) {
            "No data has yet been uploaded."
        }
    })

    varnames <- reactive({
        names(df2())
    })

    # varnames <- reactive({
    #
    #     vn <- names(df2())
    #
    #     if (input$chk_add_language_indicator) {
    #         vn <- c(vn, "language")
    #     }
    #
    #     if (input$chk_add_pattern_matches) {
    #         vn <- c(vn, "pattern_match")
    #     }
    #
    #     return(vn)
    #
    # })

    output$select_vars_to_keep <- renderUI({
        selectInput(
            inputId = "var_selection",
            label = NULL,
            choices = c("Select variables to keep" = "",
                        varnames()),
            selected = NULL,
            width = "500px",
            multiple = TRUE)
    })

    output$filter_1 <- renderUI({
        selectInput(
            inputId = "filter_1_value",
            label = NULL,
            choices = unique(df2()[["id_group"]]),
            selected = NULL,
            multiple = TRUE,
            width = "500px")
    })

    output$filter_2 <- renderUI({
        selectInput(
            inputId = "filter_2_value",
            label = NULL,
            choices = unique(df2()[["id_row"]]),
            selected = NULL,
            multiple = TRUE,
            width = "500px")
    })

    output$filter_3 <- renderUI({
        dateRangeInput(
            inputId = "filter_3_value",
            label = NULL,
            min = min(df2()[["x_date"]]),
            max = max(df2()[["x_date"]]),
            start = min(df2()[["x_date"]]),
            end = max(df2()[["x_date"]]),
            separator = "",
            width = "350px")
    })

    output$filter_4 <- renderUI({
        numericRangeInput(
            inputId = "filter_4_value",
            label = NULL,
            value = c(min(df2()[["x_numeric"]]), max(df2()[["x_numeric"]])),
            separator = "",
            width = "350px")
    })

    output$filter_5 <- renderUI({
        selectInput(
            inputId = "filter_5_value",
            label = NULL,
            choices = levels(df2()[["x_factor"]]),
            selected = NULL,
            multiple = TRUE,
            width = "350px")
    })

    output$filter_6 <- renderUI({
        selectInput(
            inputId = "filter_6_value",
            label = NULL,
            choices = unique(df2()[["x_logical"]]),
            selected = NULL,
            multiple = TRUE,
            width = "350px")
    })

    df3 <- reactive({

        df <- df2()

        if (!is.null(input$var_selection)) {
            df <- select(df, input$var_selection)
        }

            if (input$chk_filter_1 & !is.null(input$filter_1_value)) {
                df <- filter(df, id_group %in% input$filter_1_value)
            }
            if (input$chk_filter_2 & !is.null(input$filter_2_value)) {
                df <- filter(df, id_row %in% input$filter_2_value)
            }
            if (input$chk_filter_3 & !is.null(input$filter_3_value)) {
                df <- filter(df, between(x_date,
                                         input$filter_3_value[1],
                                         input$filter_3_value[2]))
            }
            if (input$chk_filter_4 & !is.null(input$filter_4_value)) {
                df <- filter(df, between(x_numeric,
                                         input$filter_4_value[1],
                                         input$filter_4_value[2]))
            }
            if (input$chk_filter_5 & !is.null(input$filter_5_value)) {
                df <- filter(df, x_factor %in% input$filter_5_value)
            }
            if (input$chk_filter_6 & !is.null(input$filter_6_value)) {
                df <- df %>% filter(x_logical %in% input$filter_6_value)
            }

        if (input$chk_add_language_indicator) {
            df <- mutate(df, language = "")
        }



        if (input$chk_add_pattern_matches) {

            if (!is.null(final_regex()) & (!is.null(input$select_text))) {
                df <- mutate(df,
                             pattern_match = str_extract_all(
                                 !!sym(input$select_text),
                                 regex(pattern = final_regex(), ignore_case = input$chk_ignore_case)
                                 ) %>%
                                 lapply(., paste, collapse = ", ") %>%
                                 as.character())
            } else {
                df <- df
            }
        }


        return(df)
    })


    output$text_selection <- renderUI({
        selectInput(
            inputId  = "select_text",
            label = NULL,
            choices = c("Select column of texts" = "",
                        names(df2())),
            selected = "",
            width = "500px",
            multiple = FALSE
        )
    })

    output$data_tbl <- DT::renderDataTable({
        if (input$display_data == TRUE) {
            DT::datatable(
                data = df3(),
                rownames = FALSE,
                filter = "none",
                options = list(
                    scrollX = TRUE,
                    scrollY = TRUE,
                    pageLength = 7,
                    lengthMenu = c(7, 10, 15, 20, nrow(df3())),
                    searching = FALSE),
                fillContainer = TRUE)
        }
    })

    sumstats <- reactive({
        if (nodata() == FALSE) {
            mcf::tbl_str(df3())
        }
    })

    output$summary_tbl <- DT::renderDataTable({
        if (input$display_sumstats == TRUE) {
            DT::datatable(
                caption = "Summary stats for the current data file",
                data = sumstats(),
                rownames = FALSE,
                colnames = c("Col. #",
                             "Variable",
                             "Class",
                             "Total obs.",
                             "Missing obs.",
                             "Unique values",
                             "Examples"),
                filter = "none",
                options = list(dom = "t",
                               autoWidth = FALSE,
                               width = "100px"))
        }
    })


    output$btn_download_data <- downloadHandler(
        filename = function() {
            paste0("extract-", Sys.Date())
        },
        content = function(file) {
            write.csv(df3(), file, row.names = FALSE)
        },
        contentType = NA
    )


    # ***************************************************************************************************************************

    final_regex <- reactive({
        if (is.null(input$pattern_choices) & input$custom_regex == "") {
            NULL
        } else if (!is.null(input$pattern_choices) & input$custom_regex == "") {
            paste(paste0("(", input$pattern_choices, ")"), collapse = "|")
        } else if (is.null(input$pattern_choices) & !input$custom_regex == "") {
            input$custom_regex
        } else if (!is.null(input$pattern_choices) & !input$custom_regex == "") {
            paste(paste(paste0("(", input$pattern_choices, ")"), collapse = "|"),
                  paste0("(", input$custom_regex, ")"), sep = "|")
        } else {
            "Error"
        }
    })



    ### FOR TESTING PURPOSES
    #
    output$str_final_regex <- renderUI({
       final_regex()
    })
    #


} # End of SERVER function







