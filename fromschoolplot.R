library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


# laod csv

csv <- read_csv('./rawdatas/fromschool.csv')
str(csv)

# clean data

csv2 <- csv %>% filter(schoolindex==1) %>% group_by(school) %>%
  mutate(sum = sum(y9, y10, y11, y12, y13, y14, y15, y16, y17)) %>% arrange(desc(sum)) %>% distinct(school,sum)
  
 
top5 <- csv2 %>%  head(5)

etc <- data.frame(school='기타',sum=sum(csv2$sum)-sum(top5$sum))

fromschool <- bind_rows(top5,etc)

fromschool$school <- factor(fromschool$school, levels = rev(as.character(fromschool$school)))


# data 2 plot

bp <- ggplot(fromschool,aes(x='',y=sum,fill=school)) + geom_bar(width = 1, size = 1, color = 'white', stat = 'identity')
bp  

pie <- bp+coord_polar('y')

pie + theme_void() + guides(fill = guide_legend(reverse = TRUE))


csv2 %>% tail(sum(tally(csv2)$n)-5)
