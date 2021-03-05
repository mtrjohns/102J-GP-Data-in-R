#------------------------------------------------------------------------------
# PostgreSQL Database Helper Script
# author: Michael Johns
#------------------------------------------------------------------------------
#install.packages('GetoptLong')

library(GetoptLong) #For 'qq()' which allows substitution of vars in strings

# List available tables (database connection)
listTables <- function(dbConnection){
  print(dbListTables(dbConnection))
}

# Show table structure in console
listTableStructure <- function(db, table){
  DatabaseTableStructure <- dbGetQuery(db,
             qq('select column_name as name, ordinal_position as position,
            data_type as type, character_maximum_length as length,
            numeric_precision as precision
            from information_schema.columns
            where table_schema = \'public\' and
            table_name = \'@{table}\';'))
  
  cat(table, 'table, is structured as follows:\n', sep=' ')

  return(DatabaseTableStructure)
}

# Show table structure in TidyVerse View (database connection)
tidyTableStructure <- function(db, table){
  DatabaseTableStructure <- listTableStructure(db, table)
  View(DatabaseTableStructure)
}

# get table from the postgreSQL database and output in Tidyverse View
# Inputs: (Database connection, Table name, Row limit)
#-- Warning: Can take a long time with a large table and high limit value
getTable <- function(db, table, limit)
  dbGetQuery(db,qq(
    'select *
    from @{table}
    limit @{limit};'))

# get table from the postgreSQL database
# Inputs: (Database connection, Table name, Row limit)
#-- Warning: Can take a long time with a large table and high limit value
getTidyTable <- function(db, table, limit){
  table <- getTable(db, table, limit)
  View(table)
  return(table)
}