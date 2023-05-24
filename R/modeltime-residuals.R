#' Extract fitted residuals from arima models
#'
#' @inheritParams forecast::residuals.forecast
#' @export
residuals._Arima_fit_impl <- function(
    object, type = c("innovation", "response", "regression"), h = 1, ...
) {
    stats::residuals(object$fit$models$model_1, type, h, ...) |>
        (\(.) tibble::tibble(.resid = .))()
}