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


   output$filtervar <- renderUI({
      assign_filter_value(dat2()[[input$obsfilters]], input$obsfilters)
   })

   # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   #
   # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   dat3 <- reactive({
      apply_filter(input$filter_obs,
                   dat2(),
                   input$obsfilters,
                   input$filter_value_selector)
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
                       filter = "none",
                       options = list(
                          scrollX = TRUE,
                          scrollY = TRUE,
                          pageLength = 7,
                          lengthMenu = c(7, 10, 15, 20),
                          autoWidth = FALSE,
                          processing = FALSE,
                          searching = FALSE,
                          dom = "tip", # This removes the global "Search" box
                          bFilter = 0)
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
                       filter = "none",
                       options = list(dom = "t") # Display only the raw table
                       )
      }
   })


   ### FOR TESTING PURPOSES
   #
   output$obsfilters <- renderText({
      input$obsfilters
   })
   #
   output$str_obsfilters <- renderPrint({
      str(input$obsfilters)
   })
   #
   output$filter_val <- renderPrint({
      str(input$filter_value_selector)
   })
   #
   output$str_dat2 <- renderPrint({
      c("dat2() --- ", class(dat2()))
   })
   #
   output$str_dat3 <- renderPrint({
      c("dat3() --- ", class(dat3()))
   })
}

