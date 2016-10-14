# Twitter Trends
# Description: See what`s happening on twitter right now
# Author: Jonathan Langefeld - 2016
# Icon: http://www.flaticon.com/
# preferences:
worldwide = %%worldwide%%
latitude = %%latitude%%
longitude = %%longitude%%
api_key = '%%api_key%%'
api_secret = '%%api_secret%%'
access_token = '%%access_token%%'
access_secret = '%%access_secret%%'
# load required package
packages <- function(x) {
  x <- as.character(match.call()[[2]])
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x,repos="http://cran.r-project.org")
    require(x,character.only=TRUE)
  }
}
packages(twitteR)
# sign in to twitter
origop <- options("httr_oauth_cache")
options(httr_oauth_cache=FALSE)
setup_twitter_oauth(api_key, api_secret, access_token, access_secret)
options(httr_oauth_cache=origop$httr_oauth_cache)
# check worldwide option
if (!worldwide) {
  woeid = closestTrendLocations(latitude, longitude)$woeid
} else {
  woeid = 1
}
#receive data and write to stream
modelerData = getTrends(woeid)[,c('name','url')]
var1<-c(fieldName="name",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var2<-c(fieldName="url",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
modelerDataModel = data.frame(var1,var2)
if (dim(modelerData)[2] != 2) {
  warning("The loading process failed. Please verify your tokens")
}
