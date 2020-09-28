library(readxl)
library(stringr)
library(dplyr)

Fullresults <- list()

WEEAC_Equity_alignment <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/WEEAC/WEEAC Equity alignment.xlsx")

sub <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/WEEAC/Y4 Q1 Follow up.xlsx")[,c(53,78:83)]
sub$issue <- "None"

thing <- function(sub){
for (i in 1:NROW(WEEAC_Equity_alignment)) {
  index <- grep(WEEAC_Equity_alignment$`Project Title`[i],x = sub$`Link Name`)
  if (length(index) > 0) {
    sub[index,]$issue <- WEEAC_Equity_alignment$`Equity Issue`[i]
  } else{
    next
  }
  
}

pattern <- stringr::str_split(sub$issue, ", ")
sub <- sub[,-1]
sub$result <- 0

for (i in 1:NROW(sub)) {
  if(length(grep(paste(pattern[[i]],collapse="|"), x = sub[i,-8],ignore.case = TRUE)) > 0) sub$result[i] <- 1
}

return(sub$result)
}

temp <- cbind(sub[1],x = thing(sub), Survey = "Follow Up")

thing2 <- function(sub){
  for (i in 1:NROW(WEEAC_Equity_alignment)) {
    index <- grep(WEEAC_Equity_alignment$`Project Title`[i],x = sub$`Link Name`)
    if (length(index) > 0) {
      sub[index,]$issue <- WEEAC_Equity_alignment$`Equity Issue`[i]
    } else{
      next
    }
    
  }
  
  pattern <- stringr::str_split(sub$issue, ", ")
  sub <- sub[,-1]
  sub$result <- 0
  
  for (i in 1:NROW(sub)) {
    if(is.na(rowSums(sub[i,grep(paste(pattern[[i]],collapse="|"),names(sub),ignore.case = TRUE)],na.rm = TRUE))){
    sub$result[i] <- 0
  } else if(rowSums(sub[i,grep(paste(pattern[[i]],collapse="|"),names(sub),ignore.case = TRUE)],na.rm = TRUE) >= 1){
    sub$result[i] <- 1
  }
  }
  print(sub$result)
  return(sub$result)
}

sub <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/WEEAC/Y4 Q1 RAW Exit.xlsx")[,c(53,57:62)]
sub$issue <- "None"

temp <- rbind(temp,cbind(sub[1],x = thing2(sub), Survey = "Raw Exit"))

sub <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/WEEAC/Y4 Q1 Universal Continued .xlsx")[,c(53,57:62)]
sub$issue <- "None"

temp <- rbind(temp,cbind(sub[1],x = thing2(sub), Survey = "Universal Continued"))


sub <- read_excel("C:/Users/DavidMcCullough/OneDrive - Marzano Research/Data & Scripts/WEEAC/Y4 Q1 Universal Exit.xlsx")[,c(55,66:71)]
sub$issue <- "None"

temp <- rbind(temp,cbind(sub[1],x = thing2(sub), Survey = "Universal"))

temp$title_Number <- NA
for (i in 1:NROW(WEEAC_Equity_alignment)) {
  index <- grep(WEEAC_Equity_alignment$`Project Title`[i],x = temp$`Link Name`)
  if (length(index) > 0) {
    temp[index,]$title_Number <- WEEAC_Equity_alignment$`Project Title`[i]
  } else{
    next
  }
  
}

summary <- temp %>%
  group_by(title_Number) %>%
  summarise(correct = sum(x), n = n(), percentage = sum(x)/n()*100)

write.csv(summary, "percentages.csv")
write.csv(temp, "data.csv")

