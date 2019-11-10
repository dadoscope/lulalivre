library(tidyverse)
library(lubridate)

setwd("/Users/isiscosta/RScript/lulalivre")
files <- system("ls data/*.rds",intern=TRUE)
df <- data.frame()
for(f in files){
   termo <- unlist(strsplit(f,"_"))[2]
   lang <- unlist(strsplit(f,"_"))[3]
   aux_df <- readRDS(f)
   aux_df$termo <- rep(termo,nrow(aux_df))
   df <- rbind(df, aux_df)
}

################# figures

setwd("/Users/isiscosta/RScript/lulalivre/figures")
p0 <- df %>% group_by(lang) %>% summarise(total = sum(retweet_count))  %>% ggplot(aes(x = reorder(lang, total), y = total, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula'", x = "Número de Número de Retuítes", y = "Idiomas")

p1 <- df %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(50) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula'", x = "Número de Retuítes", y = "Perfis do Twitter")

p2 <- df %>% filter(lang != "pt") %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(20) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula'", x = "Número de Retuítes", y = "Perfis do Twitter")

p3 <- df %>% filter(lang == "pt") %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(20) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula' - Português", x = "Número de Retuítes", y = "Perfis do Twitter")

p4 <- df %>% filter(lang == "es") %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(20) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula' - Espanhol", x = "Número de Retuítes", y = "Perfis do Twitter")

p5 <- df %>% filter(lang == "en") %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(20) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula' - Inglês", x = "Número de Retuítes", y = "Perfis do Twitter")

p6 <- df %>% filter(lang == "fr") %>% group_by(screen_name) %>% mutate(total = sum(retweet_count)) %>% ungroup() %>% group_by(screen_name, lang, total) %>% summarise(parcial = sum(retweet_count)) %>% arrange(total) %>% tail(20) %>% ggplot(aes(x = reorder(screen_name, total), y = parcial, fill = lang)) + geom_bar(stat = "identity") + theme_bw()+coord_flip()+labs(title = "Número de retuítes contendo a palavra 'Lula' - Francês", x = "Número de Retuítes", y = "Perfis do Twitter")

png("ret_por_idioma.png",width=3200,height=1800,res=300)
print(p0)
dev.off()

png("ret_por_usuario_por_idioma.png",width=3200,height=1800,res=300)
print(p1)
dev.off()

png("ret_por_usuario_no_pt.png",width=3200,height=1800,res=300)
print(p2)
dev.off()

png("ret_por_usuario_pt.png",width=3200,height=1800,res=300)
print(p3)
dev.off()

png("ret_por_usuario_es.png",width=3200,height=1800,res=300)
print(p4)
dev.off()

png("ret_por_usuario_en.png",width=3200,height=1800,res=300)
print(p5)
dev.off()

png("ret_por_usuario_fr.png",width=3200,height=1800,res=300)
print(p6)
dev.off()


