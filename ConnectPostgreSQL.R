#------------------------------------------------------------------------------
# PostgreSQL Database Connection Wrapper Script
# author: Michael Johns
#------------------------------------------------------------------------------

#install.packages('RPostgreSQL')

library(RPostgreSQL)

# Load database driver (driver)
connectDriver <- function(inDriver){
  drv <- dbDriver(inDriver)
  return(drv)
}

# Connect to database
# (Driver, name, host address, port, database username)
connectDB <- function(inDriver, inDbName, inHost, inPort, inUser)
{
  # Warning: .rs.askForPassword is a Rstudio only function
  #-- Connection error could occur: Connection refused (Windows 10 x64)
  #-- Removal of previous installation of PostgreSQL versions
  #-- from C:\Program Files\PostgreSQL
  #-- and C:\Users\<username>\AppData\Roaming\pgAdmin
  #-- corrected connection refused issues
  
  cat("Attempting a new connection to the database: ", inDbName, "... ")
  
  # Connect to PostgreSQL database
  con <- dbConnect(inDriver, inDbName,
                   host=inHost, port=inPort,
                   user=inUser,
                   password=.rs.askForPassword('Database Password:'))

  # Check if connection was successful to the PostgreSQL database server
  if(isPostgresqlIdCurrent(con) == TRUE)
  {
    cat("Connection to ", inDbName, " was Successful.")
  }
  
  return(con)
}


# Connect to PostgreSQL database on a localhost connection
# (database name, database port, database username)
#connectPostgresLocalhost <- function(inDbName, inPort, inUser)
#{
#  database_driver <- connectDriver('PostgreSQL')
#  
#  database <- connectDB(database_driver, inDbName,
#                        'localhost', inPort,
#                        inUser)
#  return(database, database_driver)
#}

# Disconnect and unload PostgreSQL driver
# (Database connection, PostgreSQL driver)
disconnect_Database <- function(connection, driver) {
  dbDisconnect(connection)
  dbListConnections(driver)
  dbUnloadDriver(driver)
}
