
test_that("sipsANS_example() works",{

  # Test Path Exist
  path_HRV <- sipsANS_example("HRV")
  expect_true(file.exists(path_HRV))

  path_HRV_f1 <- sipsANS_example("HRV/file1.txt")
  expect_true(file.exists(path_HRV_f1))

})
