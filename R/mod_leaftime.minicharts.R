# Module UI
  
#' @title   mod_leaftime.minicharts_ui and mod_leaftime.minicharts_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_leaftime.minicharts
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_leaftime.minicharts_ui <- function(id){
  ns <- NS(id)
  fluidPage(
    titlePanel("Demo of leaflet.minicharts"),
    p("This application uses the data.frame 'eco2mix', included in the 'leaflet.minicharts' packages.",
      "It contains the monthly electric production of french regions from 2013 to 2017."),
    tags$head(tags$style(
      HTML('
         #sidebar {
            background-color: #000000;
         }
        body, label, input, button, select { 
          font-family: "Arial";
          color: rgb(205,205,205);
        }')
    )),
    sidebarLayout(
      
      sidebarPanel(id="sidebar",
        selectInput(ns("prods"), "Select productions", choices = prodCols, multiple = TRUE),
        selectInput( ns("type"), "Chart type", choices = c("bar","pie", "polar-area", "polar-radius")),
        checkboxInput(ns("labels"), "Show values")
      ),
      
      mainPanel(
        leafletOutput(ns("map"))
      )
      
    )
  )
}
    
# Module Server
    
#' @rdname mod_leaftime.minicharts
#' @export
#' @keywords internal
    
mod_leaftime.minicharts_server <- function(input, output, session){
  ns <- session$ns
  
  data("eco2mix")
  load("regions.rda")
  
  # Remove data for the whole country
  prodRegions <- eco2mix %>% filter(area != "France")
  
  # Production columns
  prodCols <- names(prodRegions)[6:13]
  
  # Create base map
  tilesURL <- "http://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}"
  
  basemap <- leaflet(width = "100%", height = "400px") %>%
    addTiles(tilesURL) %>%
    addPolylines(data = regions, weight = 1, color = "brown")
  output$map <- renderLeaflet({
    basemap %>%
      addMinicharts(
        prodRegions$lng, prodRegions$lat,
        layerId = prodRegions$area,
        width = 45, height = 45
      )
  })
  
  # Update charts each time input value changes
  observe({
    if (length(input$prods) == 0) {
      data <- 1
    } else {
      data <- prodRegions[, input$prods]
    }
    maxValue <- max(as.matrix(data))
    
    leafletProxy("map", session) %>%
      updateMinicharts(
        prodRegions$area,
        chartdata = data,
        maxValues = maxValue,
        time = prodRegions$month,
        type = ifelse(length(input$prods) < 2, "polar-area", input$type),
        showLabels = input$labels
      )
  })
}
    
## To be copied in the UI
# mod_leaftime.minicharts_ui("leaftime.minicharts_ui_1")
    
## To be copied in the server
# callModule(mod_leaftime.minicharts_server, "leaftime.minicharts_ui_1")
 
