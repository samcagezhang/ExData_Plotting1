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

# plot 1
data_0102 <- mutate(data_0102, weekday = weekdays(data_0102$Date))

png(filename = 'plot1.png', width = 480, height = 480)
par(mfrow = c(1,1))
hist(data_0102$Global_active_power,
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency', col = 'red',
     main = 'Global Active Power')
dev.off()