source("ConnectPostgreSQL.R")
  
#install.packages('tidyverse')

# Connect to DB (Database name, port number, host address, database username)
db <- connectDB('gp_practice_data', 5432, 'localhost', 'postgres')

print("Hello R")
library(tidyverse)

 # query a dataset ####
surgery <- dbGetQuery(con, "select distinct a.practiceid 
                      from address a
                      join gp_data_up_to_2015 b
                      on a.practiceid = b.practiceid;")
View(surgery)

surgery <- sort(surgery$practiceid)

total_rows <- dbGetQuery(con, "select count(*) from public.gp_data_up_to_2015")


