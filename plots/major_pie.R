library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

# csv open
major <- read_csv('./rawdatas/major.csv')
head(major)

# chart 에 맞게 변형

major1 <- major %>% filter(schoolindex == 1) %>% 
  select(law,human,nature) %>% gather() %>% arrange(desc(value))

major1$key <- factor(major1$key,levels = rev(major1$key))

p <- ggplot(major1,aes(x=key,y=value,fill=key)) + geom_bar(stat = 'identity', width = 0.5) 
p <- p + coord_flip() + geom_text(aes(label = value), hjust = -0.2)
p <- p + theme_minimal() + theme(axis.title = element_blank(), axis.text.x = element_blank(), panel.grid.major.y = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.x = element_line(color = 'gray'), legend.position = 'bottom', legend.title = element_blank())

p + scale_fill_manual(values = c('#FF00FF','#FF99ff','#ffccff'))

