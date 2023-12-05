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

##########################################plot4##########################################


##plotting and writing to a PNG file
png(filename = "Plot4.png" , width = 480 , height = 480)
par(mfrow = c(2,2))

#Topleft plot
plot(data$Date , data$Global_active_power , type ="l" , xlab = "" , ylab = "Global Active Power (kilowatts)")

#Topright plot
plot(data$Date , data$Voltage , xlab = "datetime" , ylab = "Voltage" , type ="l" )

#Bottomleft plot
plot(data$Date , data$Sub_metering_1 , type ="l" , xlab = "" , ylab = "Energy sub metering" )
points(data$Date , data$Sub_metering_2 , type ="l" , col = "blue")
points(data$Date , data$Sub_metering_3 , type ="l" , col = "red")
legend("topright" , legend = c("sub metering 1","sub metering 2","sub metering 3") , col = c("black" , "blue" , "red") , lty = 1 , cex =0.5)

#Bottomright plot
plot(data$Date , data$Global_reactive_power , type ="l" , xlab = "Datetime" , ylab = "Global Reactive Power (kilowatts)")

dev.off()
