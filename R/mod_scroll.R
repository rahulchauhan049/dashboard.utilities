# Module UI
  
#' @title   mod_scroll_ui and mod_scroll_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_scroll
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_scroll_ui <- function(id){
  ns <- NS(id)
  library(shinyscroll)
  fluidPage(
    shinyscroll::use_shinyscroll(),
    h1("shinyscroll"),
    verbatimTextOutput(ns("sda")),
    
    p("Select a row"),
    DTOutput(ns("table")),
    plotOutput(ns("plot")),
  )
}
    
# Module Server
    
#' @rdname mod_scroll
#' @export
#' @keywords internal
    
mod_scroll_server <- function(input, output, session){
  ns <- session$ns
  output$table <- renderDT({
    datatable(cars, selection = "single", options = list(pageLength = 20L))
  })
  
  dataset <- observeEvent(input$table_rows_selected, {
    shinyscroll::scroll(ns("plot")) # scroll to plot
    runif(100)
  })
  

  output$plot <- renderPlot(plot(dataset()))
}

    
## To be copied in the UI
# mod_scroll_ui("scroll_ui_1")
    
## To be copied in the server
# callModule(mod_scroll_server, "scroll_ui_1")
 
