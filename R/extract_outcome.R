#' Extracts outcome column name
#'
#' Internal generic function to extract and return outcome names.
#' @param object an object to extract model from.
#' @param ... unused.
extract_outcome <- function(object, ...) UseMethod("extract_outcome")

#' @rdname extract_outcome
extract_outcome.mdl_ts <- function(object, ...) fabletools::response_vars(object)