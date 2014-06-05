# Load the data
alldata <- read.csv("data/household_power_consumption.txt",header=TRUE, sep=";")

filter = c("1/2/2007","2/2/2007")

# create df as a subset where dates are in the variable filter
df <- alldata[alldata$Date %in% filter,]

# Convert Global Active Power to numeric
df$Global_active_power<- as.numeric(as.character(df$Global_active_power))

# Add a new column DateTime based on values in Date and Time
df$DateTime <- strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

# Set up png
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# Plot Global Active Power against DateTime
plot(df$DateTime,df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()