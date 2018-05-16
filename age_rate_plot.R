library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


age <- read.csv('./rawdatas/age.csv')
age1 <- age %>% filter(schoolindex == 1) %>% select(ends_with('14'),ends_with('15'),ends_with('16'),ends_with('17')) %>% gather()
age2 <- age1 %>% mutate(group = substr(key,1,1),year = substr(key,2,3))

p <- age2 %>% ggplot(aes(x=year,y=value,fill=group)) + geom_bar(stat = 'identity', width = 0.5)
p <- p + scale_x_discrete(labels=seq(2014,2017,1))
p <- p + theme_minimal() + theme(legend.position="bottom", legend.direction="horizontal", legend.title = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank(), panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color = 'gray'), panel.grid.minor.y = element_blank(), axis.ticks = element_blank())
p <- p + scale_fill_manual(values = c('#FF00FF','#FF99ff','#ffccff'), labels = c('29세 이상','26~28세','25세 이하')) + labs(caption = '단위 : %')
p
