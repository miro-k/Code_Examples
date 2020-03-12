# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# server.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


SERVER <- function(input, output) {

   data_source <- reactive({
      if (input$source == "book") {
         data <- artofwar
      } else if (input$source == "own") {
         data <- input$text
      } else if (input$source == "file") {
         data <- input_file()
      }
      return(data)
   })


   input_file <- reactive({
      if (is.null(input$file)) {
         return("")
      }
      readLines(input$file$datapath)
   })


   output$cloud <- renderWordcloud2({
      input$draw # Action button executes the 'create_wordcloud()' below
      isolate({
         create_wordcloud(data = data_source(), num_words = input$num, background = input$col)
      })
   })

}


