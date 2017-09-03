setwd("~/RWorkingDirectory/Capstone")

remove(list=ls())

library(quanteda)
library(dplyr)
library(tidyr)
library(data.table)

##Read text files
source("ReadFiles.R")

##Sample data from text files
source("SampleData.R")


##read sampled corpus file
mycorpus <- readRDS("mycorpus")

##load function to create n grams
source("CreateNGrams.R")


tokensAll <- tokens(mycorpus)
tokensNoStopwords <- removeFeatures(tokensAll, SevenDirtyWords)


##create unigrams and save in RData file
unigrams <- myngramsfun(mycorpus,1,1)
##unigrams <- myngramsfun1(tokensNoStopwords,1,1)
saveRDS(unigrams,"unigrams.RData")
rm(unigrams)
unigrams<- readRDS("unigrams.RData")
unigrams <- arrange(unigrams, desc(count))
format(object.size(unigrams), units='Mb')

##create bigrams and save in RData file
bigrams <- myngramsfun(mycorpus, 2,1)
##bigrams <- myngramsfun1(tokensNoStopwords,2,1)
saveRDS(bigrams, "bigrams.RData")
rm(bigrams)
bigrams <- readRDS("bigrams.RData")
format(object.size(bigrams), units='Gb')


##create trigrams and save in RData file
trigrams <- myngramsfun(mycorpus, 3, 1)
##trigrams <- myngramsfun1(tokensNoStopwords,3,1)
saveRDS(trigrams, "trigrams.RData")
rm(trigrams)
trigrams <- readRDS("trigrams.RData")
format(object.size(trigrams), units='Mb')


##create quadragrams and save in RData file
## USE NGramsByLoop.R  (below code takes lot of time)
# quadragrams <- myngramsfun(mycorpus, 4, 1)
# saveRDS(quadragrams, "quadragrams.RData")
# rm(quadragrams)
# quadragrams <- readRDS("quadragrams.RData")
# format(object.size(quadragrams), units='Mb')


##read n grams from the files and break into words
##UNIGRAMS
unigrams <- readRDS("unigrams.RData")
unigrams <- arrange(unigrams, desc(count))
unigramsdf <- head(unigrams,20)
saveRDS(unigramsdf, "unigramsdf.RData")
rm(unigrams)


##BIGRAMS
bigrams <- readRDS("bigrams.RData")
bigramsdf <- separate(bigrams, words, into = c('word1','word2'), sep=" ", remove=TRUE)
saveRDS(bigramsdf,"bigramsdf.RData")
rm(bigrams)
rm(bigramsdf)
bigramsdf <- readRDS("bigramsdf.RData")
format(object.size(bigramsdf), units='Mb')

##TRIGRAMS
trigrams <- readRDS("trigrams.RData")
trigramsdf <- separate(trigrams, words, into = c('word1','word2','word3'), sep=" ", remove=TRUE)
saveRDS(trigramsdf,"trigramsdf.RData")
rm(trigrams)
rm(trigramsdf)
trigramsdf <- readRDS("trigramsdf.RData")
format(object.size(trigramsdf), units='Mb')

##QUADRAGRAMS
quadragrams <- readRDS("quadragrams.RData")
quadragramsdf <- separate(quadragrams, words, into = c('word1','word2','word3','word4'), sep=" ", remove=TRUE)
saveRDS(quadragramsdf,"quadragramsdf.RData")
rm(quadragrams)
rm(quadragramsdf)
quadragramsdf <- readRDS("quadragramsdf.RData")
format(object.size(quadragramsdf), units='Mb')


##Prediction function
source("TextPrediction.R")



