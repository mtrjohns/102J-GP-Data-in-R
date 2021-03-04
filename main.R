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
# Database tables information and layout queries
#------------------------------------------------------------------------------

# List available tables from connected database
gpTablesConsole(db)
# List available tables in Tidyverse View
gpTablesTidy(db)

# Output table structures into Console
gpAddressTableStructureConsole(db)
gpBnfTableStructureConsole(db)
gpChemSubstanceTableStructureConsole(db)
gpGpDataUpTo2015TableStructureConsole(db)
gpQofAchievementTableStructureConsole(db)
gpQofIndicatorTableStructureConsole(db)

# output table structures using Tidyverse
address <- gpAddressTableTidy(db)
bnf <- gpBnfTableTidy(db)
chem_substance <- gpChemSubstanceTableTidy(db)
gp_data_up_to_2015 <- gpGpDataUpTo2015TableTidy(db)
qof_achievement <- gpQofAchievementTableTidy(db)
qof_indicator <- gpQofIndicatorTableTidy(db)

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

practice_id <- userPracticeIDInput()



#What five drugs does the practice spend the most money on?
# drugs list for the specified practice.
drugs <- dbGetQuery(db, qq('
    select * from gp_data_up_to_2015
    where practiceid = \'@{user_practice_id}\''))


Top_5_spendings <- drugs %>% 
  distinct() %>% #removes duplicates
  filter(str_detect(bnfname, 'Tab')==TRUE) %>% #detects if string contains space
  group_by(bnfname) %>% 
  summarise(sum_actcost=sum(actcost)) %>% # calculating the mean of cost for drugs for the selected practice.
  arrange(desc(sum_actcost)) %>% head(5) #selecting 5 elements this number can be changed to 10 for top 10 spendings on drugs.
#descending for Top 5 , for 5 least expensive ascending arranging would be rquired 
cat('\nThe top 5 drugs in terms of spendings for practice, ', user_practice_id,
    ', were:\n', sep='')
Top_5_spendings %>% gt() %>%
  tab_header(title = md("Top 5 drugs in terms of spendings for GP Practice")) %>%
  cols_label(
    bnfname = "Name",
    sum_actcost = "Total Money Spent"
  )






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
