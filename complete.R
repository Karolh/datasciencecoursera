complete <- function(directory, id = 1:332) {
    data <- matrix(nrow = length(id), ncol = 2 )
    rowCount <- 1
    for (index in id){
        allCases <- readDataFile(directory, index)
        number <- numberOfGoodCases(allCases)
        
        data[rowCount, 1] <- index
        data[rowCount, 2] <- number
        rowCount <- rowCount + 1
    }
    colnames(data) <- c("id", "nobs")
    data
}

numberOfGoodCases <- function(allCases){
    completeCases <- complete.cases(allCases)
    goodCases <- allCases[completeCases, ]
    nrow(goodCases)
}

readDataFile <- function(directory, index) {
    if (index < 10){
        index <- paste("00", index, sep = "")
    } else if (index >= 10 & index < 100){
        index <- paste("0", index, sep = "")
    }
    file <- paste(directory, "/", index, ".csv", sep = "")
    read.csv(file)
}