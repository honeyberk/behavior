library(devEMF)
emf(file="Std.emf", 
    width=7.5, 
    height=10, 
    pointsize=12)

plot1 <- pre_post.stat.mean.ordered %>%
  ggplot(aes(x = Behavior, y = mean, fill = group)) +
  geom_bar(stat = "identity", position = "dodge") + 
  scale_fill_manual(values=col2hex(c("purple","orange"))) +
  geom_errorbar(aes(ymin = mean - sem, ymax = mean + sem), position = position_dodge(0.9)) +
  geom_text(aes(label=sig_level), position = position_dodge(0.9)) +
  theme_bw()+coord_flip()+theme(legend.position="bottom",axis.title.x=element_blank(),
                                axis.title.y=element_blank())
#ggtitle("Paired bar chart for all individual Behaviors with SEM whiskers")

vp.BottomRight <- viewport(height=unit(0.907, "npc"),
                           width=unit(0.5, "npc"), 
                           just=c("left","top"), 
                           y=0.928, x=0.452)

par(mfrow=c(1,2))

beanplot(Improvement ~ reorder(Group, Improvement, mean) * Behavior, bw="nrd0", data = plotframe,
         side = "b", horizontal = TRUE, yaxt = "n", las=1, col = list("purple", "orange"), border = c("purple2","darkorange"), ylim = c(-1.5,1.5), yaxs = "i")
axis(4, at=1:length(lvl), labels=FALSE)

#ylab = "Behavior", 
#main = "Improvement on Each Behavior", xlab = "Improvement", 
#legend("bottomright", bty="n",c("Control", "LogCheck"), fill = c("purple", "orange"))

print(plot1, vp=vp.BottomRight)

dev.off()