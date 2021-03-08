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
gettabletest <- getTable(db, 'qof_achievement', 10)
View(gettabletest)
gettabletest <- getTable(db, 'qof_indicator', 10)
View(gettabletest)

#check for any NA values in each column (can just pipe summary)
summary(gettabletest)

# get local health board structure
Locality <- getColumn(db, 'gp_data_up_to_2015', 'hb') %>% distinct %>% summary()
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

# check total amount of patients in a practice
W00005PatientTotal <- GetPracticeAmountOfPatients(db, 'W00005')
print(W00005PatientTotal)

# Get single practice full table from gp_data_up_to_2015
singlePracticeTest <- getSinglePracticeGPdataUpTo2015(db, practiceID)
View(singlePracticeTest)

# Get top 5 prescribed drugs for a specific practice
topFivePrescribedDrugsTest <- getTopFiveDrugSpendSinglePractice(db, practiceID)
View(topFivePrescribedDrugsTest)

# Get percentage of patients diagnosed with cancer in a single practice
orgCode <- getColumn(db, 'qof_achievement', 'orgcode')
View(orgCode)

# get current practice code, as a dataframe
currentPracticeRegionCode <- getGPPracticeRegionCode(db, practiceID)
print(currentPracticeRegionCode)

# get current Practice's region code(hb)
currentPracticeRegionMeanCancerRate <- getPracticeRegionDiagnosedCancerMean(db, practiceID)
print(mean231$regionDiagnosedCancerRate[1])

# get a percentage of patients in Wales diagnosed with cancer
# from qof_achievement table
CancerPatientPercentageInWales <- getPercentageOfPatientsWithCancerInWales(db)
print(CancerPatientPercentageInWales)

# get percentage of patients in a single practice that have cancer
PracticeCancerPercentageTest <- getPracticePercentageOfPatientsWithCancer(db,
                                                                          practiceID)
print(PracticeCancerPercentageTest)

tester4 <- getRegionDiagnosedCancerMean(db, getHywelDdaHB7A2(db))
print(tester4)

# Show Comparison graph of practice, practice's region(by health board) 
# and wales cancer diagnosis rates
barCancerRateComparisonPracticeRegionWales(db, practiceID)

# test i
betsiCadwaladrHB7A1Test <- getbetsiCadwaladrHB7A1(db)
View(betsiCadwaladrHB7A1Test)
summary(betsiCadwaladrHB7A1Test)

# return diagnoed cancer patient percentage
DiagnosedCancerPercentage <- getPercentWithIndicator(db, 'CAN001') %>% 
                                    filter(!grepl('WAL', orgcode))
View(DiagnosedCancerPercentageFull)

# return diagnosed dementia patient percentage
DiagnosedDementiaPercentage <- getPercentWithIndicator(db, 'DM001') %>% 
  filter(!grepl('WAL', orgcode))
View(DiagnosedDementiaPercentage)



hywelDdaHB7A2Test <- getHywelDdaHB7A2(db)
diagnosedCancerPatients <- getdiagnosedCancerPercentage(db) %>% select(cancerrate = ratio, practiceid = orgcode)
test2 <- hywelDdaHB7A2Test %>% left_join(diagnosedCancerPatients, by = 'practiceid') #%>% summarise(mean(cancerrate))
summary(test2)

test22 <- test2 %>% summarise(mean(cancerrate, na.rm = TRUE))
View(test22)
summary(test22)


ratioACH <- QofAchievementRatio <- dbGetQuery(db, qq(
  'select ratio, orgcode
    from  qof_achievement
    where indicator like \'CAN001\';'))

ratioACH <- ratioACH %>% select(cancerrate = ratio, practiceid = orgcode)
View(ratioACH)
summary(ratioACH)
summedratio <- ratioACH %>% summarise(mean(cancerrate))
print(summedratio)

test2 <- lhb7A1 %>% left_join(ratioACH, by = 'practiceid')
View(test2)
#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
