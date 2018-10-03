library(data.table)

setwd("~/R/ExData_Plotting1")
fname <- "powerconsumption.zip"

#checking if file exists otherwise download
if (!file.exists(fname)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, fname)
  unzip(zipfile = fname,exdir = ".") 
} 

# read only the data we are interested in
data <- fread("household_power_consumption.txt", header = T, sep = ";", skip = 66638, nrows = 2880, na.strings = "?")
names(data) = c("Date","Time","Global_active_power", "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# convert to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")
datetime <- paste(data$Date, data$Time)
data$DateTime = as.POSIXct(datetime)

# write png file
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data, { 
  plot(DateTime, Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power (kilowatts")
  plot(DateTime, Voltage, type = "l")
  plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(Sub_metering_2 ~ DateTime, col="red")
    lines(Sub_metering_3 ~ DateTime, col="blue")
  plot(DateTime, Global_reactive_power, type = "l")})
dev.off()