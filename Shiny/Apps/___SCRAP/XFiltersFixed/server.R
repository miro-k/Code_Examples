# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# server.R: Function SERVER defined here
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


SERVER <- function(input, output) {
    dat1 <- reactive({
        if (nodata() == FALSE) {
            readRDS(input$datafile$datapath)
        }
    })

    dat2 <- reactive({
       dat1()
    })

    nodata <- reactive({
        is.null(input$datafile)
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





    output$filter_2 <- renderUI({
       selectInput(
          inputId = "filter_2_value",
          label = NULL,
          choices = unique(dat2()[["id_row"]]),
          selected = NULL,
          multiple = TRUE)
    })

    output$filter_5 <- renderUI({
        selectInput(
            inputId = "filter_5_value",
            label = NULL,
            choices = levels(dat2()[["x_factor"]]),
            selected = NULL,
            multiple = TRUE)
    })

    output$filter_6 <- renderUI({
       selectInput(
          inputId = "filter_6_value",
          label = NULL,
          choices = unique(dat2()[["x_logical"]]),
          selected = NULL,
          multiple = TRUE)
    })


    dat3 <- reactive({

       df <- dat2()

       if (input$chk_filter_2 & !is.null(input$filter_2_value)) {
          df <- df %>% filter(id_row %in% input$filter_2_value)
       }

       if (input$chk_filter_5 & !is.null(input$filter_5_value)) {
          df <- df %>% filter(x_factor %in% input$filter_5_value)
       }

       if (input$chk_filter_6 & !is.null(input$filter_6_value)) {
          df <- df %>% filter(x_logical %in% input$filter_6_value)
       }

       return(df)

    })

    output$data_tbl <- DT::renderDataTable({
        if (input$display_data == TRUE) {
            DT::datatable(
                data = dat3(),
                rownames = FALSE,
                filter = "none",
                options = list(
                    scrollX = TRUE,
                    scrollY = TRUE,
                    pageLength = 7,
                    lengthMenu = c(7, 10, 15, 20, nrow(dat3())),
                    dom = "tip"
                    )
            )
        }
    })

    sumstats <- reactive({
       if (nodata() == FALSE) {
          mcf::tbl_str(dat3())
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
                options = list(dom = "t")
            )
        }
    })


} # End of SERVER function




# 1  id_group character 50    0       10
# 2    id_row character 50    0       50
# 3    x_date      Date 50    0        6
# 4 x_numeric   numeric 50    0       47
# 5  x_factor    factor 50    0        3
# 6 x_logical   logical 50    0        2
# 7    x_text character 50    0       48
