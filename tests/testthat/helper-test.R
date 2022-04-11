
# Paths -------------------------------------------------------------------



path_hrv <- sipsANS_example("HRV")
path_hrv1 <- sipsANS_example("HRV/file1.txt")


# Raw HRV Character -------------------------------------------------------


hrv_chr_raw <- readtext::readtext(path_hrv, encoding = "UTF-16LE")$text
hrv1_chr_raw <- readtext::readtext(path_hrv1, encoding = "UTF-16LE")$text



