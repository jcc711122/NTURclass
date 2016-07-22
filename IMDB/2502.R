library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)

orgURL = 'http://www.imdb.com'
allKeyWordData2 = data.frame()
for (i in 1:250)
{
  imdbURL <- paste(orgURL, alldata2$path[i], sep='')
  urlExists = url.exists(imdbURL)
  
  if(urlExists)
  {
    html = getURL(imdbURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    keywordURL = xpathSApply(xml, "//div[@class='see-more inline canwrap']/nobr//@href")
    print(keywordURL)
    #keyword= xpathSApply(xml, "//div[@itemprop='keywords']/a", xmlValue)
    if( is.null(keywordURL) )
    {
      nodata = data.frame(keywordURL='null')
      allKeyWordData2 = rbind(allKeyWordData2, nodata)
      
    }
    else
    {
      keyworddata = data.frame(keywordURL)
      
      allKeyWordData2 = rbind(allKeyWordData2, keyworddata)}
  }
}
alldata2 = cbind(alldata2, allKeyWordData2)

