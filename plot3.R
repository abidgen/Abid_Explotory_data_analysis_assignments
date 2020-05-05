##data download, reading, cleaning and nodification steps---

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("exdata_data_household_power_consumption.zip")){
    download.file(url, destfile = "exdata_data_household_power_consumption.zip", mode = "wb")
}

if(!file.exists("household_power_consumption.txt")){
    unzip("exdata_data_household_power_consumption.zip")
}

data_file<-file("household_power_consumption.txt")

data<- read.table(text = grep("^Date|^[1-2]/2/2007", readLines(data_file), value=TRUE),header = TRUE, sep = ";", na.strings = "?")

data$DateTime <- paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)
data$DateTime<- as.POSIXct(data$DateTime)

#plot3
par(mfrow =c(1,1), mar =c(2,4,1,1), oma = c(0,0,0,0))
with(data, plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab=""))
with(data, lines(DateTime,Sub_metering_2, type = "l", col="red"))
with(data, lines(DateTime,Sub_metering_3, type = "l", col="blue"))
legend("topright", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd = c(1,1,1),lty = c(1,1,1))
dev.copy(png,"plot3.png", width=480, height=480); dev.off()