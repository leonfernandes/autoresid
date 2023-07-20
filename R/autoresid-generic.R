#' Extract fitted residuals from models
#'
#' @param object a fitted arima or garch model
#' @param new_data a [tsibble][tsibble::tsibble-package] of univariate
#'      time series on which residuals are to be calculated.
#' @param outcome name of column to fit data to
#' @param ... Options passed to methods.
#' @return a [tsibble][tsibble::tsibble-package] of predicted values and
#'      residuals.
#' @export
autoresid <- function(object, new_data, outcome, ...) {
    mdl <- extract_model(object)
    switch(
        class(mdl),
        Arima = autoresid_arima_impl(object, new_data, outcome, ... = ...),
        fGarch = autoresid_fGARCH_impl(object, new_data, outcome, ... = ...)
    )
}