
## Results of the first Course Project of the coursera course "Exploratory Data Analysis",
## offered by Johns Hopkins University.


## First step: Downloading and reading in the data in an appropriate format.

URL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## setwd("???")                                                                                 ## Set the working directory to your directory of choice.
download.file(URL, "household_power_consumption.zip")
unzip("household_power_consumption.zip")

labels <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
power <- read.table("household_power_consumption.txt", sep = ";", dec = ".", skip = 66637, nrows = 2880, col.names = labels)                                            ## We only read in the lines we are interested in. 01-feb 2015 starts at line 66637; 02-feb 2015 ends at line 69517, so nrows = 69517 - 66637 = 2880.  

library(lubridate)
Sys.setlocale("LC_ALL", "English")                      ## As my system is in Dutch, I change it to English to obtain dates (i.e. weekdays, months) in English.
date_time <- dmy_hms(paste(power$Date, power$Time))

power_new <- power[,c(3,4,5,6,7,8,9)]
power_new$Date_Time <- date_time                        ## Replace the first two character columns by a column containing the total date (in English).



## Creating plot 3.

png("plot3.png")
with(power_new, plot(Date_Time, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(power_new, points(Date_Time, Sub_metering_1, type = "l"))
with(power_new, points(Date_Time, Sub_metering_2, type = "l", col = "Red"))
with(power_new, points(Date_Time, Sub_metering_3, type = "l", col = "Blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()
