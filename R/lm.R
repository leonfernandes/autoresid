#' Autoresid methods for lm models
#'
#' It is assumed that `new_data` has all the predictor variables. However the
#' `outcome` needs to be specified in this implementation.
#' @inheritParams autoresid
#' @rdname autoresid_lm
#' @export
#' @examples
#' lin_mod <- lm(mpg ~ cyl, data = mtcars)
#' autoresid(lin_mod, head(mtcars), "mpg")
autoresid.lm <-
    function(object, new_data, outcome, ...) {
        # Extract outcome column
        out <- new_data %>% dplyr::pull(!!rlang::enquo(outcome))
        # Extract residuals
        ret <- out - stats::predict(object, new_data)
        tibble::new_tibble(
            tibble::tibble(".resid" = ret),
            class = "autoresid_tbl"
        )
    }

#' @rdname autoresid_lm
#' @export
autoresid._lm <-
    function(object, new_data, outcome, ...) {
        object <- object$fit
        autoresid(object, new_data, outcome, ...)
    }