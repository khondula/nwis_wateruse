# install.packages("plyr")
library(plyr)

# merge data into one table merging on FIPS
# keep year, FIPS, and all unique columns of categories

# add year column into 2000 data
wu2000$YEAR <- 2000

# keep year, FIPS, and all unique columns of categories
wu85 <- wu1985[,c(2,6:ncol(wu1985))]
wu90 <- wu1990[,c(2,6:ncol(wu1990))]
wu95 <- wu1995[,c(1,6:ncol(wu1995))]
wu00 <- wu2000[,c(4:ncol(wu2000))]
wu05 <- wu2005[,c(4:ncol(wu2005))]
wu10 <- wu2010[,c(5:ncol(wu2010))]

# head(wu85)

# join all together



wu <- rbind.fill(wu85,wu90,wu95,wu00,wu05,wu10)


# FIPS is column 160, move it to front

# length(colnames(wu))
# colnames(wu)[160]
wu <- wu[,c(160,1:159,161:ncol(wu))]
#nrow(wu)
# test for duplicate column names
#anyDuplicated(colnames(wu))

#wu[1:5,1:5]
#ncol(wu)
# MAKE FIPS COLUMN CHARACTER TO BE WRAPPED IN QUOTES WITH QUOTE=TRUE ARGUMENT IN WRITE CSV

wu$FIPS <- as.character(wu$FIPS)

# SAVE THE FILE
# write.csv(wu, "wu_reconciled.csv", quote=TRUE)

# for purposes of naming data_individuals, write a csv that is just the names of the columns

wu_reconciled_colnames <- as.data.frame(colnames(wu))
# write.csv(wu_reconciled_colnames, "wu_reconciled_colnames.csv")

# grep("LV.WGWTo", colnames(wu85), value=TRUE)

#grep("Totl", names(wu))

# wu[c(13,43,57,211,266),c(1,2)]
