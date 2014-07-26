#Explore Data Course Project No. 2

NEI <- readRDS("summarySCC_PM25.rds")


#1.Have total emissions from PM2.5 decreased in the United States from 
#1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

#Create a data frame for the total of emissions for different year and type
sum_nei <- tapply(NEI$Emissions, NEI$year, sum)
sum_nei <- data.frame(sum_nei)
#need to convert rownames (year) into another column "year"
sum_nei$year <- rownames(sum_nei) 

#base system plot
library(datasets)
png("p2_plot1.png", width=480, height=480)
with(sum_nei, plot(year, sum_nei, type = "l",
                   main = "Total Emissions vs. Year",
                   xlab = "Year", ylab = expression("Total " * PM[2.5])))
dev.off()

#From the plot shows that the Total Emissions have been decreased.
