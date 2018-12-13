# 2018 Day 3: No Matter How You Slice It

# Set constants
SIDE <- 1000L

# Create overall fabric square
fabric <- matrix(seq_len(SIDE * SIDE), nrow = SIDE, ncol = SIDE, byrow = TRUE)

extract_elements <- function(text) {
    # For a given line in FILE, extract the ID number, the offset, and the dimensions
    # of each claim
    matches <- regexec(
                 pattern = "#(\\d{1,4}) @ (\\d{1,3}),(\\d{1,3}): (\\d{1,3})x(\\d{1,3})", 
                 text = text
               )
    as.integer(cbind(regmatches(text, matches)[[1]][-1]))
}

elements_raw <- readLines(input)

element_list <- lapply(elements_raw, extract_elements)
element_matrix <- matrix(unlist(element_list), ncol = 5, byrow = TRUE)
element_df <- as.data.frame(element_matrix)
names(element_df) <- c("id", "left", "top", "width", "height")

tally_squares <- function(element_df) {
    results <- matrix(0, nrow = SIDE, ncol = SIDE)
    for (r in seq_len(nrow(element_df))) {
        results[(1 + element_df$top[r]):(element_df$top[r] + element_df$height[r]),
                (1 + element_df$left[r]):(element_df$left[r] + element_df$width[r])] <-
                    results[(1 + element_df$top[r]):(element_df$top[r] + element_df$height[r]),
                            (1 + element_df$left[r]):(element_df$left[r] + element_df$width[r])] + 1
    }
    results 
}

square_results <- tally_squares(element_df)

part_1 <- function(squares) {
    sum(squares > 1)
}

part_2 <- function(element_df, squares) {
    for (r in seq_len(nrow(element_df))) {
        if (all(
            squares[(1 + element_df$top[r]):(element_df$top[r] + element_df$height[r]),
                    (1 + element_df$left[r]):(element_df$left[r] + element_df$width[r])] == 1
        )) {
            return (element_df$id[r])
        }
    }
}

print(part_1(square_results))
print(part_2(element_df, square_results))
