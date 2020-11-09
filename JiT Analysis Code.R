library(readxl)
library(dplyr)
library(xlsx)

state <- c("Kansas","Nebraska","Wyoming ", "North Dakota")

df <- data.frame()

for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/CE6.6.1 Data Entry_FINAL.xlsx", 
             sheet = states)[,1:26])
}

df_coded <- df[!is.na(df$`Date Coded`),]


#Filter out irrelevant plans FIX THIS

#Find Duplicates in coded plans
df_dupes <- df_coded[which(duplicated(df_coded[1]) | duplicated(df_coded[1],fromLast = TRUE)),]
if(NROW(df_dupes) == 0){
  next
}

df_dupes$`Date Coded` <- as.Date(df_dupes$`Date Coded`)
dist_names <- unique(df_dupes$District)

#Caclulations
vars <- names(df)
vars[6]
df %>% group_by(State, get(vars[6])) %>% tally()
