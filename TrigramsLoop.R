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
        
        trigrams <- myngramsfun(mycorpus, 3, 1)
        saveRDS(trigrams, paste("trigrams",loopno,".RData", sep=""))
        rm(trigrams)
        
        
        
        mincount <- maxcount + 1
        maxcount <- mincount + loopcount
        if(maxcount > totalcount){
                maxcount <- totalcount
        }
        
        print(loopno)
        Sys.sleep(0.01)
        flush.console()
        
}



##merge all trigrams files into one
for(i in 1:43){
        temp <- readRDS(paste("trigrams",i,".RData", sep=""))
        
        if(i==1){
                trigrams <- temp   
        }
        else{
                trigrams <- rbind(trigrams,temp)
        }
        
        if(i==43){
                tri_final <- aggregate(count ~ words, trigrams, sum)
                tri_final1 <- tri_final[tri_final$count > 1,]
                tri_final1 <- arrange(tri_final1, desc(count))
                saveRDS(tri_final1,"trigrams.RData")
                rm(trigrams)
                rm(tri_final)
                rm(temp)
        }
        
        print(i)
        Sys.sleep(0.01)
        flush.console()
}