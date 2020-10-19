#' Launch the shiny app to explore the further information about COVID-19 
#'
#' @export

launch_app <- function(){
  shiny::runApp(system.file("app", "app.R", package = "CovidYe"))
}
