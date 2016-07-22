cname <- file.path("C:", "texts2")   
cname
dir(cname)
library(tm)   
docs <- Corpus(DirSource(cname))   

summary(docs) 
#docs <- tm_map(docs, removePunctuation)   
#for(j in seq(docs))   
#{   
#  docs[[j]] <- gsub("/", " ", docs[[j]])   
#  docs[[j]] <- gsub("@", " ", docs[[j]])   
#  docs[[j]] <- gsub("\\|", " ", docs[[j]])   
#} 
docs <- tm_map(docs, tolower)   
#docs <- tm_map(docs, removeWords, stopwords("english"))  
#docs <- tm_map(docs, removeWords, c("word u want to remove", "word"))   
docs <- tm_map(docs, PlainTextDocument)  
dtm <- DocumentTermMatrix(docs)   
dtm
freq <- colSums(as.matrix(dtm))   
length(freq) 
ord <- order(freq)   
#dtms <- removeSparseTerms(dtm, 0.1) # This makes a matrix that is 10% empty space, maximum.
freq <- colSums(as.matrix(dtm))
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
wf <- data.frame(word=names(freq), freq=freq) 
library(ggplot2)   
p <- ggplot(subset(wf, freq>60), aes(word, freq))    
p <- p + geom_bar(stat="identity")   
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
p 
library(wordcloud)
totaldiff = levels(wf$word)
wordcloud(names(freq), freq, min.freq = 1, random.order = F, ordered.colors = T, 
          colors = rainbow(length(totaldiff)))

