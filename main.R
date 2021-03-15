# -----------------------------------------------------------------------------
# gp_practice_data PostgreSQL Database Output Script
#
# author: Michael Johns
#
# about: This script allows the user to enter a GP Practice ID to console.
#        There are several functions available relating to the gp_practice_data 
#        database.
#
# Required Files: "ConnectPostgreSQL.R"
#                 "PostgreSQLHelper.R"
#                 "GPData2015Helper.R"
#
# Required PostgreSQL Database: gp_practice_data
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
# User selects Practice ID
#------------------------------------------------------------------------------

# User input line to populate PracticeID
# Input entry in the console window
practiceID <- userPracticeIDInput()

# Get top 5 prescribed drugs for a specific practice
# Note: Requires populated practiceID
topFivePrescribedDrugs <- getTopFiveDrugSpendSinglePractice(db, practiceID)

#------------------------------------------------------------------------------
# Comparison and Correlation Plots
#
# All below functions run independantly of each other
#
# Note: As these are live updates, each executed function can take a while
#       to populate details (Approx 1-2 minutes)
#------------------------------------------------------------------------------

# Show Comparison graph of practice, practice's region(by health board) 
# and wales cancer diagnosis rates
barCancerRate <- barCancerRateComparisonPracticeRegionWales(db, practiceID)

# Visualisation of spend on medication per patient by practice across Wales
# Colour coded by health board
scatterPerPatientSpend <- scatterPlotPerPatientSpend(db)

# Correlation between each Practice total spend on medication and diseases:
#   Cancer, Diabetes, Dementia and Hypertension
correlationCanDiabDemenHyp <- getCorDiagnosedCanDiabDemenHyperAndTotalSpend(db)

# Correlation between each Practice total spend on medication and diseases:
#   Cancer, Smoking, Asthma and Obesity
correlationCanSmokAsthObesgetCor <- DiagnosedCanSmokAsthObesAndTotalSpend(db)

# Correlation between each Practice total spend on medication
# Cancer, Diabetes, Dementia, Hypertension Smoking, Asthma and Obesity
correlationAll <- getCorAllDiagnosedTotalSpend(db)

# Correlation between each Region's total spend on medication and diseases:
#   Cancer, Diabetes, Dementia, Hypertension Smoking, Asthma and Obesity
correlationAllRegion <- getCorAllDiagnosedTotalSpendRegion(db)

#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
