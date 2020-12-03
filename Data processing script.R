library(readxl)
library(dplyr)
library(xlsx)

state <- c("Kansas","Nebraska","Wyoming ","North Dakota")

df <- data.frame()

#Read in district poverty info
dist_info <- read_excel("C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/school_districts_broadband_v2.xlsx")

#Read in raw coding data
for (states in state){
  
  df <- rbind(df,read_excel("C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/CE6.6.1 Data Entry_FINAL.xlsx", 
                            sheet = states)[,1:29])
}

#Filter out uncoded plans
df_coded <- df[!is.na(df$`Date Coded`),]

#Match column names for dist info
names(dist_info)[4] <- "District"
names(dist_info)[46] <- "State"
names(dist_info)[51] <- names(df_coded)[27]
names(dist_info)[50] <- names(df_coded)[29]
names(dist_info)[43] <- names(df_coded)[28]

#Filter out irrelevant info columns
relevent_dist_info <- dist_info[,c(4,43,46,50,51)]

#Merge with coded dataset
df_merged <- merge(df_coded[,1:26],relevent_dist_info)

#Remove duplicate plans for reliability
df_dupes_removed <- df_merged[-which((duplicated(df_merged[1]) | duplicated(df_merged[1],fromLast = TRUE)) & df_merged[4] != "Team"),]

#Create dataframe for each state
df_KS <- df_dupes_removed[df_dupes_removed[2] == "Kansas",]
df_ND <- df_dupes_removed[df_dupes_removed[2] == "North Dakota",]
df_WY <- df_dupes_removed[df_dupes_removed[2] == "Wyoming",]
df_NE <- df_dupes_removed[df_dupes_removed[2] == "Nebraska",]

#Create output files
xlsx::write.xlsx(x = df_KS, file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/output/Kansas_data.xlsx")
xlsx::write.xlsx(x = df_ND, file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/output/North_Dakota_data.xlsx")
xlsx::write.xlsx(x = df_WY, file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/output/Wyoming_data.xlsx")
xlsx::write.xlsx(x = df_NE, file = "C:/Users/DavidMcCullough/Marzano Research/MZR - Share/10_REL/Task 6-Research/CE6.6_JiT/Data Entry/Analysis/output/Nebraska_data.xlsx")

#Descriptive Stats
Hmisc::describe(df_KS)


