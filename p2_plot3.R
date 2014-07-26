#Explore Data Course Project No. 2
setwd("C:/Coursera/Data Science/Explore_Data/")
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
library(reshape2)

#3.Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
sum_nei3 <- melt(tapply(NEI$Emissions, list(NEI$year, NEI$type), sum))
head(sum_nei3)
colnames(sum_nei3)<-c("year","type", "Emissions")

library(ggplot2)
sum_nei3 = transform(sum_nei3, type = factor(type))
png("p2_plot3.png", width=480, height=480)
ggplot(data=sum_nei3, aes(x=year, y=Emissions, group=type, colour=type, shape=type))+geom_line()+geom_point()+labs(title = "Total Emissions vs. Year")
dev.off()
#All of them showed that total emissions has been decreased from year 1999-2008

