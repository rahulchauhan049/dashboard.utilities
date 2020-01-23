# Module UI
  
#' @title   mod_chooser_ui and mod_chooser_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_chooser
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_chooser_ui <- function(id){
  chooserInput <- function(inputId, leftLabel, rightLabel, leftChoices, rightChoices,
                           size = 5, multiple = FALSE) {
    
    leftChoices <- lapply(leftChoices, tags$option)
    rightChoices <- lapply(rightChoices, tags$option)
    
    if (multiple)
      multiple <- "multiple"
    else
      multiple <- NULL
    
    tagList(
      singleton(tags$head(
        tags$script(src="chooser-binding.js"),
        tags$style(type="text/css",
                   HTML(".chooser-container { display: inline-block; }")
        )
      )),
      div(id=inputId, class="chooser",
          div(class="chooser-container chooser-left-container",
              tags$select(class="left", size=size, multiple=multiple, leftChoices)
          ),
          div(class="chooser-container chooser-center-container",
              icon("arrow-circle-o-right", "right-arrow fa-3x"),
              tags$br(),
              icon("arrow-circle-o-left", "left-arrow fa-3x")
          ),
          div(class="chooser-container chooser-right-container",
              tags$select(class="right", size=size, multiple=multiple, rightChoices)
          )
      )
    )
  }
  
  registerInputHandler("shinyjsexamples.chooser", function(data, ...) {
    if (is.null(data))
      NULL
    else
      list(left=as.character(data$left), right=as.character(data$right))
  }, force = TRUE)
  
  ns <- NS(id)
  
  fluidPage(
    chooserInput(ns("mychooser"), "Available frobs", "Selected frobs",
                 row.names(USArrests), c(), size = 10, multiple = TRUE
    ),
    verbatimTextOutput(ns("selection"))
  )
}
    
# Module Server
    
#' @rdname mod_chooser
#' @export
#' @keywords internal
    
mod_chooser_server <- function(input, output, session){
  
  ns <- session$ns
  
  output$selection <- renderPrint(
    input$mychooser
  )
}
    
## To be copied in the UI
# mod_chooser_ui("chooser_ui_1")
    
## To be copied in the server
# callModule(mod_chooser_server, "chooser_ui_1")
 
