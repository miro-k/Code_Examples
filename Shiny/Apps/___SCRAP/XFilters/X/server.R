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

   # dat3 <- reactive({ dat2() })
   # dat3 <- reactive({
   #    if (input$obsfilters == "") {
   #       dat2()
   #    } else if (class(dat3()[[input$obsfilters]]) == "factor") {
   #       dat2() %>% filter(!!sym(input$obsfilters) %in% input$filter_value)
   #    } else {
   #       dat2()
   #    }
   # })

   dat3 <- reactive({
      if ( mod (input$action, 2) == 1 ) {
      if (input$filter_obs){
         if (class(dat2()[[input$obsfilters]]) == "factor") {
            dat2() %>% filter(!!sym(input$obsfilters) %in% input$filter_value)
         } else if (class(dat2()[[input$obsfilters]]) == "logical") {
            dat2() %>% filter(!!sym(input$obsfilters))
         } else if (class(dat2()[[input$obsfilters]]) == "numeric") {
            dat2() %>% filter(between(!!sym(input$obsfilters), input$filter_value[1], input$filter_value[2]))
         } else if (class(dat2()[[input$obsfilters]]) == "Date") {
            dat2() %>% filter(between(!!sym(input$obsfilters), input$filter_value[1], input$filter_value[2]))
         } else {
         dat2()
         }
      }
      } else {
         dat2()
      }
   })

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
      pickerInput(inputId = "varselection",
                  label = NULL,
                  choices = varnames1(),
                  selected = NULL,
                  options = list(`actions-box` = TRUE),
                  multiple = TRUE)
   })
   #
   output$filterset <- renderUI({
      selectInput(inputId = "obsfilters",
                  label = "Choose a variable for the filter",
                  choices = c("",varnames2()), # 1st element is default selection
                  selected = NULL,
                  multiple = FALSE)
   })
   #
   output$ffactor <- renderUI({
      if (class(dat2()[[input$obsfilters]]) == "factor" ) {
         pickerInput(inputId = "filter_value",
                     label = input$obsfilters,
                     choices = levels(dat2()[[input$obsfilters]]),
                     selected = levels(dat2()[[input$obsfilters]]),
                     options = list(`actions-box` = TRUE),
                     multiple = TRUE)
      } else if (class(dat2()[[input$obsfilters]]) == "logical" ) {
         selectInput(inputId = "filter_value",
                     label = input$obsfilters,
                     choices = c(TRUE, FALSE),
                     selected = "",
                     multiple = FALSE)
      } else if (class(dat2()[[input$obsfilters]]) == "numeric") {
         sliderInput(inputId = "filter_value",
                     label = input$obsfilters,
                     min = min(dat2()[[input$obsfilters]]),
                     max = max(dat2()[[input$obsfilters]]),
                     value = c(min, max))
      } else if ((class(dat2()[[input$obsfilters]])) == "Date") {
         dateRangeInput(inputId = "filter_value",
                        label = input$obsfilters,
                        min = min(dat2()[[input$obsfilters]]),
                        max = max(dat2()[[input$obsfilters]]),
                        start = min(dat2()[[input$obsfilters]]),
                        end = max(dat2()[[input$obsfilters]]))
      } else {
         textInput(inputId = "filter_value",
                   label = input$obsfilters,
                   value = "")
      }
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
   output$filter_val <- renderPrint({
      str(input$filter_value)
   })
   output$action <- renderPrint({
      input$action
   })

}

