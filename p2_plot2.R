#Explore Data Course Project No. 2

NEI <- readRDS("summarySCC_PM25.rds")

#2.Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

#Select any rows where fips = 24510
data <- NEI[grep("24510",NEI$fips),]
sum_data <- tapply(data$Emissions, data$year, sum)

#convert matrix sum_data to data frame
sum_data <- data.frame(sum_data)
sum_data$year <- rownames(sum_data)

#base system plot
library(datasets)
png("p2_plot2.png", width=480, height=480)
with(sum_data, plot(year, sum_data, type = "l",
                   main = "Total Emissions vs. Year in Baltimore City, Maryland",
                   xlab = "Year", ylab = expression("Total " * PM[2.5])))
dev.off()

#From the plot shows that the Total Emissions in Baltimore City have been decrease.
