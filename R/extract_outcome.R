#' Extracts outcome column name
#'
#' Generic function to extract and return outcome variable name.
#' @param object an object to extract model from.
#' @param ... unused.
#' @export
extract_outcome <- function(object, ...) UseMethod("extract_outcome")

#' @rdname extract_outcome
#' @export
extract_outcome.default <-
    function(object, ...) {
        rlang::abort(
            glue::glue("Outcome of class {class(object)} cannot be determined.")
        )
    }

#' @rdname extract_outcome
#' @param formula a `formula` to fit the model to.
#' @export
extract_outcome.model_spec <-
    function(object, formula, ...) tune::outcome_names(formula)

#' @rdname extract_outcome
#' @export
extract_outcome.workflow <-
    function(object, ...) tune::outcome_names(object)

#' @rdname extract_outcome
#' @export
extract_outcome.model_fit <-
    function(object, ...) tune::outcome_names(object$preproc$terms)

#' @rdname extract_outcome
#' @export
extract_outcome.Arima <- function(object, ...) object$series

#' @rdname extract_outcome
#' @export
extract_outcome.Arima_fit_impl <-
    function(object, ...) object$models$model_1$series

#' @rdname extract_outcome
#' @export
extract_outcome.mdl_ts <-
    function(object, ...) fabletools::response_vars(object)