# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# server.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


SERVER <- function(input, output) {

   # Regular ggplot2 graph

   output$plot <- renderPlot({

      data <- subset(gapminder, continent %in% input$contins &
                        year >= input$years[1] & year <= input$years[2])

      p <- ggplot(data, aes(gdpPercap, lifeExp)) +
              geom_point(size = input$size, col = input$color) +
              scale_x_log10() +
              ggtitle(input$title)

      if (input$fit == TRUE) {
         p <- p + geom_smooth(method = "lm")
      }
      p
   })

   # Plotly version of the graph above (note the similarities; also note the use
   # of 'renderPlotly' and 'ggplotly' functions)

   output$plotly <- renderPlotly({

      ggplotly({

      data <- subset(gapminder, continent %in% input$contins &
                        year >= input$years[1] & year <= input$years[2])

      p <- ggplot(data, aes(gdpPercap, lifeExp)) +
         geom_point(size = input$size, col = input$color) +
         scale_x_log10() +
         ggtitle(input$title)

      if (input$fit == TRUE) {
         p <- p + geom_smooth(method = "lm")
      }
      p

      })
   })

}


