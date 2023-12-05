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


##########################################plot3##########################################

#plotting and writing to a PNG file
png(filename = "Plot3.png" , width = 480 , height = 480)
plot(data$Date , data$Sub_metering_1 , type ="l" , xlab = "" , ylab = "Energy sub metering" , xaxt="n" )
lines(data$Date , data$Sub_metering_2 , col = "blue")
lines(data$Date , data$Sub_metering_3 , col = "red")
legend("topright" , legend = c("sub metering 1","sub metering 2","sub metering 3") , col = c("black" , "blue" , "red") , lty = 1)
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), labels = c("Thu", "Fri", "Sat"))
dev.off()
