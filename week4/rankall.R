## Week 4 Assignment
## rankall that takes two arguments: an outcome name (outcome) and a hospital ranking
## (num). 
## The function reads the outcome-of-care-measures.csv file and returns a 2-column
## data frame containing the hospital in each state that has the ranking 
## specified in num.

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- readData("data/outcome-of-care-measures.csv")
    ## Check that state and outcome are valid

    columns <- c("heart attack"=11, "heart failure" = 17, "pneumonia" = 23)
    if (!isValid(outcome, names(columns))) {
        stop("invalid outcome")
    }
    
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
    
    ## breaking data down to only what we're interested in
    data <- data[c(2,7,columns[outcome])]
    ## Now getting the complete cases
    data <- na.omit(data)
    ## Now order the data - by state, value, hospital name
    data <- if (desc){
        data[order(data[,2], data[,3], data[,1]),]
    } else {
        data[order(data[,2], -data[,3], data[,1]),]
    }
    
    ## Split the data based on state - so each data.frame has the data in order
    split.data <- split(data, data$State)
    ## getting the rank data for each each
    state.data <- sapply(split.data, function(data) data[index,1])
    
    ## Get the names
    state.names <- names(state.data)

    ## create the final data.frame
    data.frame(hospital=unlist(state.data), state = state.names, 
               row.names = state.names)
    
}

isValid <- function(item, c = vector()){
    item %in% c
}

readData <- function(file = "data/outcome-of-care-measures.csv"){
    read.csv(file, na.strings = "Not Available")
}