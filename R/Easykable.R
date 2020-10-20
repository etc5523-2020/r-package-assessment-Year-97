#' Create a formatted and stylish table contains the Covid-19 information in the kableExtra function.
#'
#' @description Creates a styled and formatted table to represent the summary case situation of COVID19 in each country.
#'
#' @param n_country The number of the countries with most confirmed cases in the data to be formatted in table.
#'
#' @return A formatted table of the COVID data set with the specific obervations.
#'
#' @importFrom magrittr %>% 
#'
#' @export

Easykable <- function(n_country)
  CovidYe::coronavirus %>% 
   dplyr::select(country, type, cases) %>% 
   dplyr::group_by(type, country) %>%
   dplyr::summarise(total_cases = sum(cases)) %>%
   tidyr::pivot_wider(names_from = type, values_from = total_cases) %>%
   dplyr::arrange(-confirmed) %>%
   head(n_country) %>% 
   kableExtra::kable(align = 'lccr', 
                     format.args = list(big.mark = ",")) %>% 
   kableExtra::kable_styling(
     font_size = 15,
     bootstrap_options = c("striped", "hover", "condensed")) %>% 
  kableExtra::row_spec(1:n_country, color = "white",background = "grey")
