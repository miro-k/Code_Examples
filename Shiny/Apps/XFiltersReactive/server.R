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

    output$filter_1 <- renderUI({
        selectInput(
            inputId = "filter_1_value",
            label = "id_group",
            choices = unique(df2()[["id_group"]]),
            selected = NULL,
            multiple = TRUE,
            width = "75%")
    })

    output$filter_2 <- renderUI({
        selectInput(
            inputId = "filter_2_value",
            label = "id_row",
            choices = unique(df2()[["id_row"]]),
            selected = NULL,
            multiple = TRUE,
            width = "75%")
    })

    output$filter_3 <- renderUI({
        dateRangeInput(
            inputId = "filter_3_value",
            label = "x_date",
            min = min(df2()[["x_date"]]),
            max = max(df2()[["x_date"]]),
            start = min(df2()[["x_date"]]),
            end = max(df2()[["x_date"]]),
            separator = "",
            width = "50%")
    })

    output$filter_4 <- renderUI({
        numericRangeInput(
        inputId = "filter_4_value",
        label = "x_numeric",
        value = c(min(df2()[["x_numeric"]]), max(df2()[["x_numeric"]])),
        width = "50%")
    })

    output$filter_5 <- renderUI({
        selectInput(
            inputId = "filter_5_value",
            label = "x_factor",
            choices = levels(df2()[["x_factor"]]),
            selected = NULL,
            multiple = TRUE,
            width = "50%")
    })

    output$filter_6 <- renderUI({
        selectInput(
            inputId = "filter_6_value",
            label = "x_logical",
            choices = unique(df2()[["x_logical"]]),
            selected = NULL,
            multiple = TRUE,
            width = "50%")
    })

    df3 <- reactive({

        df <- df2()
        
        
        if (!is.null(df)) {

            if (!is.null(input$filter_1_value)) {
                df <- filter(df, id_group %in% input$filter_1_value)
            }
        
            if (!is.null(input$filter_2_value)) {
                df <- filter(df, id_row %in% input$filter_2_value)
            }
        
            if (!is.null(input$filter_3_value[1]) & !is.null(input$filter_3_value[2])) {
                df <- filter(df, between(x_date,
                                         input$filter_3_value[1],
                                         input$filter_3_value[2]))
            }
        
            if (!is.null(input$filter_4_value)) {
                df <- filter(df, between(x_numeric,
                                         input$filter_4_value[1],
                                         input$filter_4_value[2]))
            }
        
            if (!is.null(input$filter_5_value)) {
                df <- filter(df, x_factor %in% input$filter_5_value)
            }
        
            if (!is.null(input$filter_6_value)) {
                df <- df %>% filter(x_logical %in% input$filter_6_value)
            }
        }
        
        return(df)
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
                options = list(dom = "t"))
        }
    })

} # End of SERVER function


