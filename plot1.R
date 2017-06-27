###Plot -1


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

##Converting the "Global_active_power" to numeric form 
selectedData[,"Global_active_power"] <- as.numeric(selectedData[,"Global_active_power"])

##Opening the png graphic device, specifying width and height - 480
png(file = "plot1.png",width = 480 , height = 480 )

##Making a histogram by specifying the data which is "Global_active_power" and color,
##label of x-axis and title
hist(selectedData$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (killowatts)",
     main = "Global Active Power")

##Mandatory to switch off the graphic device
dev.off()
