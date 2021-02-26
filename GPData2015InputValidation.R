# -----------------------------------------------
# gp_up_to_2015 Input Validation Helper Script
# author: Michael Johns
#------------------------------------------------

# take a GP Practice ID and Validate Input
# format in the style of W01234 (character, 5 integers)
# Returns a Bool
practiceIdValidation <- function(gpPracticeID){
  isValid <- FALSE
  
  # Check input is as expected (character, 5 integers)
  if(grepl('^W[0-9]{5}$', gpPracticeID)){
    isValid <- TRUE
  }else{
    cat("The GP Practice ID", gpPracticeID,
        " is not valid, Please try again (example ID: W00001).")
  }
  if (!valid_id){
    stop('\nHalting: the practice ID was not valid, no data will be found.')
  }
  return(isValid)
}


valid_id <- FALSE
user_practice_id <- readline('Enter a practice ID (Wxxxxx):')
if (grepl('^W[0-9]{5}$', user_practice_id)){
  valid_id <- TRUE
} else {
  cat('The entered practice ID (', user_practice_id,
      ') is not valid, please try again:) \n', sep='')
}
if (!valid_id){
  stop('Halting: the practice ID was not valid, no data will be found:(')
}