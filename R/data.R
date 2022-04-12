#' HRV Variable Description
#'
#' A dataset containing variable description of HRV report when imported into `R` via
#' [read_HRV_reports()] or [parse_HRV_reports()]
#'
#' @format A data frame with 2 columns:
#' \describe{
#'   \item{variable}{a variable names}
#'   \item{description}{a description of each variables}
#' }
"HRV_vars_desc"



#' HRV Time & Frequency Domain Variable
#'
#' A list for quickly select HRV variables in the category of time or frequency domain.
#' It is intended to be used with the resulting tibble of [read_HRV_reports()] or [parse_HRV_reports()].
#'
#'
#' @format A list with 2 elements:
#' \describe{
#'   \item{time}{contain character vector of time-domain variables}
#'   \item{freq}{contain character vector of frequency-domain variables}
#' }
"HRV_vars_domain"
