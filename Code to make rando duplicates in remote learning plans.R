set.seed(48484222)
library(readxl)
library(xlsx)
school_districts_broadband_v2_DM <- read_excel("C:/Users/DavidMcCullough/One Drive - Marzano Research - Current/Marzano Research/MZR - Documents/Share/10_REL/Task 6-Research/CE6.6_JiT/District Information/school_districts_broadband_v2_DM.xlsx")

df <- school_districts_broadband_v2_DM[school_districts_broadband_v2_DM$state %in% c("Wyoming","Colorado","South Dakota","North Dakota","Nebraska","Missouri","Kansas"),]

unique(df$state)

df_subset <- subset(df,select = c("name","state","urban_centric_locale"))

rows_dup <- sample(1:NROW(df_subset), size = round(NROW(df_subset)*.1))

df_w_dups <- rbind(df_subset,df_subset[rows_dup,])

random_order <- sample(NROW(df_w_dups))

df_shuffle <- df_w_dups[random_order,]

write.xlsx(df_shuffle,file = "Dist_list_w_duplicates.xlsx")
plot(x = )
