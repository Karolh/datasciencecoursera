best <- function(state, outcome, index = 1, desc = TRUE) {
    ## Read outcome data
    data <- readData("data/outcome-of-care-measures.csv")
    
    ## Check that state and outcome are valid
    
    if(!isValid(state, data$State)) {
        stop("invalid state")
    }
    
    columns <- c("heart attack"=11, "heart failure" = 17, "pneumonia" = 23)
    if (!isValid(outcome, names(columns))) {
        stop("invalid outcome")
    }
    
    ## breaking data down to only what we're interested in
    data <- data[c(2,7,columns[outcome])]
    ## Now getting the complete cases
    data <- na.omit(data)
    data <- subset(data, State == state)
    
    ## Sort the data - first by outcome, then by the name
    
    sorted <- if (desc) {
        data[order(data[,3], data[,1]),]
    } else {
        data[order(-data[,3], -data[,1]),]
    }
    
    ## Return hospital name in that state with the lowest 30-day death rate
    ## Convert the result to a character vector
    as.vector(sorted[index,]$Hospital.Name)
    
}

## This returns the hostpital for the supplied state and and rank
## The rank can be "best", "worst" or a number
## The outcome can be one of:
##              heart attack 
##              heart failure
##              pneumonia
rankhospital <- function(state, outcome, num = "best") {
    desc <- TRUE
    index <- 1
    if (num == "best"){
        index <- 1
    } else if (num == "worst"){
        index <- 1
        desc <- FALSE
    } else {
        index <- num
    }
    
    best(state, outcome, index, desc)

    ## Retrun hospital name in that state with the given rank 
    ## 30-day death rate
}

isValid <- function(item, c = vector()){
    item %in% c
}

readData <- function(file = "data/outcome-of-care-measures.csv"){
    read.csv(file, na.strings = "Not Available")
}