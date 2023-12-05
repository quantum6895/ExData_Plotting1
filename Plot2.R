##parsed the text file manually for only the Feb of 2007

##reading the text file into R , 
data <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt" , header = TRUE , sep = ";")

##Dealing with date and time variables

#first, Converting both into one "char" variable
for (i in 1:length(data[ , 1])) {
  data$Date[i] <- paste(data$Date[i] , data$Time[i])
}

#We don't need "Time" variable anymore
library(dplyr)
data <- select(.data = data , !Time)

#converting the "Date" variable into a POSIXlt variable
data$Date<-  as.POSIXlt(x = data$Date , tz = "" , format = "%d/%m/%Y %H:%M:%S")

#filtering the first two days of Feb 2007
data <- filter(.data = data , data$Date < as.POSIXlt(x = "2007-02-03 00:00:00"))

#converting the variables to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

##########################################plot2##########################################

#plotting and writing to a PNG file
png(filename = "Plot2.png" , width = 480 , height = 480)
plot(data$Date , data$Global_active_power , type ="l" , xlab = "" , ylab = "Global Active Power (kilowatts)")
dev.off()
