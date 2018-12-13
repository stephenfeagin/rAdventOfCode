#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(optparse))

option_list = list(
    make_option(c("-y", "--year"), action = "store", default = 2018, type = "integer",
                help = "Puzzle year (integer)"),
    make_option(c("-d", "--day"), action = "store", default = NA, type = "integer",
                help = "Puzzle day (integer between 1 and 25, inclusive)"),
    make_option(c("-f", "--file"), action = "store", default = NA, type = "character",
                help = "Path to puzzle input file (.txt)"),
    make_option(c("-q", "--quiet"), action = "store_true", default = FALSE,
                help = "Suppress messages?")
)

parser <- OptionParser(
    usage = "%prog (-y YEAR | --year=YEAR) (-d DAY | --day=DAY) [options]", 
    option_list = option_list
)
opts <- parse_args(parser)

# Argument validation -------------------------------------------------------------------
available_years <- c(2017, 2018)

if (opts$year %in% available_years) {
    year <- opts$year
} else {
    stop("Invalid <year> argument. You provided ", opts$year, ".\n",
         "\t<year> must be one of the following: ", 
         paste(available_years, collapse = ", "))
}

if (opts$day <= 25L) {
    day <- ifelse(nchar(opts$day) == 1,
                  paste0("0", opts$day),
                  opts$day)
} else {
    stop("Invalid <day> argument. You provided ", opts$day, ".\n",
         "\t<day> must be an integer between 1 and 25, inclusive")
}

if (is.na(opts$file)) {
    input <- file.path(paste0("input-", year), paste0("day_", day, ".txt"))
    if(!isTRUE(opts$quiet)) {
        message("No file provided. Attempting to locate input file ", input)
    }
} else {
    input <- opts$file
}
if (!file.exists(input)) {
    stop("File \"", input, "\" does not exist")
}
if (file.access(input, mode = 4) != 0) {
    stop("You do not have read privileges on file \"", input, "\"")
}

module <- file.path(year, paste0(day, ".R"))
if (!file.exists(module)) stop("No solution file for ", year, " / ", day)

source(module)

