corona_table <-  CovidYe::coronavirus %>% 
  dplyr::select(date, country, type, cases) %>% 
  dplyr::filter(country %in% c("US", "India", "Brazil", "Russia", "Peru", "Colombia", "Mexico", "South Africa", "Spain", "Argentina")) %>% 
  dplyr::filter(type == "confirmed")

test_that("Inputselect", {
  expect_error(Inputselect(text=""))
  expect_error(Inputselect(text=NULL))
  expect_error(Inputselect(text="type"))
  
  x <- c("country")
  y <- corona_table$country
  expect_equal(
    Inputselect(x,y),
    
    shiny::selectInput(inputId = "country", "Which country do you choose", choices = corona_table$country)
  )
})
