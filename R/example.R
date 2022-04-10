#' Get path to sipsANS example
#'
#' sipsANS comes bundled with a number of sample files in its `inst/extdata`
#' directory. This function make them easy to access
#'
#' @param path Path to example file or folder. If `NULL`, the example files or folders will be listed.
#' @export
#' @examples
#' library(sipsANS)
#' sipsANS_example()
#' sipsANS_example("HRV")
sipsANS_example <- function(path = NULL) {

  if (is.null(path)) {
    dir(system.file("extdata", package = "sipsANS"))

  } else {
    system.file("extdata", path, package = "sipsANS", mustWork = TRUE)
  }

}
