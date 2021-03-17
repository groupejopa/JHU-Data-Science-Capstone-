---
title: 'Data Product'
author: "Joseph Boateng"
date: "`r format(Sys.Date())`"
output: github_document
---
  


#' ## Shiny App 
#' This script creates a Shiny App that takes a word or phrase input in a text box
#' and outputs the a predicted next word. 

library(shiny)
suppressPackageStartupMessages({
   library(tidyverse)
   library(stringr)
  library(png)
 })



#' Source ngram matching function

source("./ngram_match/ngram.R")


# Show a plot of the generated distribution
 

#' Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Text Prediction Model"),
   p("This app takes an input phrase (multiple words) in a text box and outputs a prediction of the next word."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        h2("Instructions:"), 
        h5("1. Enter a word(s) in the text box."),
        h5("2. The predicted next word prints below in blue."),
        h5("3. No need to hit enter of submit."),
        h5("4. A question mark means no prediction, typically due to mis-spelling"),
        h5("5. Additional tabs show plots of the top ngrams in the dataset")
       ),
  

      
       mainPanel(
        tabsetPanel(
          tabPanel("Predict",
            textInput("user_input", h3("Your Input:"), 
                    value = "Your words"),
            h3("Result:"),
            h4(em(span(textOutput("ngram_output"), style="color:blue")))),
        
          tabPanel("Top quadgrams",
            br(),
            img(src = "quadgrams.png", height = 500, width = 700)),
        
          tabPanel("Top trigrams",
            br(),       
            img(src = "trigrams.png", height = 500, width = 700)),
      
          tabPanel("Top bigrams",
            br(),
            img(src = "bigrams.png", height = 500, width = 700))
          )   
    )
  )
)

 

#' Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$ngram_output <- renderText({
      ngrams(input$user_input)
  })
  
}
  
#' Run the application 
shinyApp(ui = ui, server = server)

 
