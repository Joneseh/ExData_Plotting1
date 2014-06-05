# Load the data
alldata <- read.csv("data/household_power_consumption.txt",header=TRUE, sep=";")

filter = c("1/2/2007","2/2/2007")

# create df as a subset where dates are in the variable filter
df <- alldata[alldata$Date %in% filter,]

# Convert metering columns to number
df$Sub_metering_1<- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2<- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3<- as.numeric(as.character(df$Sub_metering_3))

# Add a new column DateTime based on values in Date and Time
df$DateTime <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

# Set up and create png plot with three lines
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

plot(df$DateTime,df$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(df$DateTime,df$Sub_metering_2, col="red")
lines(df$DateTime,df$Sub_metering_3, col="blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off()