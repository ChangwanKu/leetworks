library('dplyr')
library('tidyr')

a <- read.csv('e:/data/easyplot.csv')
str(a)
a1 <- a %>% select(-1) %>% filter(year==2016)
a2 <- gather(a1,,,-1)
a2
library('ggplot2')

pie <- ggplot(a2, aes(x="", y=value, fill=key)) + 
  geom_bar(width = 1, stat = 'identity')
pie <- pie + coord_polar("y", start=0)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

library('scales')

pie + scale_fill_brewer("Blues") + blank_theme +
  theme(axis.text.x=element_blank())+
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)
