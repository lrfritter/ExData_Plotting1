# Our overall goal here is simply to examine how household 
# energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all 
# of which were constructed using the base plotting system.

#read in dataset
library(data.table)
powerdata <- fread("household_power_consumption.txt")

#convert date to date format
library(lubridate)
powerdata$Date_Rdate <- dmy(powerdata$Date)
powerdata$Date_Rdatetime <- dmy_hms(paste(powerdata$Date,powerdata$Time))

#filter for dates of interest
library(dplyr)
powerdataFeb_1_2 <- powerdata %>%
  filter(Date_Rdate>="2007-02-01" & Date_Rdate<="2007-02-02")

#inspect data and modify as necessary  
str(powerdataFeb_1_2)
powerdataFeb_1_2$Global_active_power <- as.numeric(powerdataFeb_1_2$Global_active_power)
powerdataFeb_1_2$Global_reactive_power <- as.numeric(powerdataFeb_1_2$Global_reactive_power)
powerdataFeb_1_2$Voltage <- as.numeric(powerdataFeb_1_2$Voltage)
powerdataFeb_1_2$Sub_metering_1 <- as.numeric(powerdataFeb_1_2$Sub_metering_1)
powerdataFeb_1_2$Sub_metering_2 <- as.numeric(powerdataFeb_1_2$Sub_metering_2)
powerdataFeb_1_2$Sub_metering_3 <- as.numeric(powerdataFeb_1_2$Sub_metering_3)

#open png file
png(filename="plot4.png",
    width=480,
    height=480)

par(mfcol=c(2,2))

#create plot 2 with base R
plot(x=powerdataFeb_1_2$Date_Rdatetime,
     y=powerdataFeb_1_2$Global_active_power,
     type="l",
     ylab="Global Active Power",
     xlab="")

#create plot 3 with base R
plot(x=powerdataFeb_1_2$Date_Rdatetime,
     y=powerdataFeb_1_2$Sub_metering_1,
     type="l",
     col="black",
     ylab="Energy sub metering",
     xlab="")
lines(x=powerdataFeb_1_2$Date_Rdatetime,
      y=powerdataFeb_1_2$Sub_metering_2,
      type="l",
      col="red")
lines(x=powerdataFeb_1_2$Date_Rdatetime,
      y=powerdataFeb_1_2$Sub_metering_3,
      type="l",
      col="blue")
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       cex=0.7)

plot(x=powerdataFeb_1_2$Date_Rdatetime,
     y=powerdataFeb_1_2$Voltage,
     type="l",
     ylab="Voltage",
     xlab="datetime")

plot(x=powerdataFeb_1_2$Date_Rdatetime,
     y=powerdataFeb_1_2$Global_reactive_power,
     type="l",
     ylab="Global reactive Power",
     xlab="datetime")

#close png file
dev.off()