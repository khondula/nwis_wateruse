

# load data from USGS about Water Use in the US

# 2010 data
url <- "https://water.usgs.gov/watuse/data/2010/usco2010.txt"

wu2010 <- read.delim(url, sep="\t",
                     colClasses=c("factor", "integer", "character", "integer", "integer", "integer", rep("numeric", 111)),
                     na.strings=c("N/A"))

# get rid of extra column
wu2010 <- wu2010[,1:117]

# 2005 data

url <- "https://water.usgs.gov/watuse/data/2005/usco2005.txt"
wu2005 <- read.delim(url)
# get rid of extra column and extra rows
wu2005 <- wu2005[1:3222,1:107]
# str(wu2005)

# 2000 data
url <- 'https://water.usgs.gov/watuse/data/2000/usco2000.txt'
wu2000 <- read.delim(url)
# str(wu2000)

# 1995 data
# ush895.txt link is broken to get data at HUC8 scale
url <- 'https://water.usgs.gov/watuse/data/1995/us95co.txt'
wu1995 <- read.delim(url)
# get rid of extra column
wu1995 <- wu1995[,1:252]
#str(wu1995)

# 1990 data
url <- "https://water.usgs.gov/watuse/data/1990/us90co.txt"
wu1990 <- read.delim(url)
# str(wu1990)


# 1985 data
url <- "https://water.usgs.gov/watuse/data/1985/us85co.txt"
wu1985 <- read.delim(url)
# str(wu1985)
