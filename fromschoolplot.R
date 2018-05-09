library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)


fromschool_data <- read_csv('./rawdatas/fromschool.csv')



# selected_colname_fromschool<- NULL
# for (year in 10:as.numeric(substr(year_value,3,4))-1) {
#   selected_colname_fromschool <- c(selected_colname_fromschool, paste("y",year, sep=""))
# }
# selected_colname_fromschool

school_index <-1

selected_data_fromschool <- fromschool_data %>% filter(schoolindex == 3) %>% group_by(school) %>%
  mutate(tot = sum(y9, y10, y11, y12, y13, y14, y15, y16, y17)) %>% arrange(desc(tot)) %>% distinct(school,tot)

top5 <- selected_data_fromschool %>%  head(5)

etc <- data.frame(school='기타',tot=sum(selected_data_fromschool$tot)-sum(top5$tot))

fromschool <- bind_rows(top5,etc)

fromschool$school <- factor(fromschool$school, levels = rev(as.character(fromschool$school)))

from <- fromschool %>% arrange(school)

text_y <- data.frame(pos = rev(cumsum(fromschool$tot)-fromschool$tot/2))

# data 2 plot

p <- ggplot(from,aes(x='',y=tot,fill=school)) + geom_bar(width = 1, size =1, color = 'white', stat = 'identity')
p <- p+coord_polar('y', start = 0)
p <- p + theme_minimal() + theme(axis.title = element_blank(), axis.text = element_blank(), panel.grid = element_blank(), legend.position = 'none')
p <- p + scale_fill_grey(start = 0.8, end = 0.1)
p + geom_text(aes(label=paste(school,tot), y = text_y), nudge_x = 0.7 )

##################################################################################################여기까지
# etc_label <- selected_data_fromschool %>% tail(sum(tally(selected_data_fromschool)$n)-5)
# etc_label <- sprintf("%s(%s)", etc_label$school, etc_label$sum)
# temp <- NULL
# for (i in etc_label) {
#   if (is.null(temp)) {
#     temp <- i
#   }else{
#     temp <- paste(temp, ", ",i)}
# }
# etc_label <- temp
# etc_label

etc_label <- selected_data_fromschool %>% tail(-5)

a = paste(etc_label$school,'(',etc_label$tot,')', collapse = ', ')
print(a)
