# -----------------------------------------------------------------------------
# gp_up_to_2015 Input Validation Helper Script
#
# author: Michael Johns
#
# about: This script allows the user to enter a GP Practice ID to console
#        and validates data matches the expected format (W#####)
#       Among varying functions that work with the gp_data_practice database
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# User Input GP Selection and Validation
#------------------------------------------------------------------------------

# take a GP Practice ID and Validate Input
# format in the style of W01234 (character, 5 integers)
# Returns a Bool
practiceIdValidation <- function(gpPracticeID){
  isValid <- FALSE
  
  # Check input is as expected (Upper case character, 5 integers, W#####)
  if(grepl('^W[0-9]{5}$', gpPracticeID)){
    isValid <- TRUE
  }else{
    cat("Validation check failed. ")
  }

  return(isValid)
}

# Ask user to enter a practice ID from console and validate input
userPracticeIDInput <- function(){
  isValid = FALSE
  
  # read user input from console
  practiceID <- readline(prompt="Enter Practice ID (W#####): ")
  
  # validate console input matches format W#####
  isValid <- practiceIdValidation(practiceID)
  
  if(isValid){
    cat("The GP Practice Id has been set to: ", practiceID)
    return(practiceID)
  }
  else
  {
    cat("The GP Practice ID '", practiceID,
        "' is not valid, Please try again (example ID: W00001).", sep='')
  }
}

#------------------------------------------------------------------------------
# List GP available tables and individual table structures
# Console and Tidyverse Functions
#------------------------------------------------------------------------------

# list gp practice columns in Console
gpTablesConsole <- function(db){
  listTables(db)
}
# list gp practice columns in Tidyverse
gpTablesTidy <- function(dbConnection){
  databaseColumns <- listTables(db)
  View(databaseColumns)
}

# output address Table Structure
# inputs: (database connection)
gpAddressTableStructureConsole <- function(db){
  address <- listTableStructure(db, 'address')
  
  return(address)
}
# output address Table structure using Tidyverse
# inputs: (database connection)
gpAddressTableTidy <- function(db){
  address <- gpAddressTableStructureConsole(db)
  View(address)
  
  return(address)
}

# output bnf Table Structure
# inputs: (database connection)
gpBnfTableStructureConsole <- function(db){
  bnf <- listTableStructure(db, 'bnf')
  
  return(bnf)
}
# output bnf Table structure using Tidyverse
# inputs: (database connection)
gpBnfTableTidy <- function(db){
  bnf <- gpBnfTableStructureConsole(db)
  View(bnf)
  
  return(bnf)
}

# output chemsubstance Table Structure
# inputs: (database connection)
gpChemSubstanceTableStructureConsole <- function(db){
  chemsubstance <- listTableStructure(db, 'chemsubstance')
  
  return(chemsubstance)
}
# output chemsubstance Table structure using Tidyverse
# inputs: (database connection)
gpChemSubstanceTableTidy <- function(db){
  chemsubstance <- gpChemSubstanceTableStructureConsole(db)
  View(chemsubstance)
  
  return(chemsubstance)
}

# output gp_data_up_to_2015 Table Structure
# inputs: (database connection)
gpGpDataUpTo2015TableStructureConsole <- function(db){
  gp_data_up_to_2015 <- listTableStructure(db, 'gp_data_up_to_2015')
  
  return(gp_data_up_to_2015)
}
# output gp_data_up_to_2015 Table structure using Tidyverse
# inputs: (database connection)
gpGpDataUpTo2015TableTidy <- function(db){
  gp_data_up_to_2015 <- gpGpDataUpTo2015TableStructureConsole(db)
  View(gp_data_up_to_2015)
  
  return(gp_data_up_to_2015)
}

# output qof_achievement Table Structure
# inputs: (database connection)
gpQofAchievementTableStructureConsole <- function(db){
  qof_achievement <- listTableStructure(db, 'qof_achievement')
  
  return(qof_achievement)
}
# output qof_achievement Table structure using Tidyverse
# inputs: (database connection)
gpQofAchievementTableTidy <- function(db){
  qof_achievement <- gpQofAchievementTableStructureConsole(db)
  View(qof_achievement)
  
  return(qof_achievement)
}

# output qof_indicator Table Structure
# inputs: (database connection)
gpQofIndicatorTableStructureConsole <- function(db){
  qof_indicator <- listTableStructure(db, 'qof_indicator')
  
  return(qof_indicator)
}
# output qof_indicator Table structure using Tidyverse
# inputs: (database connection)
gpQofIndicatorTableTidy <- function(db){
  qof_indicator <- gpQofIndicatorTableStructureConsole(db)
  View(qof_indicator)
  
  return(qof_indicator)
}


#------------------------------------------------------------------------------
# Get database tables with their data for interrogation
# Warning: large tables can be slow to retrieve with high limit values set
#------------------------------------------------------------------------------
# Get and display GP Address Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPAddressTable <- function(db, limit){
  QofAddressTable <- getTable(db, 'address', limit)
  View(QofAddressTable)
  
  return(QofAddressTable)
}

# Get and display GP bnf Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPBnfTable <- function(db, limit){
  BnfTable <- getTable(db, 'bnf', limit)
  View(BnfTable)
  
  return(BnfTable)
}

# Get and display GP chemsubstance Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPChemSubstanceTable <- function(db, limit){
  ChemSubstanceTable <- getTable(db, 'chemsubstance', limit)
  View(ChemSubstanceTable)
  
  return(ChemSubstanceTable)
}

# Get and display gp_up_to_2015 Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPDataUpTo2015Table <- function(db, limit){
  GPDataUpTo2015Table <- getTable(db, 'gp_data_up_to_2015', limit)
  View(GPDataUpTo2015Table)
  
  return(GPDataUpTo2015Table)
}

# Get and display GP qof_achievements Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPQofAchievementTable <- function(db, practiceID, limit){
  QofAchievementTable <- getTable(db, 'qof_achievement', limit)
  View(QofAchievementTable)
  
  return(QofAchievementTable)
}

# Get and display GP qof_indicators Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getGPQofIndicatorTable <- function(db, limit){
  QofIndicatorTable <- getTable(db, 'qof_indicator', limit)
  View(QofIndicatorTable)
  
  return(QofIndicatorTable)
}

#------------------------------------------------------------------------------
# Region Table Functions
#------------------------------------------------------------------------------
# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection, healthboard Code (e.g. 7A1)
# Outputs: Single Healthboard table and practiceID
getHealthBoardGPdataUpTo2015 <- function(db, healthBoard){
  GPData2015Hb <- dbGetQuery(db, qq(
    'select distinct(hb), practiceid from gp_data_up_to_2015
    where hb like \'@{healthBoard}\';'
  ))
  return(GPData2015Hb)
}

# Get Practice Region(hb) Code
getGPPracticeRegionCode <- function(db, practiceID){
  # get Region(hb) Code field from specific practice
  regionCode <- dbGetQuery(db, qq(
      'select distinct(hb) from gp_data_up_to_2015
    where practiceid like \'@{practiceID}\';'))
    
    return(regionCode)
}

# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: betsiCadwaladrHB7A1 Healthboard table
getbetsiCadwaladrHB7A1 <- function(db){
  betsiCadwaladrHB7A1 <- getHealthBoardGPdataUpTo2015(db, '7A1')
  #View(betsiCadwaladrHB7A1)
  #summary(betsiCadwaladrHB7A1)
  
  return(betsiCadwaladrHB7A1)
}

# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: hywelDdaHB7A2 Healthboard table
getHywelDdaHB7A2 <- function(db){
  hywelDdaHB7A2 <- getHealthBoardGPdataUpTo2015(db, '7A2')
  #View(hywelDdaHB7A2)
  #summary(hywelDdaHB7A2)
  
  return(hywelDdaHB7A2)
}

# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: abertaweBroMorgannwgHB7A3 Healthboard table
getAbertaweBroMorgannwgHB7A3 <- function(db){
  abertaweBroMorgannwgHB7A3 <- getHealthBoardGPdataUpTo2015(db, '7A3')
  #View(abertaweBroMorgannwgHB7A3)
  #summary(abertaweBroMorgannwgHB7A3)
  
  return(abertaweBroMorgannwgHB7A3)
}
  
# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: betsiCadwaladrHB7A1 Healthboard table
getCardiffAndValeHB7A4 <- function(db){
  cardiffAndValeHB7A4 <- getHealthBoardGPdataUpTo2015(db, '7A4')
  #View(cardiffAndValeHB7A4)
  #summary(cardiffAndValeHB7A4)
  
  return(cardiffAndValeHB7A4)
}

# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: cwmTafHB7A5 Healthboard table
getCwmTafHB7A5 <- function(db){
  cwmTafHB7A5 <- getHealthBoardGPdataUpTo2015(db, '7A5')
  #View(cwmTafHB7A5)
  #summary(cwmTafHB7A5)
  
  return(cwmTafHB7A5)
}
# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: aneurinBevanHB7A6 Healthboard table
getAneurinBevanHB7A6 <- function(db){

  aneurinBevanHB7A6 <- getHealthBoardGPdataUpTo2015(db, '7A6')
  #View(aneurinBevanHB7A6)
  #summary(aneurinBevanHB7A6)
  
  return(aneurinBevanHB7A6)
}
# Get a single regions healthboard(hb) records from gp_data_up_to_2015 table
# Inputs: (Database Connection)
# Outputs: powysTeachingHB7A7 Healthboard table
getPowysTeachingHB7A7 <- function(db){ 
  powysTeachingHB7A7 <- getHealthBoardGPdataUpTo2015(db, '7A7')
  #View(powysTeachingHB7A7)
  #summary(powysTeachingHB7A7)
  
  return(powysTeachingHB7A7)
}

#------------------------------------------------------------------------------
# Total amount of patients in a practice
#------------------------------------------------------------------------------
# Total number of patients in practice
# using CAN001 automatically to ignore subsets of patients
# Inputs: (Database connection, Practice ID(e.g. W#####))
# Outputs: single practice total amount of registered patients for a practice 
#          as a numeric
# note: CAN001 is used, as CAN001 is present in every practice
getPracticeAmountOfPatients <- function(db, practiceID){
  totalPatients <- dbGetQuery(db,qq(
    'select field4
    from qof_achievement
    where indicator like \'CAN001\' and
    orgcode like \'@{practiceID}\';'))
    
    return(as.numeric(totalPatients))
}

getPracticeAmountOfPatientsAll <- function(db){
  totalPatientsAllPractices <- dbGetQuery(db,qq(
    'select field4, orgcode
    from qof_achievement
    where indicator like \'CAN001\';'))
  
  return(totalPatientsAllPractices)
}

#------------------------------------------------------------------------------
getPercentWithIndicator <- function(db, indicator){
  dbGetQuery(db, qq(
  'select ratio, orgcode
    from  qof_achievement
    where indicator like \'@{indicator}\';'))
}

getPercentageofPatientsWithIndicatorRegion <- function(db, indicator){
  dbGetQuery(db, qq(
    'select ratio, orgcode
    from  qof_achievement
    where indicator like \'CAN001\';'))
}

#------------------------------------------------------------------------------
# Health Condition Percentage of patient functions
#------------------------------------------------------------------------------
getdiagnosedCancerPercentage <- function(db){
  diagnosedCancerPercentage <- getPercentWithIndicator(db, 'CAN001') %>% 
    filter(!grepl('WAL', orgcode))
    #View(diagnosedCancerPercentage)
    
    return(diagnosedCancerPercentage)
}

getDiagnosedDementiaPercentage <- function(db){
  diagnosedDementiaPercentage <- getPercentWithIndicator(db, 'DM001') %>% 
    filter(!grepl('WAL', orgcode))
  #View(diagnosedDementiaPercentage)
  
  return(diagnosedDementiaPercentage)
}

#------------------------------------------------------------------------------
# Get percentage in region functions
#------------------------------------------------------------------------------

# return mean cancer rate for a region
# Inputs(Database Connection, one of 7 healthboard functions:
#
#               getbetsiCadwaladrHB7A1()
#               getHywelDdaHB7A2()
#               getAbertaweBroMorgannwgHB7A3()
#               getCardiffAndValeHB7A4()
#               getCwmTafHB7A5()
#               getAneurinBevanHB7A6()
#               getPowysTeachingHB7A7()     )
#
#Outputs: Mean Cancer Rate dependant on region input
getRegionDiagnosedCancerMean <- function(db, filteredHealthBoard){
  
  # obtain results from database gp_data_up_to_2015 table
  Region <- filteredHealthBoard
  
  # get cancer percent from qof_achievement database table
  DiagnosedCancerPatients <- getdiagnosedCancerPercentage(db) %>% 
    select(cancerrate = ratio, practiceid = orgcode)
  
  # join tables together to associate orgcode and practice code to cancerrate
  result <- Region %>% 
    left_join(DiagnosedCancerPatients, by = 'practiceid') %>%
    summarise(regionDiagnosedCancerRate = 
                round(mean(cancerrate, na.rm = TRUE) * 100, digits = 2))

  print(result)
  
  return(result)
}

# get current practice's region(hb) mean cancer rate
getPracticeRegionDiagnosedCancerMean <- function(db, practiceID){
  #case_when(result <- healthBoard == '7A1' ~ 
   #           getRegionDiagnosedCancerMean(db, getbetsiCadwaladrHB7A1(db)),
    #        healthBoard == '7A2' ~ 
     #         getRegionDiagnosedCancerMean(db, getHywelDdaHB7A2(db)),
      #      healthBoard == '7A3' ~ 
       #       getRegionDiagnosedCancerMean(db, getAbertaweBroMorgannwgHB7A3(db)),
        #    healthBoard == '7A4' ~ 
         #     getRegionDiagnosedCancerMean(db, getCardiffAndValeHB7A4(db)),
          #  healthBoard == '7A5' ~ 
           #   getRegionDiagnosedCancerMean(db, getCwmTafHB7A5(db)),
            #healthBoard == '7A6' ~ 
             # getRegionDiagnosedCancerMean(db, getAneurinBevanHB7A6(db)),
            #healthBoard == '7A7' ~ 
             # getRegionDiagnosedCancerMean(db, getPowysTeachingHB7A7(db)),
            
           #        )

  
  currentHb <- getGPPracticeRegionCode(db, practiceID)
  
  if(currentHb[1] == '7A1'){
    result <- getRegionDiagnosedCancerMean(db, getbetsiCadwaladrHB7A1(db))
    print('7A1')
  }
  if(currentHb[1] == '7A2'){
    result <- getRegionDiagnosedCancerMean(db, getHywelDdaHB7A2(db))
    print('7A2')
  }
  if(currentHb[1] == '7A3'){
    result <- getRegionDiagnosedCancerMean(db, getAbertaweBroMorgannwgHB7A3(db))
    print('7A3')
  }
  if(currentHb[1] == '7A4'){
    result <- getRegionDiagnosedCancerMean(db, getCardiffAndValeHB7A4(db))
    print('7A4')
  }
  if(currentHb[1] == '7A5'){
    result <- getRegionDiagnosedCancerMean(db, getCwmTafHB7A5(db))
    print('7A5')
  }
  if(currentHb[1] == '7A6'){
    result <- getRegionDiagnosedCancerMean(db, getAneurinBevanHB7A6(db))
    print('7A6')
  }
  if(currentHb[1] == '7A7'){
    result <- getRegionDiagnosedCancerMean(db, getPowysTeachingHB7A7(db))
    print('7A7')
  }
    
    return(result)
}


#------------------------------------------------------------------------------
# mixed functions needing sorting
#------------------------------------------------------------------------------
# get table single column
getColumn <- function(db, table, column){
  column <- dbGetQuery(db, qq(
    'select @{column}
    from  @{table};'
  ))
  return(column)
}

# get qof_indicator field from specific practice
getGPQofAchievementField <- function(db, practiceID, indicator, column){
  QofAchievementField <- dbGetQuery(db, qq(
    'select @{column}
    from  qof_achievement
    where indicator like \'@{indicator}\' and
    orgcode like \'@{practiceID}\';'))
  
    return(QofAchievementField)
}

# get qof_indicator field from specific practice as a numeric return type
getGPQofAchievementFieldAsNumeric <- function(db, practiceID, indicator, column)
  {
  QofAchievementFieldAsNumeric <- getGPQofAchievementField(db,
                                                          practiceID,
                                                          indicator,
                                                          column)
  
  return(as.numeric(QofAchievementFieldAsNumeric))
}

getPracticePercentageOfPatientsWithCancer <- function(db, practiceID){
  ratioOfPatientsWithCancer <- getGPQofAchievementField(db, practiceID, 
                                                      'CAN001', 'ratio')
  
  PercentageOfPatientsWithCancer = 
    round(as.numeric(ratioOfPatientsWithCancer) * 100, digits=2)
  
  return(PercentageOfPatientsWithCancer)
}

getPercentageOfPatientsWithCancerInWales <- function(db){
  ratioOfPatientsWithCancerInWales <- getGPQofAchievementField(db, 'WAL', 
                                                             'CAN001', 'ratio')
  PercentageOfPatientsWithCancerInWales =
    round(as.numeric(ratioOfPatientsWithCancerInWales) * 100, digits=2)
  
  return(PercentageOfPatientsWithCancerInWales)
}
  
  
# Get Indicator from qof_achievement table
# Inputs: (Database Connection, Indicator type (e.g. CAN001))
# Outputs: Raw qof_achievement table, filtered by indicator
getQofAchievementIndicatorRaw <- function(db, indicator){
  achievementIndicator <- dbGetQuery(db,qq(
    'select * from qof_achievement
    where indicator like \'@{indicator}\';'))
}
  
# Get Indicator from qof_achievement table (transformed)
# Inputs: (Database Connection, Indicator type (e.g. CAN001))
# Outputs: qof_achievement table transformed, filtered by indicator
# (column renames: orgcode = practiceid, numerator = indicatorpatients,
#                  field4 = practicepatientstotal, patientratio,
#                  indicator = indicator)
getQofAchievementIndicator <- function(db, indicator){
  achievementIndicator <- dbGetQuery(db,qq(
    'select * from qof_achievement
    where indicator like \'@{indicator}\';')) %>% 
    
    # take only the columns interested in and rename as below
      select(practiceid = orgcode,
                  indicatorpatients = numerator,
                  practicepatientstotal = field4,
                  patientratio = ratio,
                  indicator)
  
  return(achievementIndicator)
}

# Get Indicator from qof_achievement table
# Inputs: (Database Connection, Indicator type (e.g. CAN001), practiceID)
# Outputs: Raw qof_achievement table filtered by indicator for a single PracticeID
getQofAchievementIndicatorAndPracticeRaw <- function(db, indicator,practiceID){
  achievementIndicatorAndPractice <- dbGetQuery(db,qq(
    'select * from qof_achievement
      where indicator like \'@{indicator}\'
      and orgcode like \'@{practiceID}\';'
  ))
  
  return(achievementIndicatorAndPractice)
}

# Get Indicator from qof_achievement table for a single practice (transformed)
# Inputs: (Database Connection, Indicator type (e.g. CAN001), practiceID)
# Outputs: qof_achievement table, filtered by indicator, practiceID
# (column renames: orgcode = practiceid, numerator = indicatorpatients,
#                  field4 = practicepatientstotal, patientratio,
#                  indicator = indicator)
getQofAchievementIndicatorAndPractice <- function(db, indicator,practiceID){
  achievementIndicatorAndPractice <- dbGetQuery(db,qq(
      'select * from qof_achievement
      where indicator like \'@{indicator}\'
      and orgcode like \'@{practiceID}\';')) %>%
    
    # take only the columns interested in and rename as below
    select(practiceid = orgcode,
             indicatorpatients = numerator,
             practicepatientstotal = field4,
             patientratio = ratio,
             indicator)
  
  return(achievementIndicatorAndPractice)
}

# Get a single practice records from gp_data_up_to_2015 table
# Inputs: (Database Connection, Practice ID)
# Outputs: Practice Full Table
getSinglePracticeGPdataUpTo2015 <- function(db, practiceID){
  GPData2015 <- dbGetQuery(db, qq(
    'select * from gp_data_up_to_2015
    where practiceid like \'@{practiceID}\';'
  ))
  return(GPData2015)
}



# Get top 5 drugs prescribed by a single practice (transformed)
# Inputs: (Database Connection, practiceID)
# Outputs: table: top 5 drugs prescribed by a single practice
getTopFiveDrugSpendSinglePractice <- function(db, practiceID){
  
  topFivePrescribedDrugs <- dbGetQuery(db, qq(
    'select practiceid, bnfcode, bnfname, items, actcost
    from gp_data_up_to_2015
    where practiceid like \'@{practiceID}\';')) %>%

    # rename columns to a more user friendly output
    select(practiceid = practiceid, drugcode = bnfcode, drugname = bnfname,
           prescriptionquantity = items) %>%
    
    # group by drug code to avoid different inputs for same drugname
    group_by(drugcode) %>%
    
    # sum prescription quantity
    summarise(practiceid, drugcode, drugname, 
              prescriptiontotal=sum(prescriptionquantity)) %>%
    
    # only get unique rows by drugcode
    distinct(drugcode, .keep_all = TRUE) %>%
    ungroup() %>%
    
    # output top 5 prescribed drugs
    arrange(desc(prescriptiontotal)) %>% head(5)
  
    View(topFivePrescribedDrugs)
    
  return(topFivePrescribedDrugs)
}

#---------------------------------------------------------
# actcost
#---------------------------------------------------------

getGPPrescriptionTotalSpend <- function(db){
  cat("Obtaining all practices spending... Please wait...")
  
  # get actcost and practiceid from gp data
  GPPrescriptionCost <- dbGetQuery(db, qq(
    'select practiceid, actcost, hb
      from gp_data_up_to_2015;')) %>%
    
    # rename columns to a more user friendly output
    select(practiceid = practiceid, healthboard = hb, prescriptionCostTotal = actcost) %>%
    group_by(practiceid) %>%
    summarise(practiceid, healthboard, prescriptionCostTotal=round(sum(prescriptionCostTotal),2)) %>%
    distinct()
  
  #View(GPPrescriptionCost)
  return(GPPrescriptionCost)
}

getGPTotalPatients <- function(db){
  # get patient count from qof_indicator
  GPTotalPatientCount <- getPracticeAmountOfPatientsAll(db)
  #View(GPTotalPatientCount)
  return(GPTotalPatientCount)
}


getAllPracticeActCostSum <- function(db){
  
  cat("Obtaining all practices spending... Please wait...")
  
  # get actcost and practiceid from gp data
  prescriptionCostTotal <- getGPPrescriptionTotalSpend(db)
    
  
  #View(prescriptionCostTotal)
    # sum the presciption total for each practice
    #summarise(sum(prescriptionCostTotal, na.rm=TRUE))
  
  # get patient count from qof_indicator
  GPTotalPatientCount <- getPracticeAmountOfPatientsAll(db) %>%
    select(practiceid = orgcode, totalPatients = field4)
  #View(GPTotalPatientCount)
  
  # join tables by practiceid column
  prescriptionCostTotalJoined <- GPTotalPatientCount %>% 
    left_join(prescriptionCostTotal, by = 'practiceid') %>%
    distinct(practiceid, .keep_all = TRUE) %>%
    filter(grepl('^W[0-9]{5}$', practiceid))
    #View(prescriptionCostTotalJoined)
  
  # calculate average per practice and return full table
  perPersonSpend <- prescriptionCostTotalJoined %>%
    mutate(perPatientCost = round(prescriptionCostTotal / totalPatients, 2))
    
  return(perPersonSpend)
}

# Complete table for a single practice
# Inputs: (Database connection, table name, Practice ID(e.g. W#####))
barCancerRateComparisonPracticeRegionWales <- function(db, practiceID){

  # get current Practice's region code(hb)
  regionMeanCancerRate <- getPracticeRegionDiagnosedCancerMean(db, practiceID)
  
  # get a percentage of patients in Wales diagnosed with cancer
  # from qof_achievement table
  CancerPatientPercentageInWales <- getPercentageOfPatientsWithCancerInWales(db)
  
  # get percentage of patients in a single practice that have cancer
  PracticeCancerPercentage <- getPracticePercentageOfPatientsWithCancer(db,
                                                                    practiceID)
  
  df <- data.frame( CancerDiagnosisType = c(practiceID, "Region", "Wales"),
                                PatientsDiagnosedWithCancer = 
                                    c(as.numeric(PracticeCancerPercentage),
                                    as.numeric(regionMeanCancerRate),
                                    as.numeric(CancerPatientPercentageInWales)))
  
  b <- ggplot(data=df, aes(x = CancerDiagnosisType,
                           y = 'Patients Diagnosed With Cancer',
                           fill = CancerDiagnosisType,
                           label = paste(PatientsDiagnosedWithCancer, "%"))) +
    geom_bar(stat="identity")
  
  plot(b + theme(axis.text.y = element_text(angle = 90)) + 
         geom_text(vjust=-0.5))
}


# Scatter plot showing Per Patient Drug Spend To Total Registered Patients
# In Each Practice
scatterPlotPerPatientSpend <- function(db){
  
  mycolors = c("#999999", healthboard="#E69F00", "#56B4E9", "#009E73", "#F0E442",
               "#0072B2", "#D55E00", "#cc79a7")
  
  PerPatientSpending <- getAllPracticeActCostSum(db)
  
  s <- ggplot(data=PerPatientSpending, aes(x = totalPatients,
                                       y = perPatientCost, col=healthboard)) +
  geom_point() +
    theme_bw() +
    scale_color_manual(values=mycolors) +
  ggtitle("Per Patient Drug Spend To Total Registered Patients In Each Practice") +
    labs(x = "Registered Patients",
         y = "Drug Spend (Per Patient)")
  
  plot(s)
}










