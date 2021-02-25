#install.packages('RPostgreSQL')

library(RPostgreSQL)

# Load the PostgreSQL server driver
drv <- dbDriver('PostgreSQL')

# Connect to gp_practice_data PostgreSQL database
connectDB <- function(inDbName, inPort, inHost)
{
  # Connect to gp_practice_data PostgreSQL database
  # Warning: .rs.askForPassword is a Rstudio only function
  #-- Connection error could occur: Connection refused (Windows 10 x64)
  #-- Removal of previous installation of PostgreSQL versions
  #-- from C:\Program Files\PostgreSQL
  #-- and C:\Users\<username>\AppData\Roaming\pgAdmin
  #-- corrected connection refused issues
  con <- dbConnect(drv, inDbName,
                   host=inHost, port=inPort,
                   user='postgres',
                   password=.rs.askForPassword('Database Password:'))
  
  # close db connection after function call exits
  on.exit(dbDisconnect(con))

  return(con)
}

db <- connectDB('gp_practice_data', 5432, 'localhost')

# Check all tables in the database
dbListTables(con)

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
dbDisconnect(db)

# Disconnect and unload PostgreSQL driver
disconnect_Database <- function(connection, driver) {
  dbDisconnect(connection)
  dbListConnections(driver)
  dbUnloadDriver(driver)
}
disconnect_Database(db, drv)
dbListConnections(drv)
