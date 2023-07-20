#' Extract fitted residuals from models
#'
#' @param object a fitted arima or garch model
#' @param new_data a [tsibble][tsibble::tsibble-package] of univariate
#'      time series on which residuals are to be calculated.
#' @param outcome name of column to fit data to.
#' @param ... Options passed to methods.
#' @return a [tsibble][tsibble::tsibble-package] of predicted values and
#'      residuals.
#' @export
autoresid <- function(object, new_data, outcome = NULL, ...) {
    mdl <- extract_model(object)
    if (is.null(outcome)) {
        outcome <- extract_outcome(object)
    }
    switch(
        class(mdl),
        Arima = autoresid_arima_impl(mdl, new_data, outcome, ...),
        fGARCH = autoresid_fGARCH_impl(mdl, new_data, outcome, ...)
    )
}