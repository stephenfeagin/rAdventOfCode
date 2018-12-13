#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(optparse))

option_list = list(
    make_option(c("-f", "--file"), action = "store", default = NA, type = "character",
                help = "Path to puzzle input file (.txt)"),
    make_option(c("-q", "--quiet"), action = "store_true", default = FALSE,
                help = "Suppress messages?")
)

parser <- OptionParser(usage = "%prog <year> <day> [options]", option_list = option_list)
arguments <- parse_args(parser, positional_arguments = 2)

# Argument validation -------------------------------------------------------------------
available_years <- c(2017, 2018)

if (arguments$args[1] %in% available_years) {
    year <- arguments$args[1]
} else {
    stop("Invalid <year> argument. You provided ", arguments$args[1], ".\n",
         "\t<year> must be one of the following: ", 
         paste(available_years, collapse = ", "))
}

if (as.integer(arguments$args[2]) <= 25L) {
    day <- ifelse(nchar(arguments$args[2]) == 1,
                  paste0("0", arguments$args[2]),
                  arguments$args[2])
} else {
    stop("Invalid <day> argument. You provided ", arguments$args[2], ".\n",
         "\t<day> must be an integer between 1 and 25, inclusive")
}

if (is.na(arguments$options$file)) {
    input <- file.path(paste0("input-", year), paste0("day_", day, ".txt"))
    if(!isTRUE(arguments$options$quiet)) {
        message("No file provided. Attempting to locate input file ", input)
    }
} else {
    input <- arguments$options$file
}
if (!file.exists(input)) {
    stop("File \"", input, "\" does not exist")
}
if (file.access(input, mode = 4) != 0) {
    stop("You do not have read privileges on file \"", input, "\"")
}

module <- file.path("R", year, paste0(day, ".R"))
if (!file.exists(module)) stop("No R solution file for ", year, " / ", day)

source(module)

