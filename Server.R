# library(shiny)
# 
# source("TextPrediction.R")
# 
# unigramsdf <- readRDS("./unigramsdf.RData")
# bigramsdf <- readRDS("./bigramsdf.RData")
# trigramsdf <- readRDS("./trigramsdf.RData")
# quadragramsdf <- readRDS("./quadragramsdf.RData")



shinyServer(function(input,output){
        
        prediction <- observeEvent(input$predictbtn ,{
                
                hide(id = "output");    
                show("wait");
                Sys.sleep(10);
                
                
                inputText <- input$inputText;
                
                predlist <- predictnext(inputText);
                
                if(predlist$flag == 2){ngrams <- "BIGRAMS"}
                else if(predlist$flag == 3){ngrams <- "TRIGRAMS"}
                else if(predlist$flag == 4){ngrams <- "QUADRAGRAMS"}
                
                if(predlist$flag == 0){
                        
                        textout1 <- "Please enter some text."   
                        textout2 <- ""
                        predictedwords <- ""
                        
                }else if(predlist$flag == 1){
                        
                        textout1 <- "Prediction not possible. Random top unigrams shown below."   
                        textout2 <- ""
                        predictedwords <- paste(toupper(predlist$predwords), collapse="   ")
                        
                }else{
                        
                        textout1 <- "The top 3 predicted words are"
                        textout2 <- paste("The words were predicted using", ngrams,".", sep=" ")
                        predictedwords <- paste(toupper(predlist$predwords), collapse="   ")
                }
                
                output$textout1 = renderText(textout1)
                output$textout2 = renderText(textout2)
                output$predictedwords = renderText(predictedwords)
                
                hide(id = "wait")    
                show("output")
        })    
        
        show("output")
})