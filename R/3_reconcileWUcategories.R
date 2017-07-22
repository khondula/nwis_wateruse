# combine water use data from each year into one data frame
# need to refer to category changes: http://water.usgs.gov/watuse/WU-Category-Changes.html

# make vectors of categories for each year
categories2010 <- colnames(wu2010)[8:ncol(wu2010)]
categories2005 <- colnames(wu2005)[6:ncol(wu2005)]
categories2000 <- colnames(wu2000)[6:ncol(wu2000)]
categories1995 <- colnames(wu1995)[7:ncol(wu1995)]
categories1990 <- colnames(wu1990)[7:ncol(wu1990)]
categories1985 <- colnames(wu1985)[7:ncol(wu1985)]

# note that 1985 and 1990 categories are the same
# find unique categories for 1995-2010
post90categories <- unique(c(categories1995, categories2000, categories2005, categories2010))

##############################################################################################
# function to compare water use category names
##############################################################################################
matchNames <- function(x,y){
  # test for same category by checking if the first 2 letters the same
  categoryMatch <- setequal(substr(x,1,2),tolower(substr(y,1,2)))
  if(categoryMatch==FALSE){
    return(categoryMatch)
  } else {
    # test if all the letters in first string match the letters in the second string
    if(categoryMatch==TRUE){
      xletters <- strsplit(x, split="")
      yletters <- strsplit(tolower(y), split="")
      lettersMatch <- setequal(sort(xletters[[1]]), sort(yletters[[1]])) 
      return(lettersMatch)
    }
  }
  }
# end function to compare water use category names
##############################################################################################
results.matrix <-outer(categories1985, post90categories, function(x,y)mapply(matchNames,x,y))
# make a table from results of matched 1995 categories for 1985 category names
results <- as.data.frame(results.matrix)
colnames(results) <- post90categories

# use data from match function to make 2 columns of old and new names
match1985categories <- as.data.frame(categories1985)
match1985categories$match <- NA
match1985categories$match <- sapply(1:length(categories1985), 
                                    function(x) colnames(results)[grep(TRUE, results[x,])])

##############################################################################################
# reconcile ambiguous categories
##############################################################################################
# for 1985 categories with multiple or no matches, look at data dictionaries online 
# http://water.usgs.gov/watuse/data/1990/datadict.html

mc <- match1985categories

makeNewMatch <- function(oldname, newname){
  mc[which(mc[,1]==oldname),"match"] <- newname
  return(mc)
}

# ambiguous categories
# in 2000, irrigation was categorized as IT and then IR in 2005

# has corresponding category name in newer data that didn't match
mc <- makeNewMatch("ps.total", "PS.Wtotl") # Public Supply, total withdrawals, total (fresh+saline), in Mgal/d
mc <- makeNewMatch("ps.deliv", "PS.DelTO") # Public Supply Water deliveries: total deliveries
mc <- makeNewMatch("ps.loss", "PS.UsLos") # Public Supply Water deliveriess: public use and losses
mc <- makeNewMatch("co.total", "CO.WDelv") # Commercial water use: Total withdrawals + deliveries
mc <- makeNewMatch("co.cuse", "CO.CUTot") # Commercial Water Use: Consumptive use, total
mc <- makeNewMatch("do.ssgwf","DO.WGWFr") # Domestic, self-supplied groundwater withdrawals, fresh, in Mgal/d
mc <- makeNewMatch("do.ssswf","DO.WSWFr") # Domestic, self-supplied surface-water withdrawals, fresh, in Mgal/d
mc <- makeNewMatch("do.sstot","DO.WFrTo") # Domestic, total self-supplied withdrawals, fresh, in Mgal/d
mc <- makeNewMatch("do.cuse","DO.CUTot") # Domestic, public supplied, consumptive use (units not specified)
mc <- makeNewMatch("in.total","IN.WDelv") # Industrial Total industrial withdrawal + deliveries
mc <- makeNewMatch("in.cufr","IN.CUsFr") # Industrial Consumptive use, fresh
mc <- makeNewMatch("in.cusal","IN.CUsSa")
mc <- makeNewMatch("in.cuse","IN.CUTot")
mc <- makeNewMatch("pt.frtot","PT.WFrTo") # All thermoelectric water use:Total, fresh
mc <- makeNewMatch("pt.total","PT.WDelv")
mc <- makeNewMatch("pt.cufr","PT.CUsFr")
mc <- makeNewMatch("pt.cusal","PT.CUsSa")
mc <- makeNewMatch("pt.cuse","PT.CUTot")
mc <- makeNewMatch("pf.frtot","PF.WFrTo")
mc <- makeNewMatch("pf.total","PF.WDelv")
mc <- makeNewMatch("pf.cufr","PF.CUsFr")
mc <- makeNewMatch("pf.cusal","PF.CUsSa")
mc <- makeNewMatch("pf.cuse","PF.CUTot")
mc <- makeNewMatch("pg.cufr","PG.CUsFr")
mc <- makeNewMatch("pg.cusal","PG.CUsSa")
mc <- makeNewMatch("pn.frtot","PG.CUTot")
mc <- makeNewMatch("pn.total","PN.WDelv")
mc <- makeNewMatch("pn.cufr","PN.CUsFr")
mc <- makeNewMatch("pn.cusal","PN.CUsSa")
mc <- makeNewMatch("pn.cuse","PN.CUTot")
mc <- makeNewMatch("mi.frtot","MI.WFrTo")
mc <- makeNewMatch("mi.satot","MI.WSaTo")
mc <- makeNewMatch("mi.total","MI.WDelv")
mc <- makeNewMatch("mi.cufr","MI.CUsFr")
mc <- makeNewMatch("mi.cusal","MI.CUsSa")
mc <- makeNewMatch("mi.cuse","MI.CUTot")
mc <- makeNewMatch("ls.total","LS.WTotl")
mc <- makeNewMatch("ls.cuse","LS.CUTot")
mc <- makeNewMatch("la.total","LA.WTotl")
mc <- makeNewMatch("la.cuse","LA.CUTot")
mc <- makeNewMatch("lv.total","LV.WTotl")
mc <- makeNewMatch("lv.cuse","LV.CUTot")
mc <- makeNewMatch("ir.frtot","IR.WFrTo")
mc <- makeNewMatch("ir.irrig","IR.IrTot")
mc <- makeNewMatch("ir.convy","IR.CLoss")
mc <- makeNewMatch("ir.cuse","IR.CUTot")
mc <- makeNewMatch("hy.power","HY.ToPow")
mc <- makeNewMatch("hy.facil","HY.ToFac")
mc <- makeNewMatch("hy.facdb","HY.ToFDB") # not completely sure if this is the same
mc <- makeNewMatch("re.evap","RE.Evapo")
mc <- makeNewMatch("re.area","RE.SurAr")
mc <- makeNewMatch("ww.retrn","WW.PuRet")
mc <- makeNewMatch("ww.facil","WW.ToFac")
mc <- makeNewMatch("to.gwsal","TO.WGWSa")
mc <- makeNewMatch("to.swsal","TO.WSWSa")
mc <- makeNewMatch("to.frtot","TO.WFrTo")
mc <- makeNewMatch("to.satot","TO.WSaTo")
mc <- makeNewMatch("to.total","TO.WTotl")
mc <- makeNewMatch("to.cufr","TO.CUsFr")
mc <- makeNewMatch("to.cusal","TO.CUsSa")
mc <- makeNewMatch("to.cuse","TO.CUTot")
mc <- makeNewMatch("to.convy","TO.CLoss")
mc <- makeNewMatch("lv.gwtot", "LI.WGWTo")

# no corresponding category in newer data
# irrigation: surface = flooding, spray is both sprinkler and microirrigation
mc <- makeNewMatch("ir.spray","ir.spray") # sprayed acres (new categories of irrigation are sprinkler, microirrigation, surface)
mc <- makeNewMatch("ir.flood","IR.IrSur") # flooded acres = surface irrigation
mc <- makeNewMatch("hy.total","hy.total")




# look at double matches
# mc[which(substr(mc[,2],1,2)=="c("),]

# double matches
mc <- makeNewMatch("do.sspop","DO.SSPop")
mc <- makeNewMatch("do.sspcp","DO.SSPCp")
mc <- makeNewMatch("do.pspop","DO.PSPop")
mc <- makeNewMatch("do.pspcp","DO.PSPCp")
mc <- makeNewMatch("in.wtotl","IN.Wtotl")
mc <- makeNewMatch("pt.wtotl","PT.Wtotl")
mc <- makeNewMatch("pg.wgwsa","PG.WGWSa")
mc <- makeNewMatch("ls.swtot","LS.WSWTo")
mc <- makeNewMatch("la.swtot","LA.WSWTo")
mc <- makeNewMatch("ww.facot","WW.OtFac")


#######################################################################################

# name changes after 1990
# by default match to the same category name
# IT in 1990 changed to IR

match2000Categories <- as.data.frame(categories2000)
match2000Categories$match <- categories2000

mc2000 <- match2000Categories

makeNewMatch2000 <- function(oldname, newname){
  mc2000[which(mc2000[,1]==oldname),"match"] <- newname
  return(mc2000)
}


# Irrigation name from IT to IR
mc2000 <- makeNewMatch2000("IT.IrSpr", "IR.IrSpr")
mc2000 <- makeNewMatch2000("IT.IrMic", "IR.IrMic")
mc2000 <- makeNewMatch2000("IT.IrSur", "IR.IrSur")
mc2000 <- makeNewMatch2000("IT.IrTot", "IR.IrTot")
mc2000 <- makeNewMatch2000("IT.WGWFr", "IR.WGWFr")
mc2000 <- makeNewMatch2000("IT.WSWFr", "IR.WSWFr")
mc2000 <- makeNewMatch2000("IT.WFrTo", "IR.WFrTo")

# Wtotl to WTotl
# mc2000 <- makeNewMatch2("PO.Wtotl", "PO.WTotl")
# mc2000 <- makeNewMatch2("TO.Wtotl", "TO.WTotl")

# Wtotl to WTotl for 2005 data

# match2005Categories <- as.data.frame(categories2005)
# match2005Categories$match <- categories2005

# mc2005 <- match2005Categories

# makeNewMatch2005 <- function(oldname, newname){
#  mc2005[which(mc2005[,1]==oldname),"match"] <- newname
#  return(mc2005)
#}


# Livestock (total) name from LV to LI for 1995 data

# 1995 LV is total livestock
# 2000 LS is livestock (separate from aquaculture)
# 2005 LS is livestock (separate from aquaculture)
# in 2010 livestock is LI, distinct from aquaculture

match1995Categories <- as.data.frame(categories1995)
match1995Categories$match <- categories1995

mc1995 <- match1995Categories

makeNewMatch1995 <- function(oldname, newname){
 mc1995[which(mc1995[,1]==oldname),"match"] <- newname
  return(mc1995)
}

mc1995 <- makeNewMatch1995("MI.WTotl", "MI.Wtotl")
mc1995 <- makeNewMatch1995("PS.WTotl", "PS.Wtotl")
mc1995 <- makeNewMatch1995("IN.WTotl", "IN.Wtotl")
mc1995 <- makeNewMatch1995("PT.WTotl", "PT.Wtotl")
# all livestock pre1995 to LI like 2010 data
# 2010 only has groundwater, surface water, total
mc1995 <- makeNewMatch1995("LV.WGWFr", "LI.WGWFr")
mc1995 <- makeNewMatch1995("LV.WSWFr","LI.WSWFr")
mc1995 <- makeNewMatch1995("LV.WFrTo","LI.WFrTo")
mc1995 <- makeNewMatch1995("LV.WGWTo", "LI.WGWTo")


##############################################################################################
# rename categories in 1985 and 1990 tables with newer matched names
##############################################################################################
colnames(wu1985)[7:ncol(wu1985)] <- mc$match
colnames(wu1990)[7:ncol(wu1990)] <- mc$match

colnames(wu1995)[7:ncol(wu1995)] <- mc1995$match
colnames(wu2000)[6:ncol(wu2000)] <- mc2000$match
#colnames(wu2005)[6:ncol(wu2005)] <- mc2005$match


#grep("PS.W",categories1995,value=TRUE) # PS.WTotl
#grep("PS.W",categories2005,value=TRUE) # PS.Wtotl
#grep("PS.W",categories2010,value=TRUE) # PS.Wtotl

# grep("IN.W",categories1995,value=TRUE) # IN.WTotl
# grep("IN.W",categories2005,value=TRUE) # IN.Wtotl
# grep("IN.W",categories2010,value=TRUE) # IN.Wtotl
# 
# grep("PT.W",categories1995,value=TRUE) # PT.WTotl
# grep("PT.W",categories2005,value=TRUE) # PT.Wtotl
# grep("PT.W",categories2010,value=TRUE) # PT.Wtotl
# 
# grep("LV", categories1995, value=TRUE) # LV.WGWTo
