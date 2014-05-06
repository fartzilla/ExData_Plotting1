# ======================================================
# Coursera. Exploratory Data Analysis
# Course Project 1
# ======================================================
# Project 1 - Plot 1

# Reading only rows with date 1/2/2007 and 2/2/2007
# This program does not use additional libraries
# and reads file row by row using readLines

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
  # You could comment next line if you'd like to test all rows
  if(grepl("^3\\/2\\/2007",oneLine)) break
} 
close(con)
df <- data.frame(matrix(unlist(results.list), nrow= length(results.list), byrow=T))
names(df)<-unlist(strsplit(header, split=";"))

for(i in 3:9) df[,i]<-as.numeric(as.character(df[,i]))
df$datetime<-strptime(paste(as.character(df$Date),as.character(df$Time)), "%d/%m/%Y %H:%M:%S")
### END read data

### Plot graph

png("plot1.png",width = 480, height = 480, units = "px",bg = "transparent")

hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()
