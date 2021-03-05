#------------------------------------------------------------------------------
# Standalone Test script, mainly used to interrogate the data
# during development
# Author: Michael Johns
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Install and Load Library Packages (uncomment to install)
#------------------------------------------------------------------------------

#install.packages('tidyverse')
#install.packages('GetoptLong')
#install.packages('RPostgreSQL')
#install.packages("gt")
library(tidyverse)
library(GetoptLong)
library(RPostgreSQL)
library(gt)

#------------------------------------------------------------------------------
# Load required source files
#------------------------------------------------------------------------------
source("ConnectPostgreSQL.R")
source("PostgreSQLHelper.R")
source("GPData2015Helper.R")

#------------------------------------------------------------------------------
# Database connections and PostgreSQL driver initialisation
#------------------------------------------------------------------------------

# Load database driver (database_name)
database_driver <- connectDriver('PostgreSQL')

# Connect to DB (Driver, name, host address, port, database username)
db <- connectDB(database_driver,
                'gp_practice_data',
                'localhost', 5432,
                'postgres')

#------------------------------------------------------------------------------
# Database tables information and layout queries
# testing and data interrogation
#------------------------------------------------------------------------------

# List available tables from connected database
gpTablesConsole(db)
# List available tables in Tidyverse View
gpTablesTidy(db)

# Output table structures into Console
gpAddressTableStructureConsole(db)
gpBnfTableStructureConsole(db)
gpChemSubstanceTableStructureConsole(db)
gpGpDataUpTo2015TableStructureConsole(db)
gpQofAchievementTableStructureConsole(db)
gpQofIndicatorTableStructureConsole(db)

# output table structures using Tidyverse
address <- gpAddressTableTidy(db)
bnf <- gpBnfTableTidy(db)
chem_substance <- gpChemSubstanceTableTidy(db)
gp_data_up_to_2015 <- gpGpDataUpTo2015TableTidy(db)
qof_achievement <- gpQofAchievementTableTidy(db)
qof_indicator <- gpQofIndicatorTableTidy(db)

# output gp_data_up_to_2015 structure using Tidyverse
tidyTableStructure(db, 'gp_data_up_to_2015')

#------------------------------------------------------------------------------
# User selects Practice ID
#------------------------------------------------------------------------------

# Input prompt for user entered practice ID
practiceID <- userPracticeIDInput()

# manually entered practice ID for testing
practiceID = 'W00005'

# Get all CAN001 indicators from qof_achievement table
qofAchievementCAN001 <- getQofAchievementIndicator(db, 'CAN001')
View(qofAchievementCAN001)

# get complete table for qof_achievement and practiceID
qofAchievementW00005 <- getPracticeTable(db, 'gp_data_up_to_2015', practiceID)
View(qofAchievementW00005)

# Get complete table from a PostGreSQL database
gettabletest <- getTable(db, 'gp_data_up_to_2015', 10)
View(gettabletest)

getGPAddressTable(db, 10)

#check total amount of patients in a practice
# field4 is total amount of patients in a single practice
# when CAN001 is used, as CAN001 is present in all practice
W00005PatientTotal <- GetPracticeAmountOfPatients(db, 'W00005')
print(W00005PatientTotal)


#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
