# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# global.R
#
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rm(list = ls())

# Load all required packages

lapply(c("mcf",
         "data.table",
         "DT",
         "stringr",
         "tidyverse",
         "magrittr",
         "reactlog",
         "shiny",
         "shinyjs",
         "shinythemes"), library, character.only = TRUE)

# Load 'gapminder' package to get Gapminder data frame

library("gapminder")
# gapminder %>% tbl_str()
# levels(gapminder$continent)

# Load 'ggplot2' package
library("ggplot2")

# Load "colorpicker" package
library("colourpicker")

# Load "plotly" package
library("plotly")

# Load 'tm' package
library("tm")

# Load "wordcloud2" package
library("wordcloud2")

# Load a large character vector (Sun Tzu's 'Art of War' sample text)
artofwar <- readLines("C:/Users/MK/Documents/pCloud_Sync_offline/Code_Examples/Data/artofwar.txt")
head(artofwar,35)

# Define path to the Shiny app directory

appsdir <- file.path("C:", "Users", "MK", "Documents", "pCloud_Sync_offline",
                     "Code_Examples", "Shiny", "Apps")

# Execute code in the following external files

source( paste(appsdir, "XWordCloud", "ui.R", sep = "/") )
source( paste(appsdir, "XWordCloud", "server.R", sep = "/") )

# Function 'create_wordcloud' defined here (take from DataCamp)

create_wordcloud <- function(data, num_words = 100, background = "white") {

   # If text is provided, convert it to a dataframe of word frequencies
   if (is.character(data)) {
      corpus <- Corpus(VectorSource(data))
      corpus <- tm_map(corpus, tolower)
      corpus <- tm_map(corpus, removePunctuation)
      corpus <- tm_map(corpus, removeNumbers)
      corpus <- tm_map(corpus, removeWords, stopwords("english"))
      tdm <- as.matrix(TermDocumentMatrix(corpus))
      data <- sort(rowSums(tdm), decreasing = TRUE)
      data <- data.frame(word = names(data), freq = as.numeric(data))
   }

   # Make sure a proper num_words is provided
   if (!is.numeric(num_words) || num_words < 3) {
      num_words <- 3
   }

   # Grab the top n most common words
   data <- head(data, n = num_words)
   if (nrow(data) == 0) {
      return(NULL)
   }

   wordcloud2(data, backgroundColor = background)
}



# Run the app

shinyApp(ui = UI, server = SERVER)


#runApp(paste(appsdir, "XWordCloud", sep = "/"))
#setwd(appsdir); runApp("XWordCloud")


