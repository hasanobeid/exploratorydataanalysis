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

png(file = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "Red", main = "Global Active Power")
dev.off()
