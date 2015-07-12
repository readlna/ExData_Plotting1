data<-read.table("household_power_consumption.txt", 
                 header = TRUE, 
                 sep = ";", 
                 comment.char="", 
                 colClasses=c(Date="character",
                              Time="character",
                              Global_active_power="numeric",
                              Global_reactive_power="numeric",
                              Voltage="numeric",
                              Global_intensity="numeric",
                              Sub_metering_1="numeric",
                              Sub_metering_2="numeric",
                              Sub_metering_3="numeric"),
                 na.strings = "?")

#sample
d<-data[data$Date=="1/2/2007" | data$Date =="2/2/2007",]
d$DateTime <- paste(d$Date, d$Time)
d$DateTime<-strptime(d$DateTime, "%e/%m/%Y %H:%M:%S")

d$Weekday=weekdays(d$DateTime, abbreviate = TRUE)
d_pl2=d[d$Weekday=="Thu"|d$Weekday=="Fri"|d$Weekday=="Sat",]

#plot
par(mfrow=c(1,1))
plot(d_pl2$DateTime, d_pl2$Global_active_power, 
     type = "l", 
     ylab="Global Active Power (kilowatts)",
     xlab = "")

#export
dev.copy(png, "plot2.png")
dev.off()
