## Part 1 of Week 2 Quiz in R Programming 
## Calculates the mean of a pollutant (sulfate or nitrate) across a specified 
## list of monitors
pollutantmean <- function(directory, pollutant, id = 1:332) {
    csv_data <- c()
    for (index in id){
        if (index < 10){
            index <- paste("00", index, sep = "")
        } else if (index >= 10 & index < 100){
            index <- paste("0", index, sep = "")
        }
        file <- paste(directory, "/", index, ".csv", sep = "")
        all_raw_data <- read.csv(file)
        column_data <- all_raw_data[pollutant]
        filtered_data <- column_data[!is.na(column_data)]
        csv_data <- c(csv_data, filtered_data)
    }
    mean(csv_data)
}