# 2017 Day 1: Inverse Captcha
# NOTE: for both functions, if the input number is very large (as it is with the input
# provided by AoC), enter it as a character string

part_1 <- function(num) {
    number_string <- as.character(num)
    arr_string <- strsplit(number_string, "")[[1]]
    arr <- as.integer(arr_string)

    arr_len <- length(arr)

    total <- 0L
    for (i in seq_len(arr_len)) {
        j <- (i %% arr_len) + 1
        if (arr[[i]] == arr[[j]]) total <- total + arr[[i]]
    }

    total
}

part_2 <- function(num) {
    number_string <- as.character(num)
    arr_string <- strsplit(number_string, "")[[1]]
    arr <- as.integer(arr_string)

    arr_len <- length(arr)
    half <- arr_len / 2

    total <- 0L
    for (i in seq_len(arr_len)) {
        j <- i + half
        if (j > arr_len) {
            j <- (i + half) %% arr_len
        }
        if (arr[[i]] == arr[[j]]) total <- total + arr[[i]]
    }

    total
}

file_contents <- readLines(input)

cat("Part 1:", part_1(file_contents), "\n")
cat("Part 2:", part_2(file_contents), "\n")
