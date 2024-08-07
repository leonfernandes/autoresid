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
    stopifnot(inherits(new_data, "tbl_ts") == TRUE)
    UseMethod("autoresid")
}

#' @rdname autoresid
#' @export
autoresid.default <-
    function(object, new_data, outcome = NULL, ...) {
        rlang::abort(
            glue::glue("Object of class {class(object)} is not registered.")
        )
    }