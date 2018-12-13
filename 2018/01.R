# 2018 Day 1: Chronal Calibration

read_input <- function(fname) {
    as.integer(readLines(fname))
}

part_1 <- function(input) {
    sum(input)
}

part_2 <- function(input) {
    frequency_vec <- 0L
    current_frequency <- 0L

    while (TRUE) {
        for (change in input) {
            current_frequency <- current_frequency + change
            if (current_frequency %in% frequency_vec) {
                return(current_frequency)
            }
            frequency_vec <- c(frequency_vec, current_frequency)
        }
    }
}

file_contents <- read_input(input)

print("Part 1:")
print(part_1(file_contents))

print("Part 2:")
print(part_2(file_contents))

