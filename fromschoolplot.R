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

library(googleVis)

pie2 <- gvisPieChart(csv2)
t <- gvisTable(csv2)
plot(pie2)
pie2t <- gvisMerge(pie2,t,horizontal = TRUE)
plot(pie2t)

header <- pie2t$html$header
header <- gsub("charset=utf-8", "charset=euc-kr", header)
pie2t$html$header <- header
plot(pie2t)
