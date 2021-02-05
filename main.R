#install.packages('tidyverse')
#install.packages('RPostgreSQL')


print("Hello R")
library(RPostgreSQL)
library(tidyverse)

# PostgreSQL server driver
drv <- dbDriver('PostgreSQL')

# Connect to gp_practice_data PostgreSQL database
#-- Error: Connection refused
#-- Removal ofprevious installation of postgreSQL versions
#-- from program files/postgres and appdata/roaming/pgadmin
#-- corrected connection refused issues
con <- dbConnect(drv, dbname='gp_practice_data', host='localhost', port='5432',
                 user='postgres', password=.rs.askForPassword('Password:'))
