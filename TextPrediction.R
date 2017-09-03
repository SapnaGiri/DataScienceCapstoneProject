library(dplyr)

predictnext <- function(text){
        
        ## clean input text here 
        inputtext <- gsub("[^a-zA-Z ]","",text)
        inputtext <- tolower(inputtext)
        
        textsplit <- strsplit(inputtext,' ')  
        textlen <- length(textsplit[[1]])
        
        foundflag <- 0
        flag <- 0
        predwords <- NULL
        
        ##If no text entered
        if(textlen == 0){
                ##print("Please enter some text.")
                flag <- 0
                return(list(flag = flag, predwords = predwords))
                ##return()
        }
        
        
        ##use quadragrams to predict
        if(textlen >= 3){
                
                w1 <- textsplit[[1]][textlen-2]
                w2 <- textsplit[[1]][textlen-1]
                w3 <- textsplit[[1]][textlen]
                
                subdf <- quadragramsdf[quadragramsdf$word1==w1 & quadragramsdf$word2==w2 & quadragramsdf$word3==w3,]
                
                if(nrow(subdf)>0){
                        subdf <- arrange(subdf, desc(count))
                        
                        subdf1 <- subdf[subdf$word4 != 'the' || subdf$word4 != 'a' || subdf$word4 != 'an',]
                        
                        if (nrow(subdf1)>=3){
                                predwords <- subdf1$word4[1:3]    
                        }else{
                                predwords <- subdf$word4[1:nrow(subdf)]
                        }
                        
                        # if (nrow(subdf)>=3){
                        #         predwords <- subdf$word4[1:3]    
                        # }else{
                        #         predwords <- subdf$word4[1:nrow(subdf)]
                        # }
                        
                        flag <- 4
                        foundflag <- 1
                }
                
        }
        
        ##use trigrams to predict
        if(textlen==2 || foundflag == 0){ 
                
                w1 <- textsplit[[1]][textlen-1]
                w2 <- textsplit[[1]][textlen]
                
                subdf <- trigramsdf[trigramsdf$word1==w1 & trigramsdf$word2==w2, ]
                
                
                if(nrow(subdf)>0){
                        subdf <- arrange(subdf, desc(count))
                        
                        subdf1 <- subdf[subdf$word3 != 'the' || subdf$word3 != 'a' || subdf$word3 != 'an',]
                        
                        if (nrow(subdf1)>=3){
                                predwords <- subdf1$word3[1:3]    
                        }else{
                                predwords <- subdf$word3[1:nrow(subdf)]
                        }
                        
                        # if (nrow(subdf)>=3){
                        #         predwords <- subdf$word3[1:3]    
                        # }else{
                        #         predwords <- subdf$word3[1:nrow(subdf)]
                        # }
                        
                        flag <- 3
                        foundflag <- 1
                }
        }
        
        ##use bigrams to predict
        if(textlen==1 || foundflag == 0){ 
                
                w1 <- textsplit[[1]][textlen]
                
                subdf <- bigramsdf[bigramsdf$word1==w1, ]
                
                if(nrow(subdf)>0){
                        subdf <- arrange(subdf, desc(count))
                        
                        subdf1 <- subdf[subdf$word2 != 'the' || subdf$word2 != 'a' || subdf$word2 != 'an',]
                        
                        if (nrow(subdf1)>=3){
                                predwords <- subdf1$word2[1:3]    
                        }else{
                                predwords <- subdf$word2[1:nrow(subdf)]
                        }
                        
                        # if (nrow(subdf)>=3){
                        #         predwords <- subdf$word2[1:3]    
                        # }else{
                        #         predwords <- subdf$word2[1:nrow(subdf)]
                        # }
                        
                        flag <- 2
                        foundflag <- 1
                }
        }
        
        if(foundflag == 0){
                
                predwords <- sample(unigramsdf$words, size=3)
                flag <- 1
        }
        
        
        ##print(flag)
        #return(predwords)
        return(list(flag = flag, predwords = predwords))
        
}