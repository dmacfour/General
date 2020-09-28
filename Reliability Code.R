library(readxl)
library(dplyr)
library(xlsx)

state <- c("Colorado","Kansas","Nebraska","Wyoming","Missouri","South Dakota","North Dakota")

df <- data.frame()

for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/CE6.6.1 Data Entry by state - District Names Included.xlsx", 
             sheet = states,col_types = c("text", 
                                          "text", "date", "numeric", "text", 
                                          "text", "text", "text", "text", "text", 
                                          "text", "text", "text", "text", "text", 
                                          "text", "text", "text", "text", "text", 
                                          "text", "text", "text", "text", "text", 
                                          "text", "text", "text", "text", "text"), 
             skip = 1))
}

#Two Week Date Ranges
date_range <- list(c("2020-09-24","2020-10-09"),
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

#Calculate reliability for each pair
for (name in dist_names) {
  rowtest <- df_dupes[df_dupes$District == name,5:NCOL(df_dupes)]
  if(NROW(rowtest) == 2){
    reliability <- c(reliability,sum(rowtest[1,] == rowtest[2,])/NCOL(rowtest))
  } else{
    reliability <- c(reliability,-1)
  }
  date <- c(date,max(df_dupes[df_dupes$District == name,]$`Date Coded`))
  date_org <- c(date_org,min(df_dupes[df_dupes$District == name,]$`Date Coded`))
}

results <- data.frame(dist_names,Original_code_date = as.Date(date_org, origin = "1970-01-01"), Duplicate_code_date = as.Date(date, origin = "1970-01-01"),reliability)

for (i in 1:length(date_range)) {  
  res <- results[results$Duplicate_code_date > date_range[[i]][1] & results$Duplicate_code_date <= date_range[[i]][2],]
  write.xlsx(res,
             file = "C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Reliability_Output.xlsx",
             append = TRUE, sheetName = paste(as.character(date_range[[i]][1])," - ",as.character(date_range[[i]][2])))
  
}
