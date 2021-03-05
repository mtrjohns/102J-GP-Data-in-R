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
    cat("The GP Practice Id has been set to: ")
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
getQofAchievementTable <- function(db, limit){
  QofAchievementTable <- getTable(db, 'qof_achievement', limit)
  View(QofAchievementTable)
  return(QofAchievementTable)
}

# Get and display GP qof_indicators Table
# Inputs: (Database connection, Row limit)
#--  Warning: large tables can be slow to retrieve with high limit values set
getQofIndicatorTable <- function(db, table, limit){
  QofIndicatorTable <- getTable(db, table, limit)
  View(QofIndicatorTable)
  return(QofIndicatorTable)
}

#------------------------------------------------------------------------------
# Cancer Database get functions
#------------------------------------------------------------------------------
# Total number of patients in practice
# using CAN001 automatically to ignore subsets of patients
# Inputs: (Database connection, Practice ID(e.g. W#####))
GetPracticeAmountOfPatients <- function(db, practiceID){
  totalPatients <- dbGetQuery(db,qq(
    'select field4
    from qof_achievement
    where indicator like \'CAN001\' and
    orgcode like \'@{practiceID}\';'))
    
    return(as.integer(totalPatients))
}

# Get Indicator from qof_achievement table
# Inputs: (Database Connection, Indicator type (e.g. CAN001))
getQofAchievementIndicator <- function(db, indicator){
  dbGetQuery(db,qq(
    'select * from qof_achievement
    where indicator like \'@{indicator}\';'))
}

getAchieveIndiAndPractice <- function(db, indicator,practiceID){
    dbGetQuery(db,qq(
      'select * from qof_achievement
      where indicator like \'@{indicator}\'
      and orgcode like \'@{practiceID}\';'
      ))
}

# Complete table for a single practice
# Inputs: (Database connection, table name, Practice ID(e.g. W#####))
getPracticeTable <- function(db, table, practiceID){
  dbGetQuery(db,qq(
    'select *
    from @{table}
    where orgcode like \'@{practiceID}\';'))
}
