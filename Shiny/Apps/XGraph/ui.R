# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# UI function defined ====================================================================

UI <- fluidPage(

   sidebarLayout(

      sidebarPanel(

         # Add a title text input
         textInput("title", "Title", "GDP vs Life Exp."),

         # Add a size numeric input
         numericInput("size", "Point size", value = 1.5, min = 1, step = 0.5),

         # Add a checkbox for line of best fit
         checkboxInput("fit", "Add line of best fit", FALSE),

         # # Add radio buttons for colour
         # radioButtons("color", "Point color", choices = c("blue", "red", "green", "black")),

         # Replace the radio buttons with colour picker
         colourInput("color", "Point color", value = "cornflowerblue"),

         # Add a continent dropdown selector
         selectInput("contins", "Continents",
                     choices = levels(gapminder$continent),
                     multiple = TRUE,
                     selected = "Europe"),

         # Add a slider selector for years to filter
         sliderInput("years", "Years",
                     min = min(gapminder$year), max = max(gapminder$year),
                     value = c(1977, 2002))


      ),

      mainPanel(

         plotOutput("plot", width = "700px", height = "400px"),

         plotlyOutput("plotly", width = "700px", height = "400px")


      )
   )
)


