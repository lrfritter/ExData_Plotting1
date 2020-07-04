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

#filter for dates of interest
library(dplyr)
powerdataFeb_1_2 <- powerdata %>%
  filter(Date_Rdate>="2007-02-01" & Date_Rdate<="2007-02-02")

#inspect data and modify as necessary  
str(powerdataFeb_1_2)
powerdataFeb_1_2$Global_active_power <- as.numeric(powerdataFeb_1_2$Global_active_power)

#open png file
png(filename="plot1.png",
    width=480,
    height=480)

#create plot 1 with base R
hist(x=powerdataFeb_1_2$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

#close png file
dev.off()