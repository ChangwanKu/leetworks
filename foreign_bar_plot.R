library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

csv <- read.csv('./rawdatas/foreign.csv')

foreign <- csv %>% rename(schoolindex = 癤퓋choolindex) %>% filter(schoolindex == 1) %>% select(f14, f15, f16, f17)

foreign <- gather(foreign)

foreign

p <- ggplot(foreign,aes(key,value)) + geom_bar(stat='identity')

p + theme_minimal()
