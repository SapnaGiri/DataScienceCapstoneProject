len_blog <- length(text_blog)
len_twitter <- length(text_twitter)
len_news <- length(text_news)

set.seed(1234)
sample_blog <- sample(text_blog, size = (1 * len_blog))
sample_twitter <- sample(text_twitter, size = (1 * len_twitter))
sample_news <- sample(text_news, size = (1 * len_news))

all_text <- c(sample_blog, sample_twitter, sample_news)
onetext <- paste(all_text, collapse = ' ')

onetext <- gsub("[^a-zA-Z ]","",onetext)
onetext <- tolower(onetext)
mycorpus <- corpus(onetext)

rm(text_blog); rm(text_twitter); rm(text_news);
rm(sample_blog); rm(sample_twitter); rm(sample_news);
rm(con); rm(len_blog); rm(len_news); rm(len_twitter);
rm(all_text); rm(onetext)

saveRDS(mycorpus,"mycorpus")