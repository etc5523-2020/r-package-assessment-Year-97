test_that("Easykable", {
  expect_error(Easykable(text=NULL))
  expect_error(Easykable(text=""))
  
  x <- c("15")
  expect_equal(
    Easykable(x),
    
    CovidYe::coronavirus %>% 
      dplyr::select(country, type, cases) %>% 
      dplyr::group_by(type, country) %>%
      dplyr::summarise(total_cases = sum(cases)) %>%
      tidyr::pivot_wider(names_from = type, values_from = total_cases) %>%
      dplyr::arrange(-confirmed) %>%
      utils::head(15) %>% 
      kableExtra::kable(align = 'lccr', 
                        format.args = list(big.mark = ",")) %>% 
      kableExtra::kable_styling(
        font_size = 15,
        bootstrap_options = c("striped", "hover", "condensed")) %>% 
      kableExtra::row_spec(1:15, color = "white",background = "grey"))
})
