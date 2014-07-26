#Explore Data Course Project No. 2
setwd("C:/Coursera/Data Science/Explore_Data/")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(reshape2)

#6.Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Getting the Emissions from motor vehicle sources in Baltimore City
Bal_NEI <- NEI[grep("24510",NEI$fips),]
#Find motor vehicle sources from SCC$EI.Sector using key word "Mobile" for
#Baltimore City
Ve_SCC <- SCC[grep("^Mobile", SCC$EI.Sector),]
Ve_SCC2 <- Ve_SCC[,c(1,4)] #shorten the data frame to save run time when merge
Bal_NEI2 <- merge(Bal_NEI, Ve_SCC2, by.x = "SCC", by.y= "SCC", all = FALSE)

#Find the total Emission for different years
sum_Bal_NEI <- melt(tapply(Bal_NEI2$Emissions, Bal_NEI2$year, sum))
colnames(sum_Bal_NEI) <- c("year","Emissions")
sum_Bal_NEI$Location <- rep("Baltimore City", times = nrow(sum_Bal_NEI))

#Getting the Emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037")
LA_NEI <- NEI[grep("06037",NEI$fips),]
#Find motor vehicle sources from SCC$EI.Sector using key word "Mobile" for LA
LA_NEI2 <- merge(LA_NEI, Ve_SCC2, by.x = "SCC", by.y= "SCC", all = FALSE)

#Find the total Emission for different years
sum_LA_NEI <- melt(tapply(LA_NEI2$Emissions, LA_NEI2$year, sum))
colnames(sum_LA_NEI) <- c("year","Emissions")
sum_LA_NEI$Location <- rep("Los Angeles", times = nrow(sum_LA_NEI))

#combine results from Baltimore City and Los Angeles
Final <- rbind(sum_Bal_NEI, sum_LA_NEI)
Final$Location <- factor(Final$Location)

library(ggplot2)
png("p2_plot6.png", width=480, height=480)
ggplot(data=Final, aes(x=year, y=Emissions, group=Location, colour=Location, shape=Location))+geom_line()+geom_point()+labs(title = "Total Emissions for different locations")
dev.off()

#From the graph shows that Los Angeles has a greater change in 
#total Emissions than Baltimore City
 