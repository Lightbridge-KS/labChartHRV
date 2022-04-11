
test_that("labChartHRV_example() works",{

  # Test Path Exist
  path_HRV <- labChartHRV_example("HRV")
  expect_true(file.exists(path_HRV))

  path_HRV_f1 <- labChartHRV_example("HRV/file1.txt")
  expect_true(file.exists(path_HRV_f1))

})
