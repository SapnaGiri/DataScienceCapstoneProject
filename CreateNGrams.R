SevenDirtyWords <- c('shit','piss','fuck','cunt','cocksucker','motherfucker','tits')

library(quanteda)



myngramsfun <- function(mycorpus, n, removeones){
        
        
        mytkns <- quanteda::tokenize(mycorpus, what=c("word"), ngrams=n, concatenator=" ")
        
        mydfm <- dfm(mytkns, remove = SevenDirtyWords)
        
        mydf <- data.frame(words = featnames(mydfm), count = colSums(mydfm), 
                           row.names = NULL, stringsAsFactors = FALSE)
        
        mydf <- arrange(mydf, desc(count))
        
        rm(mytkns); rm(mydfm)
        
        if(removeones==1){
                mydf1 <- mydf[mydf$count > 1,]    
        }else{
                mydf1 <- mydf
        }
        
        
        return(mydf1)
}





###function 2
# tokensAll <- tokens(mycorpus)
# tokensNoStopwords <- removeFeatures(tokensAll, SevenDirtyWords)

myngramsfun1 <- function(tokensNoStopwords, n, removeones){
        
        tokensNgramsNoStopwords <- tokens_ngrams(tokensNoStopwords, n, concatenator = " ")
        mydfm <- dfm(tokensNgramsNoStopwords, verbose = FALSE)
        
        mydf <- data.frame(words = featnames(mydfm), count = colSums(mydfm), 
                           row.names = NULL, stringsAsFactors = FALSE)
        
        mydf <- arrange(mydf, desc(count))
        
        rm(mydfm)
        
        if(removeones==1){
                mydf1 <- mydf[mydf$count > 1,]    
        }else{
                mydf1 <- mydf
        }
        
        
        return(mydf1)
}