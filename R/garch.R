#' @rdname autoresid
#' @export
autoresid.fGARCH <-
    function(object, new_data, outcome, ...) {
        fit <- methods::slot(object, "fit")
        omega <- subset_from_name(fit$params$params, "omega")
        alpha <- subset_from_name(fit$params$params, "alpha")
        beta <- subset_from_name(fit$params$params, "beta")
        delta <- 2

        len_alpha <- vctrs::vec_size(alpha)
        len_beta <- vctrs::vec_size(beta)
        deltainv <- 1 / delta

        # Extract outcome column
        y <- new_data %>% dplyr::pull(!!rlang::enquo(outcome))
        len_y <- vctrs::vec_size(y)
        if (len_y < len_alpha) {
            rlang::abort(
                "Number of outcomes is not more than length of `alpha`"
            )
        }
        y <- c(
            rep(0, times = len_alpha),
            y
        )
        h <- c(
            # extract first few residuals
            vctrs::vec_slice(
                stats::residuals(object), 1:(len_alpha + len_beta)
            ),
            rep(NA, times = len_y - len_beta)
        )
        for (i in (len_alpha + len_beta + 1):len_y) {
            h[i] <-
                omega +
                sum(
                    alpha * (
                        abs(y[i - (1:len_alpha)])
                    )^delta
                ) +
                sum(beta * h[i - (1:len_beta)])
        }
        h <- utils::tail(h, len_y)
        z <- y / (h^deltainv)
        z
    }