Merging.Everything <- read.csv("~/Merging Everything.csv")

length(unique(Merging.Everything$Title))

fuzzyg <- function(a){agrep(pattern = a,x = Merging.Everything$Title,max.distance = 3,ignore.case = TRUE)}

lapply(X = Merging.Everything$Title[1:50], fuzzyg)
