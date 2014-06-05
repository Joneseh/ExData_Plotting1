# Load the data
alldata <- read.csv("data/household_power_consumption.txt",header=TRUE, sep=";")

filter = c("1/2/2007","2/2/2007")

# create df as a subset where dates are in the variable filter
df <- alldata[alldata$Date %in% filter,]

# Convert Global Active Power to numeric
df$Global_active_power<- as.numeric(as.character(df$Global_active_power))

# Convert metering columns to number
df$Sub_metering_1<- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2<- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3<- as.numeric(as.character(df$Sub_metering_3))

# Convert Voltage to number
df$Voltage<- as.numeric(as.character(df$Voltage))

# Convert Global_reactive_power to number
df$Global_reactive_power<- as.numeric(as.character(df$Global_reactive_power))

# Add a new column DateTime based on values in Date and Time
df$DateTime <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

# Set up png device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

par(mfrow=c(2,2))

# create the four plots, row wise   

plot(df$DateTime,df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(df$DateTime,df$Voltage, type="l", ylab="Voltage", xlab="datetime")


plot(df$DateTime,df$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(df$DateTime,df$Sub_metering_2, col="red")
lines(df$DateTime,df$Sub_metering_3, col="blue")
legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3", cex=.9))

plot(df$DateTime,df$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()