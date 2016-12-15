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


# plot 2:

x_range <- range(1, length(data_0102$Global_active_power))
y_range <- range(0, max(data_0102$Global_active_power))
png(filename = 'plot2.png', width = 480, height = 480)
plot(data_0102$Global_active_power,
     type = 'l', col = 'black',
     ylab = 'Global Active Power (kilowatts)',
     xlab = '',
     axes = FALSE,
     xlim = x_range,
     ylim = y_range)
box()
#axis(1, 1:3, lab=c("Thu","Fri", 'Sat'))
axis(1, at = 1440*0:2, lab=c("Thu","Fri", 'Sat'), xpd = TRUE )
axis(2, at=2*0:y_range[2])
dev.off()