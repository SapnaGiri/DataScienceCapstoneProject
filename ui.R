library(shiny)
library(shinyjs)
        
source("TextPrediction.R")





appCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #FFFFFF;
}
"


shinyUI(fluidPage(
        useShinyjs(),
        inlineCSS(appCSS),
        
        headerPanel("Next Word Predictor"),
        
        sidebarLayout(
                sidebarPanel(width = 4,
                        h5("Enter some text and click on Predict"),
                        
                        textInput("inputText", label=NULL,value = "", width = '100%', placeholder = "Your text here"),
                        
                        actionButton("predictbtn","Predict")
                        
                ),
                
                mainPanel(
                        
                        tabsetPanel( type = "tabs",
                               tabPanel("Output", br(), 
                                        hidden(
                                                div(
                                                        id = "wait",
                                                        h2("Please wait")
                                                )
                                        )
                                        ,
                                        
                                                div(    id = 'output',
                                                        textOutput("textout1"),
                                                        br(),
                                                        verbatimTextOutput("predictedwords"),
                                                        br(), br(),
                                                        textOutput("textout2")
                                                )
                                
                                         ),
                               tabPanel("About", br(),
                                        h5("This app has been developed as part of the Data Science Specialization in Coursera."),
                                        h5("This is a word predictor app which can predict the next possible word after a given phrase.")
                                        )
                        )
                        
                )
        )
))
