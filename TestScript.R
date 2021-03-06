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
#install.packages("ggplot2")
library(tidyverse)
library(GetoptLong)
library(RPostgreSQL)
library(gt)
library(ggplot2)

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
practiceID = 'W00007'

# Get all CAN001 indicators from qof_achievement table
qofAchievementCAN001 <- getQofAchievementIndicator(db, 'CAN001')
View(qofAchievementCAN001)

# Get all CAN001 indicators from qof_achievement table
qofAchievementCAN001 <- getQofAchievementIndicatorAndPractice(db, 
                                            'CAN001', practiceID)
View(qofAchievementCAN001)

# get complete table for qof_achievement and practiceID
qofAchievementW00005 <- getGPQofAchievementTable(db, practiceID, 10)

# Get complete table from a PostGreSQL database with set limit on rows
gettabletest <- getTable(db, 'address', 10)
View(gettabletest)

#check for any NA values in each column (can just pipe summary)
summary(gettabletest)

getColumn(db, 'gp_data_up_to_2015', 'hb') %>% distinct %>% summary()
Locality
print(Locality)

# get specific table from gp_practice_data database, with limit on rows returned
getSummaryTableTest <- getGPDataUpTo2015Table(db, 100) %>% summary()
getSummaryTableTest

# get a single field from qof_achievement table
CancerPatientPercentage <- getGPQofAchievementField(db, practiceID, 
                                                    'CAN001', 'ratio')
print(CancerPatientPercentage)

CancerPatientPercentageAsNumeric <- getGPQofAchievementFieldAsNumeric(db,
                                                    practiceID, 
                                                    'CAN001',
                                                    'ratio')
print(CancerPatientPercentageAsNumeric)

# get a percentage of patients in Wales diagnosed with cancer
# from qof_achievement table
CancerPatientPercentageInWales <- getPercentageOfPatientsWithCancerInWales(db)
print(CancerPatientPercentage)

# check total amount of patients in a practice
W00005PatientTotal <- GetPracticeAmountOfPatients(db, 'W00005')
print(W00005PatientTotal)

# get percentage of patients in a single practice that have cancer
PracticeCancerPercentageTest <- getPracticePercentageOfPatientsWithCancer(db,
                                                                    practiceID)
print(PracticeCancerPercentageTest)

# Get single practice full table from gp_data_up_to_2015
singlePracticeTest <- getSinglePracticeGPdataUpTo2015(db, practiceID)
View(singlePracticeTest)

# Get top 5 prescribed drugs for a specific practice
topFivePrescribedDrugsTest <- getTopFiveDrugSpendSinglePractice(db, practiceID)
View(topFivePrescribedDrugsTest)

# Get percentage of patients diagnosed with cancer in a single practice
orgCode <- GetColumn(db, 'qof_achievement', 'orgcode')
View(orgCode)

#b <- ggplot(data = CancerPatientPercentage[0][0], aes(x=cty, y=hwy))

df <- data.frame( diagnosedData = c(practiceID, "Wales"),
                 PatientsDiagnosedWithCancer = c(as.numeric(PracticeCancerPercentageTest) * 100,
                           as.numeric(CancerPatientPercentageInWales) * 100))

b <- ggplot(data=df, aes(x = '',
                         y = 'Patients Diagnosed With Cancer',
                         fill = diagnosedData,
                         label = PatientsDiagnosedWithCancer)) +
                         geom_bar(stat="identity")
                         b + geom_text()


            as.numeric(PracticeCancerPercentageTest) * 100

#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
