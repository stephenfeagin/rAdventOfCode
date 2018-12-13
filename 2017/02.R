# 2017 Day 2: Corruption Checksum

MAT = read.delim(input, header = FALSE)

part_1 <- function(mat) {
    total <- 0L
    for (r in seq_len(nrow(mat))) {
        low <- min(mat[r, ])
        high <- max(mat[r, ])
        difference <- high - low
        total <- total + difference
    }

    total
}

part_2 <- function(mat) {
    total <- 0L
    for (r in seq_len(nrow(mat))) {
        combo <- combn(mat[r, ], 2, simplify = FALSE)
        row_quotient <- sum(vapply(combo, function(x) {
            if (x[[1]] %% x[[2]] == 0) {
                return(x[[1]] / x[[2]])
            } else if (x[[2]] %% x[[1]] == 0) {
                return(x[[2]] / x[[1]])
            } else {
                return(0)
            }
        }, 0))
        total <- total + row_quotient
    }

    total
}

print("Part 1:")
print(part_1(MAT))

print("Part 2:")
print(part_2(MAT))
