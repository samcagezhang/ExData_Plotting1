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


# Plot3
data_0102$Sub_metering_1 <- as.numeric(data_0102$Sub_metering_1)
data_0102$Sub_metering_2 <- as.numeric(data_0102$Sub_metering_2)
y_range <- range(0, max(data_0102$Sub_metering_1,
                        data_0102$Sub_metering_2,
                        data_0102$Sub_metering_3))

png(filename = 'plot3.png', width = 480, height = 480)
plot(data_0102$Sub_metering_1,
     type = 'l', col = 'black',
     axes = FALSE,
     ann = FALSE,
     ylim = y_range)
box()
lines(data_0102$Sub_metering_2, col = 'red')
lines(data_0102$Sub_metering_3, col = 'blue')
axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE )
axis(2, at=10*0:y_range[2])
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       pch = '-',
       col = c('black', 'red', 'blue'),
       text.col = 'black')

dev.off()