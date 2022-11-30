

getwd()

#fin <- read.csv("Future 500.csv", stringsAsFactors = T)

fin <- read.csv("Future 500.csv",  stringsAsFactors = T, na.strings = c("")) #Replace empty strings with NA

head(fin)
tail(fin, 10)
str(fin)
summary(fin)


#Changing from non factor to factor
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)


#Factor variable Trap (FVT)

#Conver character to numeric
a <- c("12", "13", "14", "12", "12")
typeof(a) #Because of the quotations, it saved as a character
b <- as.numeric(a) #We try to convert it back to numeric
typeof(b) #We see that we successfully converted it to a double.
#Converting numerics into factors
z <- factor(c("12", "13", "14", "12", "12")) #Change our characters into factors.
z #It created factors 12, 13, 14 but remember that R reads them as category 1, 2, 3
typeof(z) #stored as an integer
y <- as.numeric(z) #change it back to numeric
y #Here we see that it converted the placement of the factor into the number, instead of the original numbers themselves. This is the trap.
typeof(y) #reading as a double

#The correct way to convert z to a double from a factor is to convert to a character first and then a double.
x <- as.numeric(as.character(z)) #From factor to Character to Numeric
typeof(x)


#FTV Example_____________________________________________________

head(fin)
str(fin)

fin$Profit <- factor(fin$Profit) #Change profit to factor, so we can emulate the error.
str(fin)

fin$Profit <- as.integer(as.character(fin$Profit)) #Change it from factor to character to integer
str(fin) #See that it is back to the way it was

# sub() and gsub() - Sub replaces first instance, gsub replaces all instances. Also changes to character.
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)
head(fin)
str(fin) #Now that we removed the " Dollars" and "," it reads as a character.

fin$Revenue <- gsub("\\$", "", fin$Revenue) #Double backslash is an escape function that treats special variables in r as what you see.
fin$Revenue <- gsub(",", "", fin$Revenue) 
head(fin)
str(fin)

fin$Growth <- gsub("%", "", fin$Growth)
head(fin)
str(fin)

#lets change everything from characters to numeric

fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)
str(fin)
summary(fin)

#________________________________________
#Missing values: you can use the following steps to figure out what you need to do to fill them in:
#Can you calculate it on your own?
#Can you fill it in with 100% certainty?
#Can you research what the values are?
#Can you keep it empty?
#Should you remove the entire row?
#Proxy with a median value of similar quantities?
#


#Talk about NA
?NA

TRUE #1
FALSE #2
NA

TRUE == FALSE #False
TRUE == 5 #False
TRUE == 1 #True
FALSE == FALSE #false
FALSE == 0 #true
FALSE = 4 #false

NA == TRUE #NA
NA == FALSE #NA
NA == 0 #NA
NA == NA #NA

#Locating misisng data

#updated import to: fin <- read.csv("Future 500.csv",  stringsAsFactors = T, na.strings = c(""))

head(fin, 24)
complete.cases(fin) #Shows false for rows marked with an NA
fin[!complete.cases(fin),] #Only shows 6 rows with NA where is the rest? Look for empty characters.

# Some parts of the factor vector read <NA> as to not confuse with other abreviations.

#Filter: Using which() for non-missing data.

head(fin)

fin[fin$Revenue == 9746272,]
which(fin$Revenue == 9746272) #Which pulls up the row that is true for that #
fin[which(fin$Revenue == 9746272),] #Pulls up the row that is equivalent to that revenue

fin[fin$Employees == 45,] #Gives the employees equal to 45 and the NAs
fin[which(fin$Employees == 45),] #Gives the employees equal to 45 WITHOUT the NAs

#filtering: using is.not() for missing data.

fin$Expenses == NA #Just gives a bunch of NAs
fin[fin$Expenses == NA, ] #Just gives bunch of NAs

is.not()

a <- c(1, 24, 543, NA, 76, 45, NA)
is.na(a)

is.na(fin$Expenses)
fin[is.na(fin$Expenses), ]


#Removing records with missing data

fin_backup <- fin

fin[!complete.cases(fin),]
fin[!is.na(fin$Industry),]

fin <- fin[!is.na(fin$Industry),] #Remove rows missing the industry
head(fin, 24)

#Resetting the dataframe index

rownames(fin) <- 1:nrow(fin)
fin

#Another fast way to reset the dataframe is to use:
#rownames(fin) <- NULL

#Replacing Missing Data: Factual Analysis

fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City=="New York",]
fin[is.na(fin$State) & fin$City=="New York", "State"]
fin[is.na(fin$State) & fin$City=="New York", "State"] <- "NY"
#Check
fin[c(11,377),]

fin[!complete.cases(fin),] #Check to see that the subset is getting smaller

#Practice changing san Francisco to CA for state
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "San Francisco", ]
fin[is.na(fin$State) & fin$City == "San Francisco", "State" ]
fin[is.na(fin$State) & fin$City == "San Francisco", "State" ] <- "CA"
fin[c(82,265),]

fin[!complete.cases(fin),]

#reaplce some columns with the median
med_empl_retail <- median(fin[fin$Industry == "Retail", "Employees"], na.rm=TRUE) #Takes All rows that have retail in the industry, and then takes the column of employees. Also ingores NA
mean(fin[fin$Industry == "Retail", "Employees"], na.rm=TRUE)

fin[is.na(fin$Employees) & fin$Industry=="Retail",]

fin_backup2 <- fin

fin[is.na(fin$Employees) & fin$Industry=="Retail","Employees"] <- med_empl_retail #Change the employee column for retail employees that have na to med_empl_retail

fin[3,] #Check that it is replaced with the median employee retail

median(fin[fin$Industry == "Financial Services", "Employees"], na.rm=TRUE)
med_empl_finserv <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm=TRUE)


fin[is.na(fin$Employees) & fin$Industry=="Financial Services","Employees"] <- med_empl_finserv
fin[330,] #check that the median is replaced

#Replacing missing Data: Median

fin[!complete.cases(fin),]
fin[8,]

med_growth_constr <- median(fin[fin$Industry == "Construction", "Growth"], na.rm=TRUE)
med_growth_constr
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_constr
fin[8,]
fin[!complete.cases(fin),]

#try on my own to replace revenue and expenses uses the medians for row 8

med_rev_constr <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm=TRUE)
med_rev_constr
fin[is.na(fin$Revenue) & fin$Industry == "Construction",]
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_rev_constr
fin[8,42,]
fin[c(8, 42),]

med_exp_constr <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm=TRUE)
median(fin[fin$Industry == "Construction", "Expenses"], na.rm=TRUE)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry == "Construction", "Expenses"] <- med_exp_constr
fin[c(8,42),]

#Replacing Missing Data: deriving values
#Revenue - Expenses = Profit
#Revenue - Profit = Expenses
fin[c(8,42),]
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit), "Expenses"] #Replaces Profit with Revenue - Expenses

fin[15,]
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]
fin[!complete.cases(fin),]

#Visualization
library(ggplot2)
#A scatter plot classified by industry showing x = revenue, y = expenses, size profit, and col = industry
p <- ggplot(data=fin)
p
p + geom_point(aes(x = Revenue, y = Expenses, col = Industry, size = Profit))
#A scatter plot that includes industry trends for the expenses
d <- ggplot(data=fin, aes(x = Revenue, y = Expenses, col = Industry))
d + geom_point() +
  geom_smooth(fill=NA, size = 1.2)
#box plot
f <- ggplot(data = fin, aes(x = Industry, y = Growth, col = Industry))
f + geom_boxplot(size = 1)

#Extra
f + geom_jitter() +
  geom_boxplot(size = 1, alpha = 0.5, outlier.color = NA)
