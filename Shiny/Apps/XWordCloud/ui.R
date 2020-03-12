# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


UI <- fluidPage(

      h1("Word Cloud"),

      sidebarLayout(

         sidebarPanel(
            radioButtons("source", "Source of words",
               choices = c("Art of War" = "book",
                           "Use your own words" = "own",
                           "Upload a file" = "file")
            ),
            conditionalPanel(
               condition = "input.source == 'own'", # Note that 'input.source' is used in the condition, not 'input$source'
               textAreaInput("text", "Enter text", rows = 10)
            ),
            conditionalPanel(
               condition = "input.source == 'file'",
               fileInput("file", "Select a file")
            ),
            numericInput("num", "Maximum number of words", value = 100, min = 5),
            colourInput("col", "Background color", value = "white"),
            actionButton("draw", "Draw wordcloud!")
         ),

         mainPanel(
            wordcloud2Output(outputId = "cloud")
         )
      )
)


