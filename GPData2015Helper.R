# -----------------------------------------------------------------------------
# gp_up_to_2015 Input Validation Helper Script
#
# author: Michael Johns
#
# about: This script allows the user to enter a GP Practice ID to console
#        and validates data matches the expected format (W#####)
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
# List GP available tables and individual tables
# Console and Tidyverse Functions
#------------------------------------------------------------------------------

# list gp practice columns in Console
gpTablesConsole <- function(db){
  listTables(db)
}
# list gp practice columns in Tidyverse
gpTablesTidy <- function(dbConnection){
  tidyTableStructure(dbListTables(dbConnection))
}

# output bnf Table Structure
gpBnfTableStructureConsole <- function(db){
  listTableStructure('bnf')
}
# output bnf Table structure using Tidyverse
gpBnfTableTidy <- function(db){
  tidyTableStructure('bnf')
}

# output address Table Structure
gpAddressTableStructureConsole <- function(db){
  listTableStructure('address')
}
# output address Table structure using Tidyverse
gpAddressTableTidy <- function(db){
  tidyTableStructure('address')
}

# output chemsubstance Table Structure
gpChemSubstanceTableStructureConsole <- function(db){
  listTableStructure('chemsubstance')
}
# output chemsubstance Table structure using Tidyverse
gpChemSubstanceTableTidy <- function(db){
  tidyTableStructure('chemsubstance')
}

# output gp_data_up_to_2015 Table Structure
gpGpDataUpTo2015TableStructureConsole <- function(db){
  listTableStructure('gp_data_up_to_2015')
}
# output gp_data_up_to_2015 Table structure using Tidyverse
gpGpDataUpTo2015TableTidy <- function(db){
  tidyTableStructure('gp_data_up_to_2015')
}

# output qof_achievement Table Structure
gpQofAchievementTableStructureConsole <- function(db){
  listTableStructure('qof_achievement')
}
# output qof_achievement Table structure using Tidyverse
gpQofAchievementTableTidy <- function(db){
  tidyTableStructure('qof_achievement')
}

# output qof_indicator Table Structure
gpQofIndicatorTableStructureConsole <- function(db){
  listTableStructure('qof_indicator')
}
# output qof_indicator Table structure using Tidyverse
gpQofIndicatorTableTidy <- function(db){
  tidyTableStructure('qof_indicator')
}

#------------------------------------------------------------------------------
# 

