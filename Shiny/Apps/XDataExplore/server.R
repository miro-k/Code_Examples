# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# server.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


SERVER <- function(input, output) {

   filtered_data <- reactive({

      data <- gapminder
      data <- subset(data, lifeExp >= input$life[1] & lifeExp <= input$life[2])

      if (input$contins != "All") {
         data <- subset(data, continent == input$contins)
      }

      data
   })


   output$table <- DT::renderDataTable({
      filtered_data()
   })


   output$download_data <- downloadHandler(

      filename = "gapminder_data.csv",

      content = function(file) {
         write.csv(filtered_data(), file, row.names = FALSE)
      }
   )


   output$plot <- renderPlot({

      ggplot(filtered_data(), aes(gdpPercap, lifeExp)) +
         geom_point() +
         scale_x_log10()
   })

}


