
#downloading data from source and reading into database
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "power_con.zip")
unzip("power_con.zip")
power_con <- read.table("household_power_consumption.txt",sep = ";",stringsAsFactors = FALSE,header = TRUE,colClasses =c("character","character",rep("numeric",7)),na.strings ="?" )

#Converting character datatype to Date format
power_con$Date<- strptime(power_con$Date,"%d/%m/%Y")

#Subsetting data particular to time duration between 2007-02-01 and 2007-02-02
subset_powerData <- subset(power_con,Date>= "2007-02-01" & Date<= "2007-02-02")

#Plotting on a png graphic device with width x height=( 480 x 480) pixel
png(filename = "plot1.png",width = 480,height = 480)
hist(subset_powerData$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()