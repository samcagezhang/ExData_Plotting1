### unzip the data to work directionary
setwd('E:\\Coursera\\Data Science (JHU)\\Exploratory Data Analysis')
dir()

library(data.table);library(lubridate); library(dplyr)

### Loading data
house <- read.table('./household_power_consumption/household_power_consumption.txt', sep = ';', header = TRUE, stringsAsFactors = FALSE)
house$Date <- dmy(house$Date)
house$Time <- hms(house$Time)
house$Global_active_power <- as.numeric(house$Global_active_power)
View(house)
str(house)

data_0102 <- filter(house, Date == '2007-02-01' | Date == '2007-02-02')
View(data_0102)
str(data_0102)
rm(house)


# plot 4
par(mfrow = c(2, 2))
# 1
y_range <- range(0, max(data_0102$Global_active_power))

png(filename = 'plot4.png', width = 480, height = 480)
plot(data_0102$Global_active_power,
     type = 'l', col = 'black',
     ylab = 'Global Active Power (kilowatts)',
     xlab = '',
     axes = FALSE,
     ylim = y_range)
box()

axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE )
axis(2, at=2*0:y_range[2], ylab = 'Global Active Power' )

# 2
data_0102$Voltage <- as.numeric(data_0102$Voltage)
y_range <- range(min(data_0102$Voltage), max(data_0102$Voltage))

plot(data_0102$Voltage,
     type = 'l', col = 'black',
     ylab = 'Voltage',
     xlab = 'datetime',
     axes = FALSE,
     ylim = y_range)
box()

axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE )
axis(2, at=4*0:y_range[2], ylab = 'Global Active Power' )

# 3
data_0102$Sub_metering_1 <- as.numeric(data_0102$Sub_metering_1)
data_0102$Sub_metering_2 <- as.numeric(data_0102$Sub_metering_2)
y_range <- range(0, max(data_0102$Sub_metering_1,
                        data_0102$Sub_metering_2,
                        data_0102$Sub_metering_3))

plot(data_0102$Sub_metering_1,
     type = 'l', col = 'black',
     ylab = 'Energy sub metering',
     xlab = '',
     axes = FALSE,
     ylim = y_range)
box()
lines(data_0102$Sub_metering_2, col = 'red')
lines(data_0102$Sub_metering_3, col = 'blue')
axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE)
axis(2, at = 10*0:y_range[2])
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       pch = '-',
       col = c('black', 'red', 'blue'),
       text.col = 'black',
       bty = 'n')

# 4

data_0102$Global_reactive_power <- as.numeric(data_0102$Global_reactive_power)
y_range <- range(min(data_0102$Global_reactive_power), max(data_0102$Global_reactive_power))

plot(data_0102$Global_reactive_power,
     type = 'l', col = 'black',
     ylab = 'Global_reactive_power',
     xlab = 'datetime',
     axes = FALSE,
     ylim = y_range)
box()

axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE )
axis(2, at = seq(from = 0.0, to = y_range[2], by = 0.1))

dev.off()