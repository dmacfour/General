#Basics
##the two most fundametal classes of data R works with are "numeric" and "character"
100
"Orange"

##Other values: NA, NaN, and NULL 
NA
NaN
NULL

##Functions


##Packages

#Assigning a Variable
##Individual pieces of data and more complex objects can be given a name and stored
##This is called "assigning a variable", and is similar to saving a file to your computer
x <- 3
y <- "apple"

##Numeric variables can be manipulated using mathematical operations
x + 1
x * x

##The result of an operation can be stored place of the original value, or as a new variable
x <- x * 2
z <- x^3

##Mathematical operations don't work with character variables
y * 2

#Logical operators can be used to produce TRUE and FALSE statements (this is called conditional logic)
##The following logical operators are build in to R:
##Geater than, Geater than or equal to, less than, less than or equal to, equal to, not equal to 
x > 9
x < 9
x >= 6
x <= 9
x == 6
x != 10

##These are a little tricky with character variables
y == "apple"
y != "apple"
y >= "apple"
y > "car"

##Many tests come from built in functions starting with "is."
is.numeric(x)
is.numeric(y)
is.character(x)
is.character(y)

##AND (&) and OR (|) can be used to create more complex TRUE/FALSE statements
##AND statements are only TRUE if all conditions are met, OR is TRUE if at least one condition is

###"x is greater than two AND less than 12"
x > 2 & x < 12

###"x is greater than two OR less than 12"
x < 2 | x > 12

###"x is greater than two AND y is equal to car"
x > 2 & y == "car"

###"x is greater than two OR y is equal to car"
x > 2 | y == "car"

#Vectors
##Vectors are collections of datapoints of the same type (Numeric OR Character)
a <- c("bob","bob","bob","Sue","Kelly")
b <- c(1,4,2,9,1)
c <- c(5,9,20,2,10)
d <- c(NA,2,2,NA,1)

##Vectors of both types can be treated as categorical data
as.factor(a)
as.factor(d)

##You can do numerical and logical operations on vectors, just like individuals data points
##The same operation is carried out on each element of the vector
b * 2
a > 2
c == "a"
is.na(d)

b > 2 & b < 12
b > 2 & a == "b"

#Functions
##These are similar Excel macros - they're prepackaged (and often complex) numerical operations
##Routine calculations like means, medians, and sums are built in R functions
mean(x = c(1,6,2,0,-1,7,NA), na.rm = TRUE)

##Other functions can be used to transform data:
toupper(c("a","b","snack"))

round(1.6)

#Packages
##Packages are third party collections of functions that can be added to R

##Code for installing a package:
install.packages("packagename")

##Packages need to be "loaded" each time R is ran:
library(packagename)

#Data Frames
##Data frames are collections of vectors. They can be constructed, but are usually just imported

df <- data.frame(a,b,c,d)

##Data frames can ve viewed in the console or a new window
df
View(df)

##Vectors saved in dataframes can retrieved
df$b

##They can be manipulated and either saved on their own, replace the previous values, or saved as a new column
vec1 <- df$a
df$e <- df$b * 2
df$b <- df$b - 1

#Reshaping a dataframe
v1 <- runif(n = 10)
v2 <- runif(n = 10)
v3 <- runif(n = 10)

df2 <- data.frame(v1,v2,v3)

df2_long <- reshape2::melt(df2, measure.vars = c("v1","v2","v3"), variable.name = "Variable", value.name = "value")
#Recoding data
df2_long$value

##This function works just like the =IF() function in Excel
df2_long$recode <- ifelse(df2_long$value > 0.5, 1, 0)

#Imnporting Data
##Can use Import button to the right
##Built in function to import csv's:
df3 <- read.csv("~/Default/follow_up.csv")

##Function from readxl package to import xlsx files:
library(readxl)
df3 <- read_excel(NULL)

#Selecting Data

##Use Subset in conjunction with logical statements to select rows
##Select is optional


new_df <- subset(JPP_Data_Export_2019_12_16, subset = Enrollment_ID < 300, select = c(Enrollment_ID, DOB))

#Transforming Data Frames