#plot 3

# Examine household energy usage varies over a 2-day period 
# 
## 1. read the household_power_consumption.txt file
## 2. subset for data taken from 2 days: 2007-02-01 and 2007-02-02
## 3. generate a plot of all the Sub metering (1,2,and 3)

# set working directory  
wdir <- "c:/Users/alice.c.hsi2.NAE/Documents/R/RtutorialJHU"
setwd(wdir)

#install packages

install.packages("data.table")
library(data.table) 
install.packages("dplyr")
library(dplyr)
library(datasets)

#read the data, assuming the data has been downloaded
power <- fread("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?",stringsAsFactors = FALSE)

subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

#convert from class characters to correct class
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- format(subpower$Time, format="%H:%M:%S")

subpower$Global_active_power <- as.numeric(subpower$Global_active_power)
subpower$Global_reactive_power <- as.numeric(subpower$Global_reactive_power)
subpower$Voltage <- as.numeric(subpower$Voltage)
#subpower$Global_intensity <- as.numeric(powerdata$Global_intensity)
subpower$Sub_metering_1 <- as.numeric(subpower$Sub_metering_1)
subpower$Sub_metering_2 <- as.numeric(subpower$Sub_metering_2)
subpower$Sub_metering_3 <- as.numeric(subpower$Sub_metering_3)

#put a new column to subpower, datetime
datetime <- paste(subpower$Date, subpower$Time)
subpower$Datetime <- as.POSIXct(datetime)


#plot 3, basic plot of Sub Metering 1,2,3 vs DateTime
png("plot3.png", width=480, height=480)
with(subpower, plot(Datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subpower$Datetime, subpower$Sub_metering_2,type="l", col= "red")
lines(subpower$Datetime, subpower$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()

