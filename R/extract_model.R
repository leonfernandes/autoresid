#' Extracts available models
#'
#' Internal generic function to extract and return objects that have been
#' registered with this package.
#' @param object an object to extract model from.
#' @param ... unused.
extract_model <- function(object, ...) UseMethod("extract_arima")

#' @rdname extract_model
extract_model.Arima <- function(object, ...) object

#' @rdname extract_model
extract_model.Arima_fit_impl <- function(object, ...) object$models$model_1

#' @rdname extract_model
extract_model._Arima_fit_impl <- function(object, ...) object$fit$models$model_1

#' @rdname extract_model
extract_model.fGarch <- function(object, ...) object

#' @rdname extract_model
extract_model._fGarch <- function(object, ...) object$fit