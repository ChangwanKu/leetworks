library('dplyr')
library('tidyr')

a <- read.csv('e:/data/scatter1.csv')
a1 <- a %>% select(label,합격률)
a1
library('ggplot2')

p <- ggplot(a1,aes(x=0,y=합격률))
p1 <- p + geom_point() + 
  geom_text(aes(label = label),
                             color = "black", size = 2.5)


library(gridExtra)

b <- read.csv('e:/data/easyplot.csv')
b
grid.arrange(tableGrob(b),p1,ncol=2)



