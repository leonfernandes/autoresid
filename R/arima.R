#' @rdname autoresid
#' @export
autoresid._Arima_fit_impl <- function(object, new_data, ...) {
    object <- object$fit$models$model_1
    autoresid(object, new_data)
}

#' @rdname autoresid
#' @export
autoresid.Arima <- function(object, new_data, ...) {
    model <- object$model
    len_delta <- length(model$Delta)
    len_phi <- length(model$phi)
    # Extract first column
    ret <- new_data[, 1][[1]]
    ret <- c(rep(0, len_delta + len_phi), new_data)
    # Differencing
    if (len_delta) {
        ret <- stats::filter(ret, c(1, -model$Delta), sides = 1) |>
            stats::na.omit()
    }
    # Apply Phi
    if (len_phi) {
        ret <- stats::filter(ret, c(1, -model$phi), sides = 1) |>
            stats::na.omit()
    }
    # Apply Theta
    if (length(model$theta)) {
        ret <- stats::filter(ret, -model$theta, method = "recursive")
    }
    tibble::new_tibble(
        tibble::tibble(".resid" = ret),
        class = "autoresid_tbl"
    )
}
