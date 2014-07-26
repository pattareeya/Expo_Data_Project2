#Explore Data Course Project No. 2

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(reshape2)

#4.Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999–2008?

#Search for "coal" in SCC$Short.name  
coalSCC<-SCC[grep("+([a-zA-z]+) +[Cc]oal", SCC$Short.Name),]
coalSCC2 <- coalSCC[,c(1,3)]#shorten the data frame to save run time when merge

mergedData = merge(NEI,coalSCC2,by.x="SCC",by.y="SCC",all=FALSE)
#Find the total Emission for different years
sum_nei4 <- melt(tapply(mergedData$Emissions, mergedData$year, sum))
colnames(sum_nei4) <- c("year","Emissions") 
library(ggplot2)
png("p2_plot4.png", width=480, height=480)
ggplot(sum_nei4, aes(x=year,y=Emissions)) + geom_line() + labs(title = "Total Emissions from Coal Combustion-Related Sources")
dev.off()
#It shows that the total Emissions from Coal combustion-related source
#have been decreased from 1999-2008
