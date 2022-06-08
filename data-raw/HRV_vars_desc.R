## code to prepare `HRV_vars_desc` dataset goes here

## HRV report variables description
HRV_vars_desc <- c(
  doc_id = "File name of the input HRV reports",
  # Line 1
  File_LabChart = "LabChart file name",
  Channel = "Channel",
  Date = "Date",
  # Line 2
  Start_time = "Start time",
  End_time = "End time",
  # Line 3
  Name = "Name",
  Gender = "Gender",
  Age = "Age",
  # Line 4
  Beats_tot = "Total number of beats",
  Rec_length = "Length of recording (s)",
  # Line 5
  Class_bound = "Classification boundaries",
  # Line 6
  Discontinuities = "Discontinuities",
  Beats_inserted = "Manually inserted beats",
  Beats_deleted = "Manually deleted beats",
  # Line 7
  NN_max = "Maximum NN (ms)",
  NN_min = "Minimum NN (ms)",
  NN_range = "Range (Max - Min NN) (ms)",
  # Line 8
  NN_mean = "Mean NN (ms)",
  NN_median = "Median NN (ms)",
  HR_avg = "Average heart rate (BPM)",
  # Line 9
  SDNN = "SDNN (ms)",
  SD_del_NN = "SD of delta NN (ms)",
  RMSSD = "RMSSD",
  # Line 10
  Normals_count = "Normal beats count",
  Ectopics_count = "Ectopic beats count",
  Artifacts_count = "Artifacts count",
  NN50_count = "NN50 count",
  NN50_percent = "pNN50 (%)",
  # Line 11
  Spec_intv = "Spectrum intervals",
  Spec_mean_NN = "Mean spectrum NN (ms)",
  # Line 12
  Power_tot = "Total power (ms squared)",
  VLF_freq = "VLF frequency range (Hz)",
  VLF = "VLF (ms squared)",
  # Last Line
  LF_freq = "LF frequency range (Hz)",
  LF = "LF (ms squared)",
  LF_nu = "LF (nu)",

  HF_freq = "HF frequency range (Hz)",
  HF = "HF (ms squared)",
  HF_nu = "HF (nu)",

  LF_HF = "LF to HF ratio"
) %>%

  tibble::enframe("variable", "description")

usethis::use_data(HRV_vars_desc, overwrite = TRUE)
