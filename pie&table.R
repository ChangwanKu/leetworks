library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

# 모집인원 pie chart

entrance <- read.csv('./rawdatas/application.csv')

ent1 <- entrance %>% filter(schoolindex == 1 & year == 2018) %>% select(3:7) %>% rename()%>% gather()

ent2 <- ent1 %>% filter(value != 0) %>% arrange(desc(value)) %>% mutate(text_y = cumsum(value) - value/2)

ent2$key <- factor(ent2$key,levels = rev(as.character(ent2$key)))

p <- ggplot(ent2,aes(x='',y=value,fill=key)) + geom_bar(width = 1,stat = 'identity', color = 'white')
p <- p + coord_polar(theta = 'y', start = 0 )

p <- p + theme_minimal() + theme(axis.title = element_blank(), axis.text = element_blank(), panel.grid = element_blank(), legend.position = 'bottom', legend.title = element_blank()) + guides(fill = guide_legend(reverse = TRUE))

# p + scale_fill_manual(values = c('#FFCCFF','#FF99CC','#FF3399','#FF33FF','#FF00FF','#FF00CC'))

p <- p + geom_text(aes(label = value, y = text_y), nudge_x = .7) + scale_fill_grey(start = 0.8, end = 0.2)

# table plot
p

standard <- read.csv('./rawdatas/entrance_standard.csv')

stan1 <- standard %>% filter(schoolindex == 1 & year == 2018) %>% select(level,leet,gpa,lang,doc,essay,interview,sum) %>% replace(.,is.na(.),0)


# pie 랑 table 합체 

g <- ggtexttable(stan1, rows = NULL, theme = ttheme(tbody.style = tbody_style(fill = 'white'), padding = unit(c(20, 30), "mm")))
ggarrange(p,g,ncol = 2, nrow = 1)
