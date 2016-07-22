rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL = 'http://www.imdb.com/chart/top?ref_=nv_mv_250_'

startPage = 6
endPage = 6
alldata2 = data.frame()
for( i in startPage:endPage)
{
  
  pttURL <- paste(orgURL, i, sep='')
  urlExists= url.exists(pttURL)
  if(urlExists)
  {
    
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    title = xpathSApply(xml, "//tr/td[@class='titleColumn']/a//text()", xmlValue)
    year = xpathSApply(xml, "//tr/td[@class='titleColumn']/span//text()", xmlValue)
    path = xpathSApply(xml, "//tr/td[@class='titleColumn']/a//@href")
    rate = xpathSApply(xml, "//tr/td[@class='ratingColumn imdbRating']", xmlValue)
    tempdata2 = data.frame(title, year, path, rate)
    alldata2 = rbind(alldata2, tempdata2)}
  
}