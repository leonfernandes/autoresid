#' Collect metrics for sample splitting
#'
#' @inheritParams tune::collect_metrics
#' @export
collect_metrics.smp_spl_results <- function(x) {
    tune:::collect_metrics.tune_results(x, summarize = FALSE)
}