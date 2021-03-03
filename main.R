#------------------------------------------------------------------------------
# Install and Load Packages (uncomment to install)
#------------------------------------------------------------------------------

#install.packages('tidyverse')
#install.packages('GetoptLong')
#install.packages('RPostgreSQL')
library(tidyverse)

#------------------------------------------------------------------------------
# Load required source files
#------------------------------------------------------------------------------
install.packages("gt")
library(gt)             # For demonstration in table 
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
# Table information and layout queries
#------------------------------------------------------------------------------

# List available tables from connected database
gpTables(db)
# List available tables in Tidyverse View
gpTablesTidy(db)

# output all gp practice database table structures to console
gpAllTablesStructure(db)

# output qof_indicator Table structure using Tidyverse
gpAddressTableTidy(db)
gpBnfTableTidy(db)
gpChemSubstanceTableTidy(db)
gpGpDataUpTo2015TableTidy(db)
gpQofAchievementTableTidy(db)
gpQofIndicatorTableTidy(db)

# output gp_data_up_to_2015 structure using Tidyverse
tidyTableStructure('gp_data_up_to_2015')

#------------------------------------------------------------------------------
# User selects Practice ID
#------------------------------------------------------------------------------
qof_indicator <- dbGetQuery(db, '
    select column_name as name, ordinal_position as position,
           data_type as type, character_maximum_length as length,
           numeric_precision as precision
    from information_schema.columns
    where table_schema = \'public\' and
          table_name = \'qof_indicator\';')

user_practice_id <- userPracticeIDInput()










# check columns of address table
dbGetQuery(db, "
           select column_name, 
	         ordinal_position,
           data_type,
           character_maximum_length,
           numeric_precision
           from INFORMATION_SCHEMA.COLUMNS
           where table_schema = 'public'
           and table_name = 'address';")

# Query a dataset ####
surgery <- dbGetQuery(db, "select distinct a.practiceid 
                      from address a
                      join gp_data_up_to_2015 b
                      on a.practiceid = b.practiceid;")
View(surgery)

surgery <- sort(surgery$practiceid)

total_rows <- dbGetQuery(db, "select count(*) from public.gp_data_up_to_2015")



#------------------------------------------------------------------------------
# Disconnect database and driver
#------------------------------------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
