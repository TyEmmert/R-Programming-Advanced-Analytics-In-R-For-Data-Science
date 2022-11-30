getwd()
setwd(".\\Weather Data")
Chicago <- read.csv("Chicago-F.csv", row.names=1)
Chicago
NewYork <- read.csv("NewYork-F.csv", row.names=1)
Houston <- read.csv("Houston-F.csv", row.names=1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names=1)
NewYork
Houston
SanFrancisco
#These are data frames:
is.data.frame(Chicago)
#Says it is a dataframe, we are going to convert to matrix
Chicago <- as.matrix(Chicago)
Chicago
is.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)
#Lets put all these into a list
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco= SanFrancisco)
weather
Weather
Weather[3]
Weather[[3]]
Weather$Houston
Chicago
apply(Chicago, 1, mean)
#check:
mean(Chicago["DaysWithPrecip"])
#check:
mean(Chicago["DaysWithPrecip",])
#Analyze one city
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)
#for practice (cause it's not necessarily helpful, but lets practice the command)
apply(Chicago, 2, max)
#Compare
apply(Chicago, 1, mean)
apply(SanFrancisco, 1, mean)
#Compare
apply(Chicago, 1, mean)
apply(Houston, 1, mean)
apply(NewYork, 1, mean)
apply(SanFrancisco, 1, mean)
Chicago
for(i in 1:5){ #run cycle
output[i] <- mean(Chicago[i,])
}
#find the mean of every row
#method 1: assume we cant use apply - lets use loops
output <- NULL #Preparing an empty vector to loop the data into
for(i in 1:5){ #run cycle
output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
Chicago
output
apply(Chicago, 1, mean)
#Using lapply()
Chicago
t(Chicago) #transpose function that makes all the rows columns and all the columns rows.
Weather
lapply(Weather, t) #lappply will pick out every component (Chicago, Houston, etc...) and transpose each component
mynewlist <- lapply(Weather, t)
#Example 2
Chicago
rbind(Chicago, NewRow=1:12)
lapply(Weather, rbind, NewRow=1:12)
rbind(Chicago, NewRow=1:12)
#Example 3
rowMeans(Chicago) #identical to: apply(Chicago, 1, mean)
lapply(Weather, rowMeans) #applies the mean to all rows of every component of weather
apply(Weather, rowMeans) #applies the mean to all rows of every component of weather
lapply(Weather, rowMeans) #applies the mean to all rows of every component of weather
apply(Weather, 1, rowMeans)
#All of these are useful for applying quick functions and using lapply / apply in order to quickly create these values accross the entire dataframe
#QUESTION: HOw come I can't use apply(Weather, 1, mean) to do the same thing?
apply(Weather, 1, mean)
#combining lapply with the [ ] operator
Weather
Weather[[1]]
Weather$Chicago[1,1]
#same as
Weather[[1]][1]
#same as
Weather[[1]][1,1]
Weather[[1]][1]
Weather[[1]]
Weather[[1]][1,]
Weather[[1]][,1]
lapply(Weather, "[", 1, 1) #The [[1]] Represents the component Chicago in our Weather Matrix
Chicago#So if we want to iterate over every component using lapply(Weather,...) then the [[]] brackets are implied
lapply(Weather, "[", 1,)
lapply(Weather, "[", ,3) #gives all the columns of each component
#Adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])
lapply(Weather, function(z) z[1,])
lapply(Weather, function(z) z[1,] - z[2,])
lapply(Weather, function(z) round(z[1,] - z[2,] / z[2,],2))
lapply(Weather, function(z) (z[1,] - z[2,])/z[2,])
lapply(Weather, function(z) round((z[1,] - z[2,])/z[2,], 2))
lapply(Weather, function(y) y[3,]/y[4,])
lapply(Weather, function(y) round(y[3,]/y[4,], 2))
#Using sapply()
Weather
#AvrgHigh_F for July
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)
#AvgHigh_F fpr 4th quarter
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)
#another example
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans))
round(sapply(Weather, rowMeans), 2)
#another example
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
#By the way
sapply(Weather, rowMeans, simplify=FALSE)
#Nesting apply( ) functions
Weather
lapply(Weather, rowMeans)
Chicago
max(Chicago$AvgHigh_F)
apply(Chicago, 1, max)
#apply across whole list
lapply(Weather, apply, 1, max)
lapply(Weather, function(x) apply(x, 1, max))
#tidy up
sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min) #<< deliverable 4
?which.max
Chicago
Chicago[1,]
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
#by the sounds of it:
#we will have apply() to iterate over the rows of the matrix
#and we will have lapply or sapply to iterate over components of the list
apply(Chicago,1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y,1, function(x) names(which.max(x))))
Weather
sapply(Weather, function(y) apply(y,1, function(x) names(which.max(x))))