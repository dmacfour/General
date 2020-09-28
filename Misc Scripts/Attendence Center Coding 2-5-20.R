library(readxl)
library(xlsx)
Copy_of_Marzano_14_15_Approved_Programs <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/Misc Output/Copy of Marzano 14-15 Approved Programs.xlsx", 
                                                      skip = 2)

Copy_of_Marzano_15_16_Approved_Programs <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/Misc Output/Copy of Marzano 15-16 Approved Programs.xlsx", 
                                                      skip = 2)

Copy_of_Marzano_16_17_Approved_Programs <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/Misc Output/Copy of Marzano 16-17 Approved Programs.xlsx")

Copy_of_Marzano_14_15_Approved_Programs$HS <- 0
Copy_of_Marzano_14_15_Approved_Programs[grep(x = Copy_of_Marzano_14_15_Approved_Programs$`Attendance Center`,pattern = " HS ",ignore.case = TRUE),]$HS <- 1

Copy_of_Marzano_15_16_Approved_Programs$HS <- 0
Copy_of_Marzano_15_16_Approved_Programs[grep(x = Copy_of_Marzano_15_16_Approved_Programs$`Attendance Center`,pattern = " HS ",ignore.case = TRUE),]$HS <- 1

Copy_of_Marzano_16_17_Approved_Programs$HS <- 0
Copy_of_Marzano_16_17_Approved_Programs[grep(x = Copy_of_Marzano_16_17_Approved_Programs$`Attendance Center Name`,pattern = " High School ",ignore.case = TRUE),]$HS <- 1

write.xlsx(x = Copy_of_Marzano_14_15_Approved_Programs,sheetName = "Output",file = "Copy_of_Marzano_14_15_Approved_Programs.xlsx",append = TRUE)

write.xlsx(x = Copy_of_Marzano_15_16_Approved_Programs,sheetName = "Output",file = "Copy_of_Marzano_15_16_Approved_Programs.xlsx",append = TRUE)

write.xlsx(x = Copy_of_Marzano_16_17_Approved_Programs,sheetName = "Output",file = "Copy_of_Marzano_16_17_Approved_Programs.xlsx",append = TRUE)
