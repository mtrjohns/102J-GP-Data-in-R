# -----------------------------------------------------------------------------
# gp_up_to_2015 Input Validation Helper Script
#
# author: Michael Johns
#
# about: This script allows the user to enter a GP Practice ID to console
#        and validates data matches the expected format (W#####)
#------------------------------------------------------------------------------

# take a GP Practice ID and Validate Input
# format in the style of W01234 (character, 5 integers)
# Returns a Bool
practiceIdValidation <- function(gpPracticeID){
  isValid <- FALSE
  
  # Check input is as expected (Upper case character, 5 integers, W#####)
  if(grepl('^W[0-9]{5}$', gpPracticeID)){
    isValid <- TRUE
  }else{
    cat("Validation check failed. ")
  }

  return(isValid)
}

# Ask user to enter a practice ID from console and validate input
userPracticeIDInput <- function(){
  isValid = FALSE
  
  # read user input from console
  practiceID <- readline(prompt="Enter Practice ID (W#####): ")
  
  # validate console input matches format W#####
  isValid <- practiceIdValidation(practiceID)
  
  if(isValid){
    cat("The GP Practice Id has been set to: ")
    return(practiceID)
  }
  else
  {
    cat("The GP Practice ID '", practiceID,
        "' is not valid, Please try again (example ID: W00001).", sep='')
  }
}


