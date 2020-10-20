#' Launch the shiny app to explore the further information about COVID-19 
#' 
#' @description 
#' Runs the Covid-19 Shiny app which contains in the `CovidYe`` package.
#' 
#' @import shiny
#' 
#' @example 
#' launch_app()
#' 
#' @export

launch_app <- function(){
  shiny::runApp(system.file("app", "app.R", package = "CovidYe"))
}
