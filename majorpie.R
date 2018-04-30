library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# csv open
csv <- read_csv('./rawdatas/major.csv')
head(csv)

# chart 에 맞게 변형

major <- csv %>% filter(schoolindex == 1) %>% 
  select(law,human,nature) %>% gather()

major

p <- ggplot(major,aes(x='',y=value,fill=key)) + geom_bar(width = 1, size =1, stat = 'identity')

pie <- p+coord_polar('y')

pie
