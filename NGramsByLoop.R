##Preparation
source("CreateNGrams.R")

rm(mycorpus)

source("ReadFiles.R")


len_blog <- length(text_blog)
len_twitter <- length(text_twitter)
len_news <- length(text_news)

set.seed(1234)
sample_blog <- sample(text_blog, size = (1 * len_blog))
sample_twitter <- sample(text_twitter, size = (1 * len_twitter))
sample_news <- sample(text_news, size = (1 * len_news))

all_text <- c(sample_blog, sample_twitter, sample_news)

rm(text_blog); rm(text_twitter); rm(text_news);
rm(sample_blog); rm(sample_twitter); rm(sample_news);
rm(con); rm(len_blog); rm(len_news); rm(len_twitter);

##looping
class(all_text)
totalcount <- length(all_text)

loopcount <- 100000
totalloops <- floor(totalcount / loopcount) +1 
loops <- 1:totalloops

mincount <- 1
maxcount <- loopcount

for(loopno in loops){
        looptext <- all_text[mincount : maxcount]
        onetext <- paste(looptext, collapse = ' ')
        
        onetext <- gsub("[^a-zA-Z ]","",onetext)
        onetext <- tolower(onetext)
        mycorpus <- corpus(onetext)
        
        # tokensAll1 <- tokens(mycorpus)
        # tokensNoStopwords1 <- removeFeatures(tokensAll1, SevenDirtyWords)
        
        quadragrams <- myngramsfun(mycorpus, 4, 1)
        ##quadragrams <- myngramsfun1(tokensNoStopwords1, 4, 1)
        saveRDS(quadragrams, paste("quadragrams",loopno,".RData", sep=""))
        rm(quadragrams)

        
        
        mincount <- maxcount + 1
        maxcount <- mincount + loopcount
        if(maxcount > totalcount){
                maxcount <- totalcount
        }
        
        print(loopno)
        Sys.sleep(0.01)
        flush.console()
        
}



##merge all quadragram files into one
for(i in 1:43){
        temp <- readRDS(paste("quadragrams",i,".RData", sep=""))
        
        if(i==1){
            quadragrams <- temp   
        }
        else{
                quadragrams <- rbind(quadragrams,temp)
        }
        
        if(i==43){
                q_final <- aggregate(count ~ words, quadragrams, sum)
                q_final1 <- q_final[q_final$count > 1,]
                q_final1 <- arrange(q_final1, desc(count))
                saveRDS(q_final1,"quadragrams.RData")
                rm(quadragrams)
                rm(q_final)
                rm(temp)
        }
        
        print(i)
        Sys.sleep(0.01)
        flush.console()
}