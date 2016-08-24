# Twitter User
# Description: Get information about twitter users.
# Author: Jonathan Langefeld - 2016
# Icon: http://www.flaticon.com/
# preferences:
ids = modelerData$%%ids%%
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
print(origop)
options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_secret)
options(httr_oauth_cache=origop$httr_oauth_cache)
#create a data frame of all users in vector
user_df = data.frame()
for (id in ids) {
    result = tryCatch({
        u = getUser(id)$toDataFrame()
        user_df = rbind(user_df, u)
    }, error = function(err) {
        print(paste0("User '",id,"' not found or another problem occured. Errormessage: ",err))
    }, warning = function(w){
        print(paste0("A warning occured. Warning message: ",w))
    })
}
user_df$profileImageUrl = NULL
user_df$followRequestSent = NULL
user_df$listedCount = NULL
user_df$url = NULL
#write return data
modelerData = user_df
var1<-c(fieldName="description",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var2<-c(fieldName="statusesCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var3<-c(fieldName="followersCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var4<-c(fieldName="favoritesCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var5<-c(fieldName="friendsCount",fieldLabel="",fieldStorage="integer",fieldMeasure="",fieldFormat="",fieldRole="")
var6<-c(fieldName="name",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var7<-c(fieldName="created",fieldLabel="",fieldStorage="timestamp",fieldMeasure="",fieldFormat="",fieldRole="")
var8<-c(fieldName="protected",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var9<-c(fieldName="varified",fieldLabel="",fieldStorage="string",fieldMeasure="flag",fieldFormat="",fieldRole="")
var10<-c(fieldName="screenName",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var11<-c(fieldName="location",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var12<-c(fieldName="lang",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
var13<-c(fieldName="id",fieldLabel="",fieldStorage="string",fieldMeasure="",fieldFormat="",fieldRole="")
modelerDataModel = data.frame(var1,var2,var3,var4,var5,var6,var7,var8,var9,var10,var11,var12,var13)
