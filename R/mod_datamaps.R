# Module UI
  
#' @title   mod_datamaps_ui and mod_datamaps_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_datamaps
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_datamaps_ui <- function(id){
  ns <- NS(id)
  fluidPage(
    
    textInput(
      ns("from"),
      "Origin",
      value = "USA"
    ),
    textInput(
      ns("to"),
      "Destination",
      value = "RUS"
    ),
    actionButton(
      ns("submit"),
      "Draw arc"
    ),
    datamapsOutput(ns("map"))
  )
}
    
# Module Server
    
#' @rdname mod_datamaps
#' @export
#' @keywords internal
    
mod_datamaps_server <- function(input, output, session){
  ns <- session$ns
  
  arc <- reactive({
    data.frame(from = input$from, to = input$to)
  })
  
  output$map <- renderDatamaps({
    datamaps()
  })
  
  observeEvent(input$submit, {
    datamapsProxy(ns("map")) %>%
      add_data(arc()) %>%
      update_arcs_name(from, to)
  })
}
    
## To be copied in the UI
# mod_datamaps_ui("datamaps_ui_1")
    
## To be copied in the server
# callModule(mod_datamaps_server, "datamaps_ui_1")
 
