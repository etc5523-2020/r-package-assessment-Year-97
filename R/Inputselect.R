#' Run the shiny:selectInput for the Covid-19 app
#'
#' @description This function can provide a more concise way to select desired input in the Shiny app
#'
#' @param ID The variable which shows in the SelectInput function
#'
#' 
#' @example 
#' Inputselect("country")
#' 
#' @return A shiny control which can choose the specfic inputs for the following presentation in the Shiny app 
#' 
#' @export
#' 
Inputselect <- function(ID){
 corona_table <-  CovidYe::coronavirus %>% 
      dplyr::select(date, country, type, cases) %>% 
      dplyr::filter(country %in% c("US", "India", "Brazil", "Russia", "Peru", "Colombia", "Mexico", "South Africa", "Spain", "Argentina")) %>% 
      dplyr::filter(type == "confirmed")
 
      shiny::selectInput(inputId = ID, "Which country do you choose", choices = corona_table$country)
}