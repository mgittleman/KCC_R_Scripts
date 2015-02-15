ss = read.csv("ss2014.csv")

ss.yesno = subset(ss, select=(c(3:5,7:8,10:12,15:32,35:38,40)))

ss.yesno.f = t(sapply(ss.yesno, FUN=table))
ss.yesno.f = as.data.frame(ss.yesno.f)
names(ss.yesno.f) = c("No", "Yes", "Blank")
ss.yesno.f$pct_yes=round(ss.yesno.f$Yes/(ss.yesno.f$Yes + ss.yesno.f$No + ss.yesno.f$Blank)*100)
ss.yesno.f

# saw demo
ss.saw_demo=ss.yesno[ss.yesno$saw_demo == "yes",]

ss.demo.f = t(sapply(ss.saw_demo, FUN=table))
ss.demo.f = as.data.frame(ss.demo.f)
names(ss.demo.f) = c("No", "Yes", "Blank")
ss.demo.f$pct_yes=round(ss.demo.f$Yes/(ss.demo.f$Yes + ss.demo.f$No + ss.demo.f$Blank)*100)
ss.demo.f

ss.nodemo=ss.yesno[ss.yesno$saw_demo %in% c(0,2),]
ss.nodemo.f = t(sapply(ss.nodemo, FUN=table))
ss.nodemo.f = as.data.frame(ss.nodemo.f)
ss.nodemo.f

ss.rcard=ss.yesno[ss.yesno$took_recipes == 1,]
ss.rcard.f = t(sapply(ss.rcard, FUN=table))
ss.rcard.f = as.data.frame(ss.rcard.f)
ss.rcard.f

ss.norcard=ss.yesno[ss.yesno$took_recipes == 0,]
ss.norcard.f = t(sapply(ss.norcard, FUN=table))
ss.norcard.f = as.data.frame(ss.norcard.f)
ss.norcard.f