library(readxl)
library(dplyr)
library(xlsx)

state <- c("Kansas","Nebraska","Wyoming ")

df <- data.frame()

for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/CE6.6.1 Data Entry_FINAL.xlsx", 
             sheet = states)[,1:26])
}

#Two Week Date Ranges
date_range <- list(c("2020-09-10","2020-10-07"),
     c("2020-10-09","2020-10-23"),
     c("2020-10-23","2020-11-06"),
     c("2020-11-06","2020-11-20"))
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

for (i in 1:length(date_range)) {  
  res <- items[items$Date > date_range[[i]][1] & items$Date <= date_range[[i]][2],]
  write.xlsx(res,
             file = "C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Reliability_Output.xlsx",
             append = TRUE, sheetName = paste(as.character(date_range[[i]][1])," - ",as.character(date_range[[i]][2])))
  
  by_item_reliability <- items %>% filter(Date > date_range[[i]][1] & Date <= date_range[[i]][2]) %>% summarise_if(is.logical,mean)
  write.xlsx(by_item_reliability,
             file = "C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Reliability_Output.xlsx",
             append = TRUE, sheetName = paste("Reliability",as.character(date_range[[i]][1])," - ",as.character(date_range[[i]][2])))
}
