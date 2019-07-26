setwd("C:/Users/Owner/OneDrive/Coursera/Exploratory Data Analysis/project1/exdata_data_household_data_consumption")

data <- read.table("household_data_consumption.txt",skip=1,sep=";")
names(data) <- c("Date","Time","Global_active_data","Global_reactive_data","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
subdata$Time <- strptime(subdata$Time, format="%H:%M:%S")
subdata[1:1440,"Time"] <- format(subdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subdata[1441:2880,"Time"] <- format(subdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

par(mfrow=c(2,2))

png("plot4.png", width=480, height=480)

with(subdata,{
    plot(subdata$Time,as.numeric(as.character(subdata$Global_active_data)),type="l",  xlab="",ylab="Global Active Data")  
    plot(subdata$Time,as.numeric(as.character(subdata$Voltage)), type="l",xlab="datetime",ylab="Voltage")
    plot(subdata$Time,subdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(subdata,lines(Time,as.numeric(as.character(Sub_metering_1))))
    with(subdata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
    with(subdata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(subdata$Time,as.numeric(as.character(subdata$Global_reactive_data)),type="l",xlab="datetime",ylab="Global_reactive_data")
})

dev.off()
