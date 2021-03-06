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
par(mfrow=c(2,2))

plot(d_pl2$DateTime, d_pl2$Global_active_power, 
     type = "l", 
     ylab="Global Active Power",
     xlab = "")

plot(d_pl2$DateTime, d_pl2$Voltage, 
     type = "l", 
     ylab="Voltage",
     xlab = "datetime")

plot(d_pl2$DateTime, d_pl2$Sub_metering_1, 
     type = "l", 
     ylab="Energy sub metering",
     xlab = "")
lines(d_pl2$DateTime, d_pl2$Sub_metering_2, 
      col="red")
lines(d_pl2$DateTime, d_pl2$Sub_metering_3, 
      col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1),
       lwd=c(2,2,2),
       col=c("black","red","blue"),
       cex=0.5,
       pt.cex=1,
       box.lwd = 0,
       bty="n")

plot(d_pl2$DateTime, d_pl2$Global_reactive_power, 
     type = "l", 
     ylab="Global_reactive_power",
     xlab = "datetime")

dev.copy(png, "plot4.png")
dev.off()
