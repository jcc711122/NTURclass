
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tm)   
library(ggplot2)
library(wordcloud)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    cname <- file.path("./texts2")   
    docs <- Corpus(DirSource(cname))   
    docs <- tm_map(docs, tolower)   
    docs <- tm_map(docs, PlainTextDocument)  
    dtm <- DocumentTermMatrix(docs)   
    freq <- colSums(as.matrix(dtm))   
    ord <- order(freq)   
    freq <- colSums(as.matrix(dtm))
    freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
    wf <- data.frame(word=names(freq), freq=freq) 
    
  
    p <- ggplot(subset(wf, freq>input$bins), aes(word, freq))    
    p <- p + geom_bar(stat="identity")   
    p <- p + theme(axis.text.x=element_text(angle=45, hjust=1, size = 14))   
    p 

  })
  output$image <- renderImage({

    if (!input$Picture)
      {return(list(src = 'IMDB.gif',
                   contentType = 'image/gif',
                   width = 650,
                   height = 600,
                   alt = "")
      )
    }
    
    else {
      return(
    list(src = 'topRankKeyword.png',
         contentType = 'image/png',
         width = 700,
         height = 575,
         alt = ""))
  }}, deleteFile = F)
})
