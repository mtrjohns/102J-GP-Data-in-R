#install.packages('tidyverse')
#install.packages('RPostgreSQL')


print("Hello R")
library(tidyverse)
library(RPostgreSQL)

# Load the PostgreSQL server driver
drv <- dbDriver('PostgreSQL')

# Allow auto disconnection of database on exit
#connectToGP <- function()
#{
# Connect to gp_practice_data PostgreSQL database
# Warning: .rs.askForPasword is a Rstudio only function
#-- Connection error could occur: Connection refused (Windows 10 x64)
#-- Removal of previous installation of PostgreSQL versions
#-- from C:\Program Files\PostgreSQL
#-- and C:\Users\<username>\AppData\Roaming\pgAdmin
#-- corrected connection refused issues
con <- dbConnect(drv, dbname='gp_practice_data',
                 host='localhost', port='5432',
                 user='postgres', password=.rs.askForPassword('Password:'))

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

 # query a dataset ####
surgery <- dbGetQuery(con, "select distinct a.practiceid 
                      from address a
                      join gp_data_up_to_2015 b
                      on a.practiceid = b.practiceid;")
View(surgery)

surgery <- sort(surgery$practiceid)

total_rows <- dbGetQuery(con, "select count(*) from public.gp_data_up_to_2015")

dbDisconnect(con)
dbListConnections(drv)
dbUnloadDriver(drv)
