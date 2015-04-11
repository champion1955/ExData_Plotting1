data <- fread("./household_power_consumption.txt", header=FALSE, sep=";", na.strings="?", skip=66637, nrows = 2880)
labels <- fread("./household_power_consumption.txt", header=FALSE, sep=";", nrows = 1)
setnames(data,as.character(labels))
data[,DateTime:=paste(data$Date,data$Time)]
setcolorder(data, c("DateTime","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3","Date","Time"))
data[,Date:=NULL]
data[,Time:=NULL]
data$DateTime <- as.POSIXct(strptime(data$DateTime, "%d/%m/%Y %H:%M:%S"))

library(datasets)
png(filename = "./plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
with(data, {
plot(data$DateTime, data$Global_active_power, type="n", ylab = "Global Active Power", xlab="")
lines(data$DateTime, data$Global_active_power)

plot(data$DateTime, data$Voltage, type="n", xlab = "datetime", ylab = "Voltage")
lines(data$DateTime, data$Voltage)

plot(data$DateTime, data$Sub_metering_1, type="n", ylab = "Energy sub metering", xlab="")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1)

plot(data$DateTime, data$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
lines(data$DateTime, data$Global_reactive_power)
})
dev.off()