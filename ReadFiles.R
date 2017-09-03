con <- file("en_US/en_US.blogs.txt","r")
text_blog <- readLines(con, skipNul = TRUE)
close(con)

con <- file("en_US/en_US.twitter.txt","r")
text_twitter <- readLines(con, skipNul = TRUE)
close(con)

con <- file("en_US/en_US.news.txt","r")
text_news <- readLines(con, skipNul = TRUE)
close(con)