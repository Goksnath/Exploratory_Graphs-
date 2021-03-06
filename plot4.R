rm(list=ls())

#downloading data from source and reading into database
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "power_con.zip")
unzip("power_con.zip")
power_con <- read.table("household_power_consumption.txt",sep = ";",stringsAsFactors = FALSE,header = TRUE,colClasses =c("character","character",rep("numeric",7)),na.strings ="?" )

#Converting character datatype to Date format
power_con$Date<- strptime(power_con$Date,"%d/%m/%Y")

#Subsetting data particular to time duration between 2007-02-01 and 2007-02-02
subset_powerData <- subset(power_con,Date>= "2007-02-01" & Date<= "2007-02-02")

#Converting character datatype to Date format
date_time <- strptime(paste0(subset_powerData$Date,subset_powerData$Time,sep=" "),"%Y-%m-%d %H:%M:%S")

#Plotting on a png graphic device with width x height=( 480 x 480) pixel
png(filename = "plot4.png",width = 480,height = 480)
par(mfrow=c(2,2),mar=c(2,4.5,2,4.5))
plot(date_time,subset_powerData$Global_active_power,ylab="Global Active Power",type = "l")
plot(date_time,subset_powerData$Voltage,ylab = "Voltage",type="l")
plot(date_time,subset_powerData$Sub_metering_1,ylab="Energy sub metering",type = "l")
lines(date_time,subset_powerData$Sub_metering_2,col="red")
lines(date_time,subset_powerData$Sub_metering_3,col="blue")
legend("topright",col = c("black","red","blue"),legend = colnames(subset_powerData[7:9]),lty=c(1,1,1),cex = 0.7)    
plot(date_time,subset_powerData$Global_reactive_power,ylab = colnames(subset_powerData[4]),type = "l",lwd=1)
dev.off()