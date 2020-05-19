#plot 2
  
# Examine household energy usage varies over a 2-day period 
  # 
  ## 1. read the household_power_consumption.txt file
  ## 2. subset for data taken from 2 days: 2007-02-01 and 2007-02-02
  ## 3. generate a plot of global active power(kilowatts)
  
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
  
  
  #plot 2, basic plot of Global Active Power vs DateTime
  png("plot2.png", width=480, height=480)
  with(subpower, plot(Datetime, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))
  dev.off()

