# Twitter Search
# Description: Search Twitter for keywords
# Author: Jonathan Langefeld - 2016
# Icon: http://www.flaticon.com/
# preferences:
keyword = '%%keyword%%'
n = %%n%%
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
# sign in to Twitter
origop <- options("httr_oauth_cache")
options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_secret)
options(httr_oauth_cache=origop)
tweets <- searchTwitter(keyword, n=n)
tweets_df = twListToDF(tweets)
sources = tweets_df$statusSource
sources <- gsub("</a>", "", sources)
sources <- strsplit(sources, ">")
sources <- sapply(sources, function(x) ifelse(length(x) > 1, x[2], x[1]))
tweets_df$statusSource = sources
# write result to stream
modelerData = tweets_df
var1<-c(fieldName="text",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var2<-c(fieldName="favorited",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var3<-c(fieldName="favoriteCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var4<-c(fieldName="replyToSN",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var5<-c(fieldName="created",fieldLabel="",fieldStorage="timestamp",fieldMeasure="",fieldFormat="",fieldRole="")
var6<-c(fieldName="truncated",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var7<-c(fieldName="replyToSID",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var8<-c(fieldName="id",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var9<-c(fieldName="replyToUID",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var10<-c(fieldName="statusSource",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var11<-c(fieldName="screenName",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var12<-c(fieldName="retweetCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var13<-c(fieldName="isRetweet",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var14<-c(fieldName="retweeted",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var15<-c(fieldName="longitude",fieldLabel="",fieldStorage="real",fieldMeasure="",fieldFormat="",fieldRole="")
var16<-c(fieldName="latitude",fieldLabel="",fieldStorage="real",fieldMeasure="",fieldFormat="",fieldRole="")
modelerDataModel = data.frame(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13,var14,var15,var16)
if (dim(modelerData)[2] != 2) {
  warning("The loading process failed. Please verify your tokens and read the console output above.")
}
