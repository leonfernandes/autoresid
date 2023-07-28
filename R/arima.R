#' @rdname autoresid
#' @export
autoresid.arima <-
    function(object, new_data, outcome, ...) {
        if (!inherits(object, "arima")) rlang::abort("Not arima object.")
        phi <- object$phi
        theta <- object$theta
        delta <- object$delta
        len_delta <- length(delta)
        len_phi <- length(phi)
        outcome <- rlang::enquo(outcome)
        # Extract outcome column
        ret <- new_data |> dplyr::pull(!!outcome)
        ret <- c(rep(0, len_delta + len_phi), ret)
        # Differencing
        if (len_delta) {
            ret <- stats::filter(ret, c(1, -delta), sides = 1) |>
                stats::na.omit()
        }
        # Apply Phi
        if (len_phi) {
            ret <- stats::filter(ret, c(1, -phi), sides = 1) |>
                stats::na.omit()
        }
        # Apply Theta
        if (length(theta)) {
            ret <- stats::filter(ret, -theta, method = "recursive")
        }
        new_data |>
            dplyr::mutate(".resid" = ret) |>
            dplyr::select(-!!outcome) |>
            tsibble::new_tsibble(class = "autoresid_ts")
    }