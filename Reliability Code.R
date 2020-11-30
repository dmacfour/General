library(readxl)
library(dplyr)
library(xlsx)

state <- c("Kansas","Nebraska","Wyoming ","North Dakota")

df <- data.frame()

for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/CE6.6.1 Data Entry_FINAL.xlsx", 
             sheet = states)[,1:26])
}

df_coded <- df[!is.na(df$`Date Coded`),]


#Filter out irrelevant plans

#Find Duplicates in coded plans
df_dupes <- df_coded[which(duplicated(df_coded[1]) | duplicated(df_coded[1],fromLast = TRUE)),]
if(NROW(df_dupes) == 0){
  next
}

df_dupes$`Date Coded` <- as.Date(df_dupes$`Date Coded`)
dist_names <- unique(df_dupes$District)


reliability <- c()
date <- c()
date_org <- c()
state_dupe <- c()
items <- data.frame()

#Calculate reliability for each pair
for (name in dist_names) {
  rowtest <- df_dupes[df_dupes$District == name,5:NCOL(df_dupes)]
  if(NROW(rowtest) == 2){
    reliability <- c(reliability,sum(rowtest[1,] == rowtest[2,])/NCOL(rowtest))
    items <- rbind(items,data.frame(District = name,State = unique(df_dupes[df_dupes$District == name,]$State),Date = max(df_dupes[df_dupes$District == name,]$`Date Coded`),rowtest[1,] == rowtest[2,]))
  } else{
    reliability <- c(reliability,-1)
  }
  date <- c(date,max(df_dupes[df_dupes$District == name,]$`Date Coded`))
  date_org <- c(date_org,min(df_dupes[df_dupes$District == name,]$`Date Coded`))
  state_dupe <- c(state_dupe,unique(df_dupes[df_dupes$District == name,]$State))
}

items[items == TRUE] <- 1
items[items == FALSE] <- 0

write.csv(x = items,file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/reliabilityround4.csv")
