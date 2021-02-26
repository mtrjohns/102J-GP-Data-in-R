# -----------------------------------------------
# PostgreSQL Database Helper Script
# author: Michael Johns
#------------------------------------------------

library(GetoptLong) #For 'qq()' which allows substitution of vars in strings

# List available tables (database connection)
listTables <- function(dbConnection){
  print(dbListTables(dbConnection))
}

listTableStructure <- function(table){
  tableStructure <- dbGetQuery(db,
             qq('select column_name as name, ordinal_position as position,
            data_type as type, character_maximum_length as length,
            numeric_precision as precision
            from information_schema.columns
            where table_schema = \'public\' and
            table_name = \'@{table}\';'))
  
  cat(table, 'table, is structured as follows:\n', sep=' ')
  return(tableStructure)

}

tidyTableStructure <- function(table){
  tableStructure <- listTableStructure(table)
  View(tableStructure)
}