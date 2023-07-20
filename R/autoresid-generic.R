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
    UseMethod("autoresid")
}

#' @rdname autoresid
#' @export
autoresid.default <-
    function(object, new_data, outcome, ...) {
        mdl <- NULL
        try(
            mdl <- extract_model(object)
        )
        if (is.null(mdl)) rlang::abort("No registered method for `object`.")
        if (is.null(outcome)) {
            outcome <- extract_outcome(object)
        }
        autoresid(mdl, new_data, outcome, ...)
    }

#' @rdname autoresid
#' @export
autoresid.Arima <-
    function(object, new_data, outcome, ...) {
        autoresid_arima_impl(object, new_data, outcome, ...)
    }

#' @rdname autoresid
#' @export
autoresid.fGARCH <-
    function(object, new_data, outcome, ...) {
        autoresid_fgarch_impl(object, new_data, outcome, ...)
    }