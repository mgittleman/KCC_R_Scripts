people = read.csv("FarmPeople2014.csv")

# turn columns into numbers
people[, 5] <- as.numeric(as.character( people[, 5] ))

# aggregate by things
people.type=aggregate(people$Attendees, by=list(people$Type, people$Season), FUN=sum, na.rm=TRUE)
names(people.type) = c("type", "season", "attendees")
people.type$ID = seq.int(nrow(people.type))

library(plyr)
people.typecount2=count(people, c("Type"))
people.typecount3=count(people, c("Season", "Type"))
people.typecount3$ID = seq.int(nrow(people.typecount3))
people.typecount4 = merge(people.typecount3, people.type, by.x="ID", by.y="ID")
people.typecount4 = subset(people.typecount4, select = c("Season", "Type", "freq", "attendees"))

# just tours, events
tours = people[people$Type == "Tour", ]
events = people[people$Type == "Event", ]

# organize by month
library("lubridate")
tours$Date = strptime(tours$Date, "%m/%d/%y")
tours$Month = floor_date(tours$Date, "month")

events$Date = strptime(events$Date, "%m/%d/%y")
events$Month = floor_date(events$Date, "month")

# combine tours and events
tours.events = rbind(tours, events)

# line plot
library(ggplot2)
plot(tours$Month, tours$Attendees, type="l", xlab="Month",
     ylab="# Attendees")

qplot(Date, Attendees, data=tours.events, color=as.factor(Type), group=Type, geom="line")
qplot(Month, freq, data=people.typecount3, color=as.factor(Type), group=Type, geom="line")

# See sums in groups
print(people.typecount4)
print(people.typecount2)
print(people.type)
write.csv(people.typecount4, file="people-summary.csv")

# barplot of frequency of classes, tours, events
people.typecount4$Season = factor(people.typecount4$Season, levels=c("winter", "spring", "summer", "fall"))
ggplot(people.typecount4, aes(x=Season, y=freq, label=attendees)) +
  geom_bar(stat="identity", aes(fill=Type),position="dodge") +
  labs(x = "Season", y = "Frequency") +
  theme(text = element_text(size=14), axis.text.x = element_text(vjust=0.5), axis.text=element_text(color="black", size=14, hjust=1, vjust=0.5), panel.grid.major = element_line(colour = "grey90"), panel.grid.minor = element_blank(), panel.background = element_blank(),
        axis.ticks = element_blank(), legend.text=element_text(size=14)) +
  scale_y_continuous(breaks=1:30)