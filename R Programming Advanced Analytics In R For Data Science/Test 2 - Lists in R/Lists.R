getwd()
util <- read.csv("Machine-Utilization.csv")
util
head(util)
str(util)
str(util, stringsAsFactors = T)
util <- read.csv("Machine-Utilization.csv", stringsAsFactors = T)
head(util)
str(util, stringsAsFactors = T)
#Derive utilization column
util$utilization = 1 - util$Percent.Idle
head(util)
head(util,12)
tail(util) #see that its days - months - year
?POSIXct
as.POSIXct(util$Timestamp, format = "%d/%m/%Y %H:%M")
util$PosixTime <- as.POSIXct(util$Timestamp, format = "%d/%m/%Y %H:%M")
head(util,12)
summary(util)
util$Timestamp <- NULL
head(util,12)
util <- util[,c(4,1,2,3)]
head(util,12)
RL1 <- util[util$Machine == "RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)
summary(RL1)
RL1$Machine <- factor(RL1$Machine) #This refactors the data so that the other machines are removed
summary(RL1)
util_stats_rl1 <- c(min(RL1$utilization, na.rm=T),
                    mean(RL1$utilization, na.rm=T),
                    max(RL1$utilization, na.rm=T)
)
util_stats_rl1
RL1$utilization < 0.90
which(RL1$utilization < 0.90)
length(which(RL1$utilization < 0.90))
util_under_90 <- length(which(RL1$utilization < 0.90)) > 0
util_under_90
util_under_90_flag <- length(which(RL1$utilization < 0.90)) > 0
util_under_90_flag
list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1
names(list_rl1)
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
list_rl1
rm(list_rl1)
list_rl1 <- list(Machine = "RL1", Stats = util_stats_rl1, LowThreshold = util_under_90_flag)
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine #same as [[]]
list_rl1[2]
typeof(list_rl1[2])
typeof(list_rl1[[2]]) #gives a double
list_rl1$Stats
typeof(list_rl1$Stats)
#how would you access the 3rd element of the vector
list_rl1[[2]][3]
list_rl1$Stats[3]
list_rl1[4] <- "New Information"
list_rl1
#Another way to add information
RL1
RL1[is.na(RL1$utilization),]
RL1[is.na(RL1$utilization),"PosixTime"]
list_rl1$UnknownHoursRL1[is.na(RL1$utilization),"PosixTime"]
list_rl1$UnknownHours <- RL1[is.na(RL1$utilization),"PosixTime"]
#how would you access the 3rd element of the vector
list_rl1[[2]][3]
list_rl1$Stats[3]
#Add a new character in the list
list_rl1[4] <- "New Information"
list_rl1
#Add a new character in the list
list_rl1[6] <- "New Information"
list_rl1
list_rl1[6] <- NULL
#remove a component
list_rl1[4] <- NULL
#Another way to add information
list_rl1$UnknownHours <- RL1[is.na(RL1$utilization),"PosixTime"]
list_rl1
#noice numeration has shifted
list_rl1[4]
# Add another component
#dataframe: For this machine
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)
#Subsetting a list
list_rl1
list_rl1$UnknownHours[1]
list_rl1[[4]][1]
list_rl1[1:2]
list_rl1[c(1,4)]
list_rl1[c("Machine","Stats")]
subset_rl1 <- list_rl1[c("Machine","Stats")]
subset_rl1
subset_rl1[[2]][2]
subset_rl1$Stats[2]
#Double square brackets are NOT for subsetting:
list_rl1
list_rl1[1:2]
list_rl1[1:3]

#Building a timeseries plot
library(ggplot2)
p <- ggplot(data=util)

#save the plot to a variable
myplot <- p <- ggplot(data=util)
#add the plot to the list for rl1
list_rl1$Plot <- myplot
summary(list_rl1) #you can see the class is saved as gg
list_rl1

p + geom_line(aes(x=PosixTime, y = utilization, #utilization with respect to time
                  color = Machine), #color each machine a diff color
              size =1.2) + #sets the size of the line; make sure its out of aes
  facet_grid(Machine~.) + #separate plot into machines; what does ~. do?
  geom_hline(yintercept= 0.9, #adds a horizontal line at 0.9
             col = "Gray", size = 1.2, #color the hoizontal line gray and size 1.2
             linetype=3) #makes the line a dashed line
