#' @rdname autoresid
#' @export
autoresid.garch <-
    function(object, new_data, outcome, ...) {
        if (!inherits(object, "garch")) rlang::abort("Not garch object.")
        omega <- object$omega
        alpha <- object$alpha
        beta <- object$beta
        delta <- 2
        deltainv <- 1 / delta

        outcome <- rlang::enquo(outcome)
        # Extract outcome column
        y <- dplyr::pull(new_data, !!outcome)
        ydelta <- abs(y)^delta
        len_y <- vctrs::vec_size(y)
        vec_c <- ccoef(omega, alpha, beta, len_y)
        h <-
            vec_c[1] +
            sapply(
                2:len_y, \(i) sum(vec_c[2:i] * ydelta[i:2 - 1])
            )
        h <- c(vec_c[1], h)
        z <- y / (h^deltainv)
        new_data |>
            dplyr::mutate(".resid" = z) |>
            dplyr::select(-!!outcome) |>
            tsibble::new_tsibble(class = "autoresid_ts")
    }

#' Calculate Recursion Polynomial
#'
#' Refers to recursion 6.1 in Davis and Wan (2020).
#' @inheritParams autoresid_garch_impl
#' @param order a positive integer. The order of the polynomial to be returned.
#' @returns numeric vector consisting of coefficients of the conditional
#'       variance recursion polynomial.
#' @noRd
ccoef <-
    function(omega, alpha, beta, order) {
        ret <- numeric(order)
        n_alpha <- vctrs::vec_size(alpha)
        if (order > n_alpha) {
            alpha <- c(alpha, numeric(order - n_alpha))
        }
        n_beta <- vctrs::vec_size(beta)
        if (order > n_beta + 1) {
            beta <- c(beta, numeric(order - n_beta - 1))
        }
        for (j in seq_along(ret)) {
            ret[j] <-
                alpha[j] +
                sum(
                    vctrs::vec_slice(beta, 1:(j - 1)) *
                        vctrs::vec_slice(ret, (j - 1):1)
                )
        }
        ret <- c(omega / (1 - sum(beta)), ret)
        return(ret)
    }
