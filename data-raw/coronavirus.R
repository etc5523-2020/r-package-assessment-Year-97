## code to prepare `coronavirus` dataset goes here

coronavirus <- read.csv("data-raw/coronavirus.csv")

usethis::use_data(coronavirus, overwrite = TRUE)
