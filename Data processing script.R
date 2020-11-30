library(readxl)
library(dplyr)

state <- c("Kansas","Nebraska","Wyoming ","North Dakota")

df <- data.frame()

for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/CE6.6.1 Data Entry_FINAL.xlsx", 
                            sheet = states)[,1:26])
}

df_coded <- df[!is.na(df$`Date Coded`),]

dfna <- matrix(as.numeric(is.na(df_coded[,5:26])),nrow = 817,ncol=22)
dists <- df_coded[rowSums(dfna) > 0,1:2] 
write.csv(dists,file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/District_with_NAs.csv")
