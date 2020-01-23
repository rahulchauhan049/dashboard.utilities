# Module UI
  
#' @title   mod_mapview_ui and mod_mapview_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_mapview
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_mapview_ui <- function(id){
  ns <- NS(id)
  tagList(
  mapview::mapviewOutput(ns("map"))
  )
}
    
# Module Server
    
#' @rdname mod_mapview
#' @export
#' @keywords internal
    
mod_mapview_server <- function(input, output, session){
  ns <- session$ns
  library(mapview)
  output$map <- mapview::renderMapview(mapview(breweries))
}
    
## To be copied in the UI
# mod_mapview_ui("mapview_ui_1")
    
## To be copied in the server
# callModule(mod_mapview_server, "mapview_ui_1")
 
