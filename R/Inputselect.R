#' Run the shiny:selectInput for the Covid-19 app
#'
#' @description This function can provide a more concise way to select desired input in the Shiny App
#'
#' @param ID The variable which shows the specific content of the cases chose by the user
#'
#' @param chosen_column The column in the specific data set which chose by users to show in the Shiny App 
#' 
#' @examples
#' \dontrun{
#' Inputselect("country", corona_table$country)
#' } 
#' 
#' @return A shiny control which can choose the specfic inputs for the following presentation in the Shiny app 
#' 
#' @export
#' 
Inputselect <- function(ID, chosen_column){
 corona_table <-  CovidYe::coronavirus %>% 
      dplyr::select(date, country, type, cases) %>% 
      dplyr::filter(country %in% c("US", "India", "Brazil", "Russia", "Peru", "Colombia", "Mexico", "South Africa", "Spain", "Argentina")) %>% 
      dplyr::filter(type == "confirmed")
 
      shiny::selectInput(inputId = ID, "Which country do you choose", choices = chosen_column)
}