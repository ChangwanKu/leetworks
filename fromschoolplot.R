library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


# laod csv

raw_data_fromschool <- read_csv('./rawdatas/fromschool.csv')
raw_data_fromschool
str(raw_data_fromschool)
selected_colname_fromschool<- NULL
for (year in 10:as.numeric(substr(year_value,3,4))-1) {
  selected_colname_fromschool <- c(selected_colname_fromschool, paste("y",year, sep=""))
}
selected_colname_fromschool
school_index <-1
selected_data_fromschool <- raw_data_fromschool %>% filter(schoolindex==school_index) %>% group_by(school) %>%
  mutate(sum = sum(selected_colname_fromschool)) %>% arrange(desc(sum)) %>% distinct(school,sum)

top5 <- selected_data_fromschool %>%  head(5)

etc <- data.frame(school='기타',sum=sum(selected_data_fromschool$sum)-sum(top5$sum))
fromschool <- bind_rows(top5,etc)
fromschool$school <- factor(fromschool$school, levels = rev(as.character(fromschool$school)))

# data 2 plot

bp <- ggplot(fromschool,aes(x='',y=sum,fill=school)) + geom_bar(width = 1, size = 1, color = 'white', stat = 'identity')
pie <- bp+coord_polar('y')
pie + theme_void() + guides(fill = guide_legend(reverse = TRUE))

etc_label <- selected_data_fromschool %>% tail(sum(tally(selected_data_fromschool)$n)-5)
etc_label <- sprintf("%s(%s)", etc_label$school, etc_label$sum)
temp <- NULL
for (i in etc_label) {
  if (is.null(temp)) {
    temp <- i
  }else{
    temp <- paste(temp, ", ",i)}
}
etc_label <- temp
etc_label
