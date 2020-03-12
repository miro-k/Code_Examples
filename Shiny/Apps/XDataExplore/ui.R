# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# ui.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Define CSS to change the look of some UI elements

my_css <- "
   #download_data {

   /* Change the background color of the download button to orange. */
   background: orange;

   /* Change the text size to 20 pixels. */
   font-size: 20px;
   }

   #table {

   /* Change the text color of the table to red. */
   color: red;
   }
"


UI <- fluidPage(

   h1("Gapminder"),

   # Add the CSS that we wrote to the Shiny app
   # Can also write a separate CSS file and import it using 'includeCSS()'
   tags$style(my_css),

   tabsetPanel(

      tabPanel(

         title = "Inputs",

         sliderInput("life", "Life expectancy", min = 0, max = 120, value = c(30, 50)),

         selectInput("contins", "Continent",
                     choices = c("All", levels(gapminder$continent))),

         downloadButton(outputId = "download_data", label = "Download table/data")
         ),

      tabPanel(

         title = "Plots",

         plotOutput("plot")
      ),

      tabPanel(

         title = "Tables",

         DT::dataTableOutput("table")
      )

   )

)


