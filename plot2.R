# ======================================================
# Coursera. Exploratory Data Analysis
# Course Project 1
# ======================================================
# Project 1 - Plot 2

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

png("plot2.png",width = 480, height = 480, units = "px") 

plot(df$datetime,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()

# restore default locale
Sys.setlocale("LC_TIME", "")