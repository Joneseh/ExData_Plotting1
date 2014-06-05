
# Load the data
alldata <- read.csv("data/household_power_consumption.txt",header=TRUE, sep=";")

filter = c("1/2/2007","2/2/2007")

# create df as a subset where dates are in the variable filter
df <- alldata[alldata$Date %in% filter,]

# Convert Date to data
df$Date <- as.Date(df$Date,format="%d/%m/%Y")

# Convert Global Active Power to numeric
df$Global_active_power<- as.numeric(as.character(df$Global_active_power))

# Set up png file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# run plot
hist(df$Global_active_power, col="red", breaks=13, main="Global Active Power", xlab="Global Active Power (kilowatts)")

# close png
dev.off()
