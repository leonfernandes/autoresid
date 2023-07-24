#' Extract fitted residuals from models
#'
#' @param object a fitted arima or garch model
#' @param new_data a [tsibble][tsibble::tsibble-package] of univariate
#'      time series on which residuals are to be calculated.
#' @param outcome name of column to fit data to.
#' @param ... Options passed to methods.
#' @return a [tsibble][tsibble::tsibble-package] of fitted residuals.
#' @export
autoresid <- function(object, new_data, outcome = NULL, ...) {
    UseMethod("autoresid")
}

#' @rdname autoresid
#' @export
autoresid.default <-
    function(object, new_data, outcome = NULL, ...) {
        mdl <- extract_model(object)
        if (is.null(outcome)) {
            outcome <- extract_outcome(object)
        }
        autoresid(mdl, new_data, outcome, ...)
    }

#' @rdname autoresid
#' @export
autoresid.Arima <-
    function(object, new_data, outcome = NULL, ...) {
        autoresid_arima_impl(object, new_data, outcome, ...)
    }

#' @rdname autoresid
#' @export
autoresid.fGARCH <-
    function(object, new_data, outcome = NULL, ...) {
        if (is.null(outcome)) rlang::abort("outcome should not be `NULL`.")
        autoresid_fgarch_impl(object, new_data, outcome, ...)
    }