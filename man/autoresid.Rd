% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/arima.R, R/autoresid-generic.R, R/garch.R
\name{autoresid.arima}
\alias{autoresid.arima}
\alias{autoresid}
\alias{autoresid.default}
\alias{autoresid.garch}
\title{Extract fitted residuals from models}
\usage{
\method{autoresid}{arima}(object, new_data, outcome, ...)

autoresid(object, new_data, outcome = NULL, ...)

\method{autoresid}{default}(object, new_data, outcome = NULL, ...)

\method{autoresid}{garch}(object, new_data, outcome, ...)
}
\arguments{
\item{object}{a fitted arima or garch model}

\item{new_data}{a \link[tsibble:tsibble-package]{tsibble} of univariate
time series on which residuals are to be calculated.}

\item{outcome}{name of column to fit data to.}

\item{...}{Options passed to methods.}
}
\value{
a \link[tsibble:tsibble-package]{tsibble} of fitted residuals.
}
\description{
Extract fitted residuals from models
}
