# combine data
# install.packages("stringr")
library(stringr)



##############################################################################################
# make correct FIPS codes in each table
# make sure to have corrected the column names for categories first!
##############################################################################################

# need to identify site information about each table

colnames(wu1985)[1:6] <- c("STATE", "YEAR", "AGENCY", "SCODE", "AREA", "TP.TotPop")
colnames(wu1990)[1:6] <- c("STATE", "YEAR", "AGENCY", "SCODE", "AREA", "TP.TotPop")
colnames(wu1995)[1:6] <- c("YEAR", "STATE", "STATECODE", "COUNTYCODE", "COUNTY", "TP.TotPop")

colnames(wu2000)[1:5]
colnames(wu2005)[1:5]
colnames(wu2010)[1:7]

# need to correct FIPS codes 


wu1985[,4] <- str_pad(wu1985[,4], 2,pad="0")
wu1985[,5] <- str_pad(wu1985[,5], 3,pad="0")
wu1985$FIPS <- NA
wu1985$FIPS <- paste0(wu1985[,4],wu1985[,5])

wu1990[,4] <- str_pad(wu1990[,4], 2,pad="0")
wu1990[,5] <- str_pad(wu1990[,5], 3,pad="0")
wu1990$FIPS <- NA
wu1990$FIPS <- paste0(wu1990[,4],wu1990[,5])

wu1995[,3] <- str_pad(wu1995[,3], 2,pad="0")
wu1995[,4] <- str_pad(wu1995[,4], 3,pad="0")
wu1995$FIPS <- NA
wu1995$FIPS <- paste0(wu1995[,3],wu1995[,4])

wu2000[,2] <- str_pad(wu2000[,2], 2,pad="0")
wu2000[,3] <- str_pad(wu2000[,3], 3,pad="0")
wu2000$FIPS <- NA
wu2000$FIPS <- paste0(wu2000[,2],wu2000[,3])



wu2005[,2] <- str_pad(wu2005[,2], 2,pad="0")
wu2005[,3] <- str_pad(wu2005[,3], 3,pad="0")
wu2005$FIPS <- NA
wu2005$FIPS <- paste0(wu2005[,2],wu2005[,3])

wu2010[,2] <- str_pad(wu2010[,2], 2,pad="0")
wu2010[,4] <- str_pad(wu2010[,4], 3,pad="0")
wu2010$FIPS <- NA
wu2010$FIPS <- paste0(wu2010[,2],wu2010[,4])

