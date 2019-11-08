#install.packages("rtweet")

## load rtweet package
library(rtweet)
library(dplyr)
library(ggplot2)
library(lubridate)

setwd("/home/cnovaes/Downloads/lulalivre")
data <- system("date +\"%Y%m%d%H%M\"",intern=TRUE) 
termos <- c("Lula","Lula","Lula","Lula","STF","STF","STF","STF")
lang <- c("pt-br","es","en","pt","pt-br","es","en","pt")

token <- create_token(
   app = "my_twitter_research_app",
   consumer_key = "3I8JehozX8N4Bojg0qSdmDFLX",
   consumer_secret = "QBg2E2TcqtvlK0vrRIwIWZGSXjlPoYaLXwjrePRDLztepAU6cg",
   access_token = "2433072234-seryr8c6OCyNU5veonMKf5hvX8JKCUOiA20TcoC",
   access_secret = "rHOyUzdhL5GN6lqWh3LOxmuKD2hb0IvpeJm4hrs24O4nx"
)   

for(i in 1:length(termos)){
   termo <- termos[i]
   tweets <- search_tweets(termo, n = 2000, type="popular",retryonratelimit = TRUE,lang=lang[i])
   tweets$termo <- rep(termo, nrow(tweets));
   saveRDS(tweets, file = paste0("data/tweets_",termo,"_",lang[i],"_",data,".rds"))
}
