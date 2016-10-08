complete <- function(directory, id = 1:332) {
    data <- data.frame(nrow = length(id), ncol = 2 )
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
    file <- paste(directory, "/", formatC(index, width = 3, flag = "0"), ".csv", sep = "")
    read.csv(file)
}