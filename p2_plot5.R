#Explore Data Course Project No. 2

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(reshape2)

#5.How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City? 
#Baltimore City has fips = "24510"

#Select only Baltimore City from NEI
Bal_NEI <- NEI[grep("24510",NEI$fips),]
#Find motor vehicle sources from SCC$EI.Sector using key word "Mobile"
Ve_SCC <- SCC[grep("^Mobile", SCC$EI.Sector),]
Ve_SCC2 <- Ve_SCC[,c(1,4)] #shorten the data frame to save run time when merge
Bal_NEI2 <- merge(Bal_NEI, Ve_SCC2, by.x = "SCC", by.y= "SCC", all = FALSE)

#Find the total Emission for different years
sum_nei5 <- melt(tapply(Bal_NEI2$Emissions, Bal_NEI2$year, sum))
colnames(sum_nei5) <- c("year","Emissions")

library(ggplot2)
png("p2_plot5.png", width=480, height=480)
ggplot(sum_nei5, aes(x=year,y=Emissions)) + geom_line() + labs(title = "Total Emissions from Motor Vehicles in Baltimore City")
dev.off()
#It shows that the total Emissions from Coal combustion-related source
#have been decreased from 1999-2002 and started to increase from 2002-2008
