library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

csv <- read.csv('./rawdatas/foreign.csv')

foreign <- csv %>% rename(schoolindex = 癤퓋choolindex) %>% filter(schoolindex == 1) %>% select(f14, f15, f16, f17)

foreign <- gather(foreign)

foreign

p <- ggplot(foreign,aes(key,value)) + geom_bar(stat='identity',width = 0.5, fill='#FF00FF')
p <- p + geom_text(aes(key,value,label = paste0(value)),vjust=-0.5) + scale_x_discrete(labels=seq(2014,2017,1))
p + theme_minimal() + theme(axis.ticks = element_blank(),axis.title = element_blank(), axis.text.y = element_blank(), panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color = 'gray'), panel.grid.minor.y = element_line(color='gray'))
