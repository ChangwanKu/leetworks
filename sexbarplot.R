library(dplyr)
library(tidyr)
library(ggplot2)

a <- read.csv('e:/data/law/sex.csv')
head(a)

a1 <- a %>% filter(schoolindex == 1) %>% select(m14, w14, m15, w15, m16, w16, m17, w17)
a1

a2 <- gather(a1)
a2

a3 <- a2 %>% mutate(group=substr(key,1,1),year=substr(key,2,3))
a3
ggplot(a3,aes(x=year, y=value, fill = group)) + geom_bar(stat='identity', position = 'dodge')

