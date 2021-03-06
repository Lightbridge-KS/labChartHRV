

hrv_tbl_names <- c("doc_id", "File_LabChart", "Channel", "Date", "Start_time", "End_time",
                   "Name", "Gender", "Age", "Beats_tot", "Rec_length", "Class_bound",
                   "Discontinuities", "Beats_inserted", "Beats_deleted",
                   "NN_max", "NN_min", "NN_range", "NN_mean", "NN_median",
                   "HR_avg", "SDNN", "SD_del_NN", "RMSSD", "Normals_count",
                   "Ectopics_count", "Artifacts_count", "NN50_count", "NN50_percent",
                   "Spec_intv", "Spec_mean_NN", "Power_tot", "VLF_freq", "VLF",
                   "LF_freq", "LF", "LF_nu", "HF_freq", "HF", "HF_nu", "LF_HF")


# Parse HRV -------------------------------------------------------------------



test_that("parse_HRV_reports() works", {

  hrv_tbl <- parse_HRV_reports(hrv_chr_raw)
  # Tibble Class
  expect_s3_class(hrv_tbl, "tbl_df")
  # Check Col Names
  expect_named(hrv_tbl, hrv_tbl_names[-1]) # Excluding `doc_id`

})



# Read HRV ----------------------------------------------------------------


test_that("read_HRV_reports() works", {

  hrv_tbl <- read_HRV_reports(path_hrv)
  # Tibble Class
  expect_s3_class(hrv_tbl, "tbl_df")
  # Check Col Names
  expect_named(hrv_tbl, hrv_tbl_names)

})
