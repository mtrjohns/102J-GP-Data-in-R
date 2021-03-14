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
# User selects Practice ID
#------------------------------------------------------------------------------

practiceID <- userPracticeIDInput()
# Get top 5 prescribed drugs for a specific practice
topFivePrescribedDrugsTest <- getTopFiveDrugSpendSinglePractice(db, practiceID)

# Show Comparison graph of practice, practice's region(by health board) 
# and wales cancer diagnosis rates
barCancerRateComparisonPracticeRegionWales(db, practiceID)

# Visualisation of spend on medication per patient by practice across Wales
scatterPlotPerPatientSpend(db)

getCorDiagnosedCanDiabDemenHyperAndTotalSpend(db)

getCorDiagnosedCanSmokAsthObesAndTotalSpend(db)

getCorAllDiagnosedTotalSpend(db)

getCorAllDiagnosedTotalSpendRegion(db)

#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
