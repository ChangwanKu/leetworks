library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# csv open
a <- read_csv('e:/data/law/major.csv')
head(a)
str(a)

# chart 에 맞게 변형

a1 <- a[1,]

a2 <- gather(a1)
a2

a3 <- a2 %>% filter(key == '법학' | key == '비법(문과)' | key == '비법(이과)')


p <- ggplot(a3,aes(x='',y=value,fill=key)) + geom_bar(width = 1, stat = 'identity')

pie <- p+coord_polar('y',start=0)

pie
