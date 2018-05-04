library(dplyr)
library(tidyr)
library(ggplot2)

a <- read.csv('./rawdatas/sex.csv')
head(a)


a1 <- a %>% rename(schoolindex = 癤퓋choolindex) %>% filter(schoolindex == 1) %>% select(m14, w14, m15, w15, m16, w16, m17, w17)
a1

a2 <- gather(a1)
a2

a3 <- a2 %>% mutate(group=substr(key,1,1),year=substr(key,2,3))
a3
p <- ggplot(a3,aes(x=year, y=value, fill = group)) + geom_bar(stat='identity', position = 'dodge', width = 0.5)

p + geom_text(aes(x=year, y=value, label = paste0(value)),size=10,vjust=-0.5, position = position_dodge(0.5)) + 
  labs(title='남녀비율') + 
  theme(legend.position="bottom", legend.direction="horizontal", legend.title = element_blank()) + 
  scale_fill_manual(values = c('#FF00FF','#FFCCFF'), labels = c('남','여')) +
  scale_x_discrete(labels=seq(2014,2017,1)) + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), panel.grid.major.x = element_blank(), panel.grid.major.y = element_line(color = 'gray'), panel.grid.minor.y = element_line(color='gray'), axis.ticks = element_blank(), plot.title = element_text(face='bold',hjust=0), panel.background = element_blank(), axis.text.y = element_blank(), axis.text.x = element_text(size = 20) )
                                                                                                                     