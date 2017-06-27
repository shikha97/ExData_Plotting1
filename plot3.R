###Plot-3

##Download the file 
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

download.file(fileURL, filename, method="curl")

## Unzip the file 
unzip(zipfile = "exdata_data_household_power_consumption.zip")

##Reading the table
##We need to specify the separator here - ";" and also na is "?"
powerData <-read.table("household_power_consumption.txt",
                       header = TRUE,
                       sep = ";",
                       na = "?")

##Subset the data, as the dates have to be in the first 2 days of february 
selectedData <- powerData[powerData[,"Date"] %in% c("1/2/2007","2/2/2007"),]

##The data was in factor format, converting it to date format
selectedData[,"Date"] <- as.Date(selectedData[,"Date"],"%d/%m/%Y")

##Creating the date - time variable to plot as the x-axis
dateTime <- strptime(paste(selectedData[,"Date"], 
                           selectedData[,"Time"],
                           sep = " "),
                     "%Y-%m-%d %H:%M:%S")


##Creating a png file as a graphic device
png(file = "plot3.png",width = 480, height = 480)

plot(x = dateTime,
     y = selectedData[,"Sub_metering_1"],
     col = "black",
     type = "l", 
     ylab = "Energy Sub Metering",
     xlab = " ")

points(y = selectedData[,"Sub_metering_2"],
       x =dateTime,
       col = "red",
       type = "l")

points(y = selectedData[,"Sub_metering_3"],
       x =dateTime,
       col = "blue",
       type = "l")

legend("topright",
       col = c("black","red","blue"),
       lty = 1,
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))
dev.off()