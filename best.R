best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("data/outcome-of-care-measures.csv", na.strings = "Not Available")
    
    ## Check that state and outcome are valid
    
    if(!state %in% data$State) {
        stop("invalid state")
    }
    
    columns <- c("heart attack"=11, "heart failure" = 17, "pneumonia" = 23)
    if (!outcome  %in% names(columns)) {
        stop("invalid outcome")
    }
    
    ## breaking data down to only what we're interested in
    data <- data[c(2,7,columns[outcome])]
    ## Now getting the complete cases
    data <- na.omit(data)
    data <- subset(data, State == state)
    
    ## Sort the data - first by outcome, then by the name
    sorted <- arrange(data, data[,3], data[,2])
    
    ## Return hospital name in that state with the lowest 30-day death rate
    ## Convert the result to a character vector
    as.vector(head(sorted, 1)$Hospital.Name)
    
}