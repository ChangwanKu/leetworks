library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


csv <- read.csv('./rawdatas/age.csv')
csv2 <- csv %>% filter(schoolindex == 1) %>% select(ends_with('14'),ends_with('15'),ends_with('16'),ends_with('17')) %>% gather()
csv3 <- csv2 %>% mutate(group = substr(key,1,1),year = substr(key,2,3))

p <- csv3 %>% ggplot(aes(year,value,group=group,color=group)) + geom_line() + geom_point()
p + theme_classic()
