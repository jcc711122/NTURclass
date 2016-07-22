#rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)

Sys.setlocale("LC_ALL", 'German')

orgURL = 'http://www.imdb.com'
for( i in 1:250)
{
    imdbURL <- paste(orgURL, alldata2$keywordURL[i], sep='') 
    html = getURL(imdbURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding='utf-8')
    text = xpathSApply(xml, "//td[@class='soda sodavote']/@data-item-keyword")
    name <- paste('topRank',i, '.txt', sep='')
    write(text, name)
  
  
}