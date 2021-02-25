# -----------------------------------------------
# Install and Load Packages (uncomment to install)
#------------------------------------------------

#install.packages('tidyverse')
library(tidyverse)

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
db <- connectDB(database_driver,
                      'gp_practice_data',
                      'localhost', 5432,
                      'postgres')

# -----------------------------------------------
# 
#------------------------------------------------
print("Hello R")


# Check all tables in the database
dbListTables(db)

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




# -----------------------------------------------
# Disconnect database and driver
#------------------------------------------------
dbListConnections(database_driver)
disconnect_Database(db, database_driver)
dbListConnections(database_driver)
