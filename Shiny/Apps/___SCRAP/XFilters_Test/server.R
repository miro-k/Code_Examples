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
   #
   dat2 <- reactive({
      if (is.null(input$varselection)) {
         dat1()
      } else {
      dat1()[input$varselection]
      }
   })
   #
   # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


   output$filter_1 <- renderUI({
      assign_filter_value(dat2()[["id_group"]], "id_group", "filter_value_selector_1")
   })

   output$filter_2 <- renderUI({
      assign_filter_value(dat2()[["id_row"]], "id_row", "filter_value_selector_2")
   })

   output$filter_3 <- renderUI({
      assign_filter_value(dat2()[["x_date"]], "x_date", "filter_value_selector_3")
   })

   output$filter_4 <- renderUI({
      assign_filter_value(dat2()[["x_numeric"]], "x_numeric", "filter_value_selector_4")
   })

   output$filter_5 <- renderUI({
      assign_filter_value(dat2()[["x_factor"]], "x_factor", "filter_value_selector_5")
   })

   output$filter_6 <- renderUI({
      assign_filter_value(dat2()[["x_text"]], "x_text", "filter_value_selector_6")
   })



   # dat3 <- reactive({
   #    apply_filter(dat2(), input$obsfilter_5, input$filter_value_selector_5)
   # })

   dat3 <- reactive({
      if (input$filter_obs) {
         dat2() %>%
            filter(
               between(x_date, input$filter_value_selector_3[1], input$filter_value_selector_3[2]) &
               between(x_numeric,input$filter_value_selector_4[1], input$filter_value_selector_4[2]) &
               x_factor %in% input$filter_value_selector_5 &
               x_text == input$filter_value_selector_6
            )
      } else {
         dat2()
      }
   })

   # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   #
   varnames1 <- reactive({
      names(dat1())
   })
   #
   varnames2 <- reactive({
      names(dat2())
   })
   #
   output$vars <- renderUI({
      selectInput(inputId = "varselection",
                  label = NULL,
                  choices = varnames1(),
                  selected = NULL,
                  multiple = TRUE)
   })
   #
   output$filterset <- renderUI({
      selectInput(inputId = "obsfilters",
                  label = "Choose a variable for the filter",
                  choices = c("",varnames2()),
                  selected = NULL,
                  multiple = FALSE)

   })
   #
   nodata <- reactive({
      is.null(input$datafile)
   })
   #
   output$no_data_msg <- reactive({
      if (nodata() == TRUE & input$display_data == TRUE) {
         "Nothing to display, no data has yet been uploaded."
      }
   })
   #
   output$no_sumstats_msg <- reactive({
      if (nodata() == TRUE & input$display_sumstats == TRUE) {
         "No stats available, no data has yet been uploaded."
      }
   })
   #
   output$data_tbl <- DT::renderDataTable({
      if (input$display_data) {
         DT::datatable(data = dat3(),
                       rownames = FALSE,
                       filter = "top",
                       extensions = 'Buttons',
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
   #
   sumstats <- reactive({
      if (nodata() == FALSE) {
         mcf::tbl_str(dat3())
      }
   })
   #
   output$summary_tbl <- DT::renderDataTable({
      if (input$display_sumstats) {
         DT::datatable(caption = "Table 1: Contents of the current data file",
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
                       options = list(dom = "t") # Display only the raw table
                       )
      }
   })


   # ### FOR TESTING PURPOSES
   # #
   # output$str_filter_obs <- renderPrint({
   #    head(input$filter_obs)
   # })
   # #
   # output$str_filter_value <- renderPrint({
   #    str(input$filter_value_selector)
   # })
   # #
   # output$str_dat2 <- renderPrint({
   #    c("CLASS = ", class(dat2())[3], "ROWS = ", nrow(dat2()), "COLS = ", ncol(dat2()))
   # })
   # #
   # output$str_obsfilters <- renderPrint({
   #    str(input$obsfilters)
   # })
   # #
   # output$str_dat3 <- renderPrint({
   #    c("CLASS = ", class(dat3())[3], "ROWS = ", nrow(dat3()), "COLS = ", ncol(dat3()))
   # })
   # output$dt_rows <- renderPrint({
   #    str(input$data_tbl_rows_all)
   # })
   # #

   # Check out 2.2 section
   # https://rstudio.github.io/DT/shiny.html
   # Also check out discussion about downloading DT datatable content
   # https://github.com/rstudio/DT/issues/267

}

