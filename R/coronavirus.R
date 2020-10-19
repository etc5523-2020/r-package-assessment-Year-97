#' General Situation of corona virus in the World
#'
#' A dataset containing general information of corona virus about 188 countries. The 
#' information includes daily confirmed cases, death and recovered cases.
#' 
#' @format a tibble with 181335 observations and 7 variables:
#' 
#' - **date**: The date of the summary
#' - **province**: The province or state, when applicable
#' - **country**: The country or region name
#' - **lat**: Latitude point
#' - **long**: Longitude point
#' - **type**: the type of case (i.e., confirmed, death)
#' - **cases**: the number of daily cases (corresponding to the case type)
#' 
#' 
#' @import tibble
#' 
#' @source [WHO](https://www.who.int/) and [coronavirus](https://github.com/RamiKrispin/coronavirus)
"coronavirus"






