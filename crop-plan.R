library(RCurl)
u <- "https://docs.google.com/spreadsheet/pub?key=0ApkeP-XuGVq9dE8xcFJMQ3RSb1IyNk0zWDJERnRwM0E&single=true&gid=2&output=csv"
tc <- getURL(u, ssl.verifypeer=FALSE)
harvest <- read.csv(textConnection(tc))

harvest.dates=harvest[,c('CROP', 'EST..FIRST.HARVEST', 'EST..LAST.HARVEST', 'HARVEST.WINDOW', 'X.2')]
names(harvest.dates) = c("crop", "first", "last", "window", "type")
harvest.dates = harvest.dates[-2,]
harvest.dates = harvest.dates[-1,]

harvest.dates[,2] = as.Date(harvest.dates[,2],format='%m/%d/%Y')
harvest.dates[,3] = as.Date(harvest.dates[,3],format='%m/%d/%Y')

library('timeDate')
library('scales')
library('reshape2')
library('lubridate')
dur = new_duration(days = harvest.dates$window)

harvest.dates2=data.frame(name=harvest.dates$crop, start.date=c(harvest.dates$first), end.date=c(harvest.dates$last))

library(ggplot2)
ggplot(harvest.dates, aes(xmin = first, xmax = last, ymin=0, ymax=1.2, fill = type)) + 
  geom_rect() +
  facet_grid(crop~.) + 
  theme(axis.text = element_text(color="black", size=10), axis.text.x = element_text(angle=90, vjust=0.5), axis.ticks = element_blank(), strip.text = element_text(size=10), strip.text.y = element_text(angle=0)) + 
  labs(x="Harvest Window", y="Crops") 