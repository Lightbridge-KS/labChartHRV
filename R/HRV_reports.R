

# Read HRV Report ---------------------------------------------------------


#' Read LabChart's HRV Report File
#'
#' @description
#' Read and transform LabChart's HRV report file (`.txt`) to a tidy [tibble](https://tibble.tidyverse.org)
#' with one row per file.
#'
#' @details [read_HRV_reports()] reads contents of LabChart's HRV report from text file (`.txt`)
#' into character vector using [readtext::readtext()] function with default text encoding as "UTF-16LE".
#' Then, each key-value fields of the character vector will be extracted and transform into a [tibble](https://tibble.tidyverse.org)
#' by regular expression pattern matching as in [parse_HRV_reports()].
#'
#' The result will be a tibble with column names corresponding to "key" in the input file(s),
#' and values in each rows mapped to "value" from the input file(s).
#'
#' @param file (Character) Path to LabChart's HRV report (`.txt`) files to be read.
#' Path can point to an individual text file (`.txt`) or a folder which contains those files.
#' @param format_cols (Logical) If `TRUE` formats appropriate output variables as factor, integer, or double, and compute `NN50_percent` (pNN50) from `NN50_count/Normals_count`
#' @param encoding (Character) Text encoding of the HRV report files.
#' Default value is set to "UTF-16LE" as it works well with my testing data.
#' If the result seems abnormal, try different text encoding (visit [readtext manual](https://readtext.quanteda.io/index.html) to see all available options)
#' @param ... extra arguments passed to [readtext::readtext()]
#'
#' @return A tibble of HRV report (one row per subject)
#' @export
#'
#' @examples
#' # Path to `HRV/` folder containing example HRV report files (`.txt`)
#' path <- sipsANS_example("HRV")
#' # Read into tibble
#' read_HRV_reports(path)
read_HRV_reports <- function(file,
                             format_cols = TRUE,
                             encoding = "UTF-16LE",
                             ...
){
  # Read Raw
  df_raw <- readtext::readtext(file = file,
                               encoding = encoding,
                               ...
  )
  # Parse Character to HRV tibble
  df_hrv <- parse_HRV_reports(df_raw[["text"]],
                              format_cols = format_cols)
  # Bind `doc_id` to HRV tibble
  df_out <- dplyr::bind_cols(doc_id = df_raw[["doc_id"]], df_hrv)
  df_out
}


# Parse HRV Report --------------------------------------------------------



#' Parse LabChart's HRV Report
#'
#' @description
#' Parse and transform LabChart's HRV report from a character vector to a tidy [tibble](https://tibble.tidyverse.org)
#'
#' @details
#' [parse_HRV_reports()] extracts key and value pairs from each fields of LabChart's HRV report supplied as character vectors
#' using regular expression for pattern matching. Extracted data then transform into a [tibble](https://tibble.tidyverse.org)
#' with "key" mapping to column names and "value" mapping to corresponding cells.
#' If `x` is given as character vector of length > 1, there will be multiple rows of tibble with each rows corresponding to each input character vectors.
#'
#' @param x (Character) Character vectors of HRV report, each elements
#' corresponding to one report.
#' @param format_cols (Logical) If `TRUE` formats appropriate output variables as factor, integer, or double, and compute `NN50_percent` (pNN50) from `NN50_count/Normals_count`
#'
#' @seealso [read_HRV_reports()]: read LabChart's HRV report from file(s) path.
#' @return A tibble of HRV report (one row per subject)
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
