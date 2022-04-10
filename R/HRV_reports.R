#' Parse HRV Report file
#'
#' Parse HRV Report file from a character vector to a tibble.
#'
#' @param x (Character) Character vectors of HRV report, each elements
#' corresponding to one report.
#' @param format_cols If `TRUE` format appropriate output variables as factor, integer, or double. Compute `NN50_percent` (pNN50) from `NN50_count/Normals_count`
#'
#' @return A tibble
#' @export
#' @include HRV_field.R
#'
#' @examples NULL
parse_HRV_reports <- function(x, format_cols = TRUE) {

  # Regex: Extract after equal sign
  after_equal_regex <- c("(?<== )([:digit:]|[:punct:])+")

  nm_self <-  stats::setNames(names(regex_hrv()), names(regex_hrv()))

  report_df <- nm_self %>%
    # Step 1: Extract HRV fields into DF
    purrr::map_dfc(
      ~ extract_HRV_field[[.x]](x)
    ) %>%
    # Step 2: Some vars have to extract number after equal sign
    dplyr::mutate(
      dplyr::across(
        c("VLF", "LF", "HF", "LF_HF"),
        ~ stringr::str_extract(.x, after_equal_regex)
      )
    )

  ## Not format column
  if( !format_cols){ return(report_df) }

  ## Format column
  report_df %>%
    dplyr::mutate(dplyr::across(c(Channel, Gender), factor),
                  dplyr::across(Age, as.integer),
                  dplyr::across(c(Beats_tot,Rec_length,
                                  Discontinuities:Power_tot,
                                  VLF,LF, LF_nu, HF, HF_nu, LF_HF), as.numeric)
    ) %>%
    # Add pNN50
    dplyr::mutate(NN50_percent = 100 * (NN50_count/Normals_count),
                  .after = NN50_count)

}
