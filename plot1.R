##data download, reading, cleaning and nodification steps---

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("exdata_data_household_power_consumption.zip")){
    download.file(url, destfile = "exdata_data_household_power_consumption.zip", mode = "wb")
}

if(!file.exists("household_power_consumption.txt")){
    unzip("exdata_data_household_power_consumption.zip")
}

data_file<-file("household_power_consumption.txt")

data<- read.table(text = grep("^Date|^[1-2]/2/2007", readLines(data_file),value=TRUE),header = TRUE,sep = ";", na.strings = "?")

data$DateTime <- paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)
data$DateTime<- as.POSIXct(data$DateTime)

#plot1

par(mfrow =c(1,1), mar =c(4,4,1,0), oma = c(0,0,0,0))
with(data, hist(Global_active_power,main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)", 
                ylab="Frequency", col = "red"))
dev.copy(png,"plot1.png", width=480, height=480); dev.off()
