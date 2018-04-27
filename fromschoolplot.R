library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


# laod csv

csv <- read_csv('e:/data/law/fromschool.csv')
str(csv)

# clean data

csv2 <- csv %>% filter(schoolindex=='강원대') %>% group_by(school) %>%
  mutate(sum = sum(y09, y10, y11, y12, y13, y14, y15, y16, y17)) %>% arrange(desc(sum)) %>% distinct(school,sum) %>% 
  head(5)

csv2

# data 2 plot

bp <- ggplot(csv2,aes(x='',y=sum,fill=school)) + geom_bar(width = 1, stat = 'identity')
bp  

pie <- bp+coord_polar('y',start=0)
pie
