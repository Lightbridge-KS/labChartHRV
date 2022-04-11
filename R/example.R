#' Get path to labChartHRV example
#'
#' labChartHRV comes bundled with a number of sample files in its `inst/extdata`
#' directory. This function make them easy to access
#'
#' @param path Path to example file or folder. If `NULL`, the example files or folders will be listed.
#' @export
#' @examples
#' library(labChartHRV)
#' labChartHRV_example()
#' labChartHRV_example("HRV")
labChartHRV_example <- function(path = NULL) {

  if (is.null(path)) {
    dir(system.file("extdata", package = "labChartHRV"))

  } else {
    system.file("extdata", path, package = "labChartHRV", mustWork = TRUE)
  }

}
