# ======================================================
# Coursera. Exploratory Data Analysis
# Course Project 1
# ======================================================
# Project 1 - Plot 3

# Reading only rows with date 1/2/2007 and 2/2/2007
# This program does not use additional libraries
# and read file row by row using readLines

### BEGIN read data
con  <- file("data/household_power_consumption.txt", open = "r")
header<-readLines(con, n = 1, warn = FALSE)
results.list <- list();
current.line <- 1
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
  if(grepl("^[12]\\/2\\/2007",oneLine)) {
    results.list[[current.line]] <- unlist(strsplit(oneLine, split=";"))
    current.line <- current.line + 1
  }
  # You could comment next line if you like to test all rows
  if(grepl("^3\\/2\\/2007",oneLine)) break
} 
close(con)
df <- data.frame(matrix(unlist(results.list), nrow= length(results.list), byrow=T))
names(df)<-unlist(strsplit(header, split=";"))

for(i in 3:9) df[,i]<-as.numeric(as.character(df[,i]))
df$datetime<-strptime(paste(as.character(df$Date),as.character(df$Time)), "%d/%m/%Y %H:%M:%S")
### END read data

# Let's set locale to English for correct time labels

Sys.setlocale("LC_TIME", "English")

### Plot graph

png("plot3.png",width = 480, height = 480, units = "px",bg = "transparent")

plot(df$datetime,df$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

# restore default locale
Sys.setlocale("LC_TIME", "")