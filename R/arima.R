#' Autoresid implementation for Arima models
#'
#' @inheritParams autoresid
#' @rdname autoresid_arima
#' @export
autoresid_arima_impl <-
    function(object, new_data, outcome, ...) {
        model <- object$model
        len_delta <- length(model$Delta)
        len_phi <- length(model$phi)
        outcome <- rlang::enquo(outcome)
        # Extract outcome column
        ret <- new_data |> dplyr::pull(!!outcome)
        ret <- c(rep(0, len_delta + len_phi), ret)
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
        new_data |>
            dplyr::mutate(".resid" = ret) |>
            dplyr::select(-!!outcome) |>
            tsibble::new_tsibble(class = "autoresid_ts")
    }