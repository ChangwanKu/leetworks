library(dplyr)
library(tidyr)
library(ggplot2)


a <- read.csv('./rawdatas/myschool.csv')
head(a)

a1 <- a %>% filter(癤퓋choolindex == 1) %>% select(m14, o14, m15, o15, m16, o16, m17, o17)
a1



a2 <- gather(a1)
a2

a3 <- a2 %>% mutate(group=substr(key,1,1),year=substr(key,2,3))
a3
p <- ggplot(a3,aes(x=year, y=value, fill = group)) + geom_bar(stat='identity', position = 'dodge', width = 0.5)
p <- p + geom_text(aes(x=year, y=value, label = paste0(value)),vjust=-0.5, position = position_dodge(0.5)) + scale_x_discrete(labels=seq(2014,2017,1))
p <- p + theme_minimal() + theme(axis.ticks = element_blank(),axis.title = element_blank(), axis.text.y = element_blank(), panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color = 'gray'), panel.grid.minor.y = element_line(color='gray'))
p + theme(legend.position="bottom", legend.direction="horizontal", legend.title = element_blank()) + scale_fill_manual(values = c('#FF00FF','#FFCCFF'), labels = c('자','타'))


