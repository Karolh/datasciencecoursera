## Part 3 of Quiz week 2 in R Programming 
## Used to get the correlation between nitrate and sulfate in the csv files provided
## The threshold indicates the number of complete cases in a file
## If the number of complete cases > than the threshold then perform the correlation 
## calculations and recode in a vector.
## Returns a vector of the correlation results for each ID/file 
## 
## Not sure how this is useful - but it's just an excercise
corr <- function(directory, threshold = 0){
    data <- c()
    files <- list.files(directory, full.names = TRUE)
    for (file in files){
        rawCsvData <- read.csv(file);
        goodCases <- getGoodCases(rawCsvData)
        totalGoodCases <- nrow(goodCases)
        if (totalGoodCases > threshold){
            sulfate <- goodCases["sulfate"]
            nitrate <- goodCases["nitrate"]
            result <- cor(sulfate, nitrate)
            data <- append(data, result[1])
       }
    }
    data
}

getGoodCases <- function(allCases){
    completeCases <- complete.cases(allCases)
    allCases[completeCases, ]
}

readDataFile <- function(directory, index) {
    file <- paste(directory, "/", formatC(index, width = 3, flag = "0"), ".csv", sep = "")
    read.csv(file)
}