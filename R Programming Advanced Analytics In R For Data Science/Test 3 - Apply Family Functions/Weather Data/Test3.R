#1. A table showing the annual averages of each observed metric for every city
#2. A table showing by how much temperature fluctuates each month from min to
#max (in %). Take min temperature as the base
#3. A table showing the annual maximums of each observed metric for every city
#4. A table showing the annual minimums of each observed metric for every city
#5. A table showing in which months the annual maximums of each metric were
#observed in every city (Advanced)

getwd()
setwd("./Weather Data")
getwd()
Chicago <- read.csv("Chicago-F.csv", row.names=1) #rownames equals one sets the row names to the left most column of the data
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
Weather
Weather[3]
Weather[[3]]
Weather$Houston

#Converting to lists help us access the data better, because we can easily use Weather$Houston to access the Houston weather list

#example of apply
#apply(M, 1, mean) 
#M is the matrix
#1 is to select each row, a 2 would ean to apply it to the columns
#mean is to apply the function mean() to all the rows

# apply() lapply() and sapply() are most common
# apply is to apply a function
# lapply does the same thing but generates answers as a list
# sapply does the same thing as apply but generates answers as a vector

Chicago


#check:
mean(Chicago["DaysWithPrecip",])

#Analyze one city
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)

#for practice (cause it's not necessarily helpful, but lets practice the command)
apply(Chicago, 2, max)
#shows all of HoursOfSunshine because that is the max # of course. Not useful in our data

#Compare
apply(Chicago, 1, mean)
apply(Houston, 1, mean)
apply(NewYork, 1, mean)
apply(SanFrancisco, 1, mean)
                              #We can probably cbind these together to make a new dataframe, but there is a faster way

Chicago
#find the mean of every row
#method 1: assume we cant use apply - lets use loops
output <- NULL #Preparing an empty vector to loop the data into
for(i in 1:5){ #run cycle
 output[i] <- mean(Chicago[i,])
  }
output #we see that it iterated each row into an average
names(output) <- rownames(Chicago)
output

#Method #2: Use the apply function

apply(Chicago, 1, mean)
#same thing done in 1 line of code.

#Using lapply() Example 1
Chicago
t(Chicago) #transpose function that makes all the rows columns and all the columns rows.
Weather

lapply(Weather, t) #lappply will pick out every component (Chicago, Houston, etc...) and transpose each component
#new dataframe will be a big list

mynewlist <- lapply(Weather, t)

#Example 2
Chicago
rbind(Chicago, NewRow=1:12) #creates a new row with #s 1 to 12
lapply(Weather, rbind, NewRow=1:12) #Does this for all of Weather

#Example 3
rowMeans(Chicago) #identical to: apply(Chicago, 1, mean)
lapply(Weather, rowMeans) #applies the mean to all rows of every component of weather
#rowMeans
#colMeans
#rowSums
#colSums

#All of these are useful for applying quick functions and using lapply / apply in order to quickly create these values accross the entire dataframe
#QUESTION: HOw come I can't use apply(Weather, 1, mean) to do the same thing?
#The apply functions works well with one component of the list Weather, for example Chicago, but when I want to apply it across multiple components in Weather, then you need to use lapply


#combining lapply with the [ ] operator
Weather
Weather[[1]][1,1]
Weather$Chicago[1,1]
#same as
Weather[[1]][1]
Weather[[1]][1]

lapply(Weather, "[", 1, 1) #The [[1]] Represents the component Chicago in our Weather Matrix
#So if we want to iterate over every component using lapply(Weather,...) then the [[]] brackets are implied

lapply(Weather, "[", 1,)
#Extracts the entire first row of every matrix and puts it in its own list

lapply(Weather, "[", ,3) #gives all the 3rd columns of each component

#Adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])
lapply(Weather, function(z) z[1,] - z[2,]) #difference of degrees F for average high and average low
lapply(Weather, function(z) round((z[1,] - z[2,])/z[2,], 2)) #The difference of high and low divided by the low rounded to 2 decimal places
    #This is what we were after <<Deliv2: temp fluctuations. Will improve later

lapply(Weather, function(y) round(y[3,]/y[4,], 2)) #practice

#Using sapply()
Weather
#AvrgHigh_F for July
lapply(Weather, "[", 1, 7) #returns a list
sapply(Weather, "[", 1, 7) #returns a vector or matrix (Checks to see if it can return one of those)
#AvgHigh_F fpr 4th quarter
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12) #returns a matrix
#another example
lapply(Weather, rowMeans)
round(sapply(Weather, rowMeans), 2) #returns matrix
#another example
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
#This is the correct table that we were after

#By the way
sapply(Weather, rowMeans, simplify=FALSE) #same as lapply


#Nesting apply( ) functions
Weather
lapply(Weather, rowMeans)

Chicago
apply(Chicago, 1, max)
#apply across whole list
lapply(Weather, apply, 1, max) #max for every row of the components of weather
lapply(Weather, function(x) apply(x, 1, max)) #another way to do it
#tidy up
sapply(Weather, apply, 1, max) #<< deliverable 3
sapply(Weather, apply, 1, min) #<< deliverable 4

#Very advanced tutorial
#which.max

?which.max
Chicago
Chicago[1,] #pull row one of chicago
which.max(Chicago[1,]) #pull the max of row 1 of chicago
names(which.max(Chicago[1,])) #pull the name of the max of row 1 of chicago
#by the sounds of it:
#we will have apply() to iterate over the rows of the matrix
#and we will have lapply or sapply to iterate over components of the list
apply(Chicago,1, function(x) names(which.max(x))) #apply across chicago, in the rows, a function that gives us the names of the row of chicago
lapply(Weather, function(y) apply(y,1, function(x) names(which.max(x)))) #do all the previous but instead iterate it over our components in Weather (y) instead of chicago
sapply(Weather, function(y) apply(y,1, function(x) names(which.max(x))))
