library(data.table)
library(tidyr)

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file <- 'household_power_consumption.txt'

if(!file.exists(file)) {
    download.file(url, destfile = "data.zip")
    unzip("data.zip")
}

data <- read.table(file, header = T, sep = ';', na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- unite(data, dateTime, c("Date", "Time"), sep = " ")
data <- data[complete.cases(data),]
data$dateTime <- as.POSIXct(data$dateTime)

data$Global_active_power <- as.numeric(data$Global_active_power)


plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

with(data, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
