# -----------------------------------------------
# Packages that require installation (uncomment to install)
#------------------------------------------------

#install.packages('tidyverse')

# -----------------------------------------------
# Load required source files
#------------------------------------------------

source("ConnectPostgreSQL.R")
  
# -----------------------------------------------
# Database connections and driver initialisation
#------------------------------------------------

# Load database driver (database_name)
database_driver <- connectDriver('PostgreSQL')

# Connect to DB (Driver, name, host address, port, database username)
database <- connectDB(database_driver,
                      'gp_practice_data',
                      'localhost', 5432,
                      'postgres')

# Connect to DB (Driver, name, host address, port, database username)
database <- connectPostgresLocalhost('gp_practice_data', 5432, 'postgres')
  

  
# Ensure connections are always closed on function exit


print("Hello R")
library(tidyverse)

# Check all tables in the database
dbListTables(db)

# check columns of address table
dbGetQuery(con, "
           select column_name, 
	         ordinal_position,
           data_type,
           character_maximum_length,
           numeric_precision
           from INFORMATION_SCHEMA.COLUMNS
           where table_schema = 'public'
           and table_name = 'address';")

# Query a dataset ####
#surgery <- dbGetQuery(con, "select distinct a.practiceid 
                      #from address a
                      #join gp_data_up_to_2015 b
                      #on a.practiceid = b.practiceid;")
#View(surgery)

#surgery <- sort(surgery$practiceid)

#total_rows <- dbGetQuery(con, "select count(*) from public.gp_data_up_to_2015")

# Disconnect database and driver
dbListConnections(database_driver)
disconnect_Database(database)
dbListConnections(database_driver)
