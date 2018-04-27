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

#testing testing


#r studio에서 작성한 걸 바로 commit 하는 것을 테스트해보자 

#다시해보자 