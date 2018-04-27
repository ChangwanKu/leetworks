library(dplyr)
library(tidyr)
library(ggplot2)

# 모집인원 pie chart

a <- read.csv('e:/data/law/abc2.csv')
head(a)
str(a)

a1 <- a %>% filter(schoolindex == 1 & year == 2018)
a1

a2 <- gather(a1,,,-1)
a2

a3 <- a2 %>% filter(key == 'a' | key == 'b')
a3


bp <- ggplot(a3,aes(x='',y=value,fill=key)) + geom_bar(width = 1, stat = 'identity')
bp  

pie <- bp+coord_polar('y',start=0)


blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )


pie <- pie + scale_fill_grey() + blank_theme +  theme(axis.text.x=element_blank())

# table plot

tp <- read.csv('e:/data/law/abc.csv')
head(tp)
str(tp)
tp1 <- tp %>% filter(schoolindex == 1 & year == 2018) %>% select(level,leet,gpa,lang,doc,essay,interview,sum)
tp1[is.na(tp1)] <- 0
tp1

library(gridExtra)

# pie 랑 table 합체 ㅁㅁㅁㅁㅁ

grid.arrange(pie,tableGrob(tp1, rows = NULL),nrow=1)
