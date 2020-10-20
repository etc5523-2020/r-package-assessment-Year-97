#' Run the shiny:selectInput for the Covid-19 app
#'
#' @description This function can provide a more concise way to select desired input in the Shiny app
#'
#' @param inputID The variable which shows in the SelectInput function
#'
#' @param chosen The information of the specific observation in that column which chose by the user
#' 
#' 
#' @example 
#' Inputselect("country", "US")
#' 
#' 
#' @export
#' 
Inputselect <- function(inputID, chosen){
  shiny::selectInput(inputId =  inputID, "Which country do you choose", choices = chosen)
}