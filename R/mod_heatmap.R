# Module UI
  
#' @title   mod_heatmap_ui and mod_heatmap_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_heatmap
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_heatmap_ui <- function(id){
  ns <- NS(id)
  tagList(
    rChartsCalmap::calheatmapOutput(ns("heatmap"))
  )
}
    
# Module Server
    
#' @rdname mod_heatmap
#' @export
#' @keywords internal
    
mod_heatmap_server <- function(input, output, session){
  ns <- session$ns
  library(htmlwidgets)
  output$heatmap <- rChartsCalmap::renderCalheatmap({
    dat <- read.csv('http://t.co/mN2RgcyQFc')[,c('date', 'pts')]
    r1 <- calheatmap(x = 'date', y = 'pts',
                     data = dat, 
                     domain = 'month',
                     start = "2012-10-27",
                     legend = seq(10, 50, 10),
                     itemName = 'point',
                     range = 7
    )
    r1
  })
}
    
## To be copied in the UI
# mod_heatmap_ui("heatmap_ui_1")
    
## To be copied in the server
# callModule(mod_heatmap_server, "heatmap_ui_1")
 
