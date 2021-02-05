install.packages('tidyverse')
install.packages('RPostgreSQL')


print("Hello R")
library(RPostgreSQL)
library(tidyverse)

# PostgreSQL server driver
drv <- dbDriver('PostgreSQL')

con <- dbConnect(drv, dbname='gp_practice_data', host='localhost', port='5432',
                 user='postgres', password=.rs.askForPassword('Password:'))
