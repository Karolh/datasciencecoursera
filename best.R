best <- function(state, outcome) {
    ## Read outcome data
    
    ## Check that state and outcome are valid
    outcomes <- c("heart attack"=11, "heart failure" = 17, "pneumonia" = 23)
    if (!outcome  %in% names(outcomes)){
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the lowest 30-day death
    ## rate
}