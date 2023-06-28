#' Autoresid methods for ARIMA models
#'
#' @inheritParams autoresid
#' @rdname autoresid_arima
#' @export
autoresid._Arima_fit_impl <-
    function(object, new_data, outcome, ...) {
        object <- object$fit
        autoresid(object, new_data, outcome, ...)
    }

#' @rdname autoresid_arima
#' @export
autoresid.Arima_fit_impl <-
    function(object, new_data, outcome, ...) {
        object <- object$models$model_1
        autoresid(object, new_data, outcome, ...)
    }

#' @rdname autoresid_arima
#' @export
autoresid.Arima <-
    function(object, new_data, outcome, ...) {
        model <- object$model
        len_delta <- length(model$Delta)
        len_phi <- length(model$phi)
        # Extract outcome column
        ret <- new_data %>% dplyr::pull(!!rlang::enquo(outcome))
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
        tibble::new_tibble(
            tibble::tibble(".resid" = ret),
            class = "autoresid_tbl"
        )
    }