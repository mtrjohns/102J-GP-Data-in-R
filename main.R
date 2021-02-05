#install.packages('tidyverse')
#install.packages('RPostgreSQL')


print("Hello R")
library(RPostgreSQL)
library(tidyverse)

# PostgreSQL server driver
drv <- dbDriver('PostgreSQL')

# Connect to gp_practice_data PostgreSQL database
#-- Error: Connection refused (Windows 10 x64)
#-- Removal of previous installation of PostgreSQL versions
#-- from C:\Program Files\PostgreSQL
#-- and C:\Users\<username>\AppData\Roaming\pgAdmin
#-- corrected connection refused issues
con <- dbConnect(drv, dbname='gp_practice_data', host='localhost', port='5432',
                 user='postgres', password=.rs.askForPassword('Password:'))
