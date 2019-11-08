library(tidyverse)
library(lubridate)

setwd("/home/cnovaes/Downloads/lulalivre/")
files <- system("ls data/*.rds",intern=TRUE)
df <- data.frame()
for(f in files){
   termo <- unlist(strsplit(f,"_"))[2]
   lang <- unlist(strsplit(f,"_"))[3]
   aux_df <- readRDS(f)
   aux_df$termo <- rep(termo,nrow(aux_df))
   df <- rbind(df, aux_df)
}
