test_that("Inputselect", {
  expect_error(Inputselect(text=""))
  expect_error(Inputselect(text=NULL))
})
