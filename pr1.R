#Load in necessary libraries
library(dplyr)
library(data.table)
setwd("C:/Users/kishored/Dropbox/MyWork/EDA with R/Week1 Project/")
#Reads in data from file then subsets data for specified dates
fh <- fread("household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
pwrcons <- filter(fh, Date == "1/2/2007" || Date == "2/2/2007")
head(pwrcons)
pwrcons <- filter(fh, grepl("[1,2]/2/2007",fh$Date))
head(pwrcons)
# pwrcons <- fh[fh$Date == "1/2/2007" | fh$Date == "2/2/2007", ]
# The code above works 
# pwrcons <- filter(fh, regexpr("^[1,2]/2/2007", Date)) #does not work
# pwrcons <- filter(fh, grep("/2/2007", Date))
# The code below works as well:
pwrcons <- subset(fh, regexpr("^[1,2]/2/2007", fh$Date) > 0)
#Convert global active power column, global reactive power colums, Sub_metering columns, and the Voltage column to numeric
pwrcons$Global_active_power <- as.numeric(as.character(pwrcons$Global_active_power))

pwrcons$Global_reactive_power <- as.numeric(as.character(pwrcons$Global_reactive_power))

pwrcons$Sub_metering_1 <- as.numeric(as.character(pwrcons$Sub_metering_1))
pwrcons$Sub_metering_2 <- as.numeric(as.character(pwrcons$Sub_metering_2))
pwrcons$Sub_metering_3 <- as.numeric(as.character(pwrcons$Sub_metering_3))

pwrcons$Voltage <- as.numeric(as.character(pwrcons$Voltage))

#Creates new column that combines date and time data 
pwrcons$Timestamp <-paste(pwrcons$Date, pwrcons$Time)
#Create histogram for Global Active Power
hist(pwrcons$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file= "pr1.png")
dev.off()
