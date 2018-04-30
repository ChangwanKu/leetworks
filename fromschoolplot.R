library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


# laod csv

csv <- read_csv('./rawdatas/fromschool.csv')
str(csv)

# clean data

csv2 <- csv %>% filter(schoolindex==1) %>% group_by(school) %>%
  mutate(sum = sum(y9, y10, y11, y12, y13, y14, y15, y16, y17)) %>% arrange(desc(sum)) %>% distinct(school,sum) %>%
  head(5)


csv3 <- csv %>% filter(schoolindex==1) %>% group_by(school) %>%
  mutate(sum = sum(y9, y10, y11, y12, y13, y14, y15, y16, y17)) %>% arrange(desc(sum)) %>% distinct(school,sum) 

csv3 <- data.frame(school='기타',sum=sum(csv3$sum)-sum(csv2$sum))

fromschool <- bind_rows(csv2,csv3)

# data 2 plot

bp <- ggplot(fromschool,aes(x='',y=sum,fill=school)) + geom_bar(width = 1, stat = 'identity')
bp  

pie <- bp+coord_polar('y',start=0)

pie + theme_void()
