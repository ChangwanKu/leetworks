library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

# 모집인원 pie chart

entrance <- read.csv('./rawdatas/모집인원(16,17,18,19).csv')

ent1 <- entrance %>% filter(schoolindex == 1 & year == 2018) %>% select(3:7) %>% rename()%>% gather()

ent2 <- ent1 %>% filter(value != 0) %>% arrange(desc(value)) %>% mutate(text_y = cumsum(value) - value/2)

ent2$key <- factor(ent2$key,levels = rev(as.character(ent2$key)))

p <- ggplot(ent2,aes(x='',y=value,fill=key)) + geom_bar(width = 1,stat = 'identity', color = 'white')
p <- p + coord_polar(theta = 'y', start = 0 )

p <- p + theme_minimal() + theme(axis.title = element_blank(), axis.text = element_blank(), panel.grid = element_blank(), legend.position = 'bottom', legend.title = element_blank()) + guides(fill = guide_legend(reverse = TRUE))

# p + scale_fill_manual(values = c('#FFCCFF','#FF99CC','#FF3399','#FF33FF','#FF00FF','#FF00CC'))

p <- p + geom_text(aes(label = value, y = text_y), nudge_x = .7) + scale_fill_manual(values = c("#FF7FFF", "#FF4CFF", "#FF33FF", "#FF00FF"))

# table plot
p

standard <- read.csv('./rawdatas/entrance_standard.csv')

stan1 <- standard %>% filter(schoolindex == 1 & year == 2018) %>% select(level,leet,gpa,lang,doc,essay,interview,sum) %>% replace(.,is.na(.),0)


# pie 랑 table 합체 
g<-tableGrob(stan1, rows = NULL, theme = ttheme_minimal(padding = unit(c(20,40), 'mm')))

g<-gtable_add_grob(g, grobs = segmentsGrob(x0 = unit(0,"npc"),
                                           y0 = unit(0,"npc"),
                                           x1 = unit(1,"npc"),
                                           y1 = unit(0,"npc"),
                                           gp = gpar(lwd = 2.0, col = "#FF7FFF")),
                   t = 1, b = 1, l = 1, r = ncol(g))

g<-gtable_add_grob(g, grobs = segmentsGrob(x0 = unit(0,"npc"),
                                           y0 = unit(0,"npc"),
                                           x1 = unit(1,"npc"),
                                           y1 = unit(0,"npc"),
                                           gp = gpar(lwd = 2.0, col = "#FF7FFF")),
                   t = 1, b = 2, l = 1, r = ncol(g))


g<-gtable_add_grob(g, grobs = segmentsGrob(x0 = unit(0,"npc"),
                                           y0 = unit(0,"npc"),
                                           x1 = unit(1,"npc"),
                                           y1 = unit(0,"npc"),
                                           gp = gpar(lwd = 2.0, col = "#FF7FFF")),
                   t = 2, b = 3, l = 1, r = ncol(g))


ggarrange(p,g, ncol = 2)
