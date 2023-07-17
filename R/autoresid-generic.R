#' Extract fitted residuals from models
#'
#' @param object a fitted arima or garch model
#' @param new_data a [tsibble][tsibble::tsibble-package] of univariate
#'      time series on which residuals are to be calculated.
#' @param outcome name of column to fit data to
#' @param ... Currently unused.
#' @return a [tsibble][tsibble::tsibble-package] of predicted values and
#'      residuals.
#' @export
autoresid <- function(object, new_data, outcome, ...) {
    UseMethod("autoresid")
}