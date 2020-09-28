library(readxl)
df <- read_excel("~/CE6.6.1 Mock Data Set to Share with States_DM.xlsx", 
                                                            skip = 1)
names <- c("DM","DY","Maddie","Doug")

amount <- c(100,100,100,100)

df_to_do <- df[is.na(df$`Coded By`),]

df_to_do <- df_to_do[1:sum(amount),]

df_to_do$assign <- sample(x = names, size = sum(amount), replace = TRUE)

df_to_do_duplicate <- df_to_do[df_to_do$...1 %in% sample(df_to_do$...1, size = 20),]




for (name in names) {
  tempdf_to_do[df_to_do$assign == name,]
  
}

xlsx::write.xlsx()