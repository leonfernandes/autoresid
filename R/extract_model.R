#' Extracts available models
#'
#' Internal generic function to extract and return objects that have been
#' registered with this package.
#' @param object an object to extract model from.
#' @param ... unused.
extract_model <- function(object, ...) UseMethod("extract_model")

#' @rdname extract_model
extract_model.Arima <- function(object, ...) object

#' @rdname extract_model
extract_model.Arima_fit_impl <- function(object, ...) object$models$model_1

#' @rdname extract_model
extract_model._Arima_fit_impl <- function(object, ...) object$fit$models$model_1

#' @rdname extract_model
extract_model.fGARCH <- function(object, ...) object

#' @rdname extract_model
extract_model._fGARCH <- function(object, ...) object$fit

#' @rdname extract_model
extract_model.mdl_ts <- function(object, ...) extract_model(object$fit, ...)

#' @rdname extract_model
extract_model.ARIMA <- function(object, ...) object$model

#' @rdname extract_model
extract_model.AR <-
    function(object, ...) {
        stats::makeARIMA(phi = object$fit$coef, theta = 0, Delta = 0)
    }