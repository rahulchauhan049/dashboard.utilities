#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  options(shiny.maxRequestSize = 5000 * 1024 ^ 2)
  inputDataset <-
    callModule(
      bdutilities.app::mod_add_data_server,
      id = "bdFileInput"
    )
  
  callModule(mod_leaflet_server, "mod_leaflet", inputDataset)
  callModule(mod_yearly_chart_server, "mod_yearly")
  callModule(mod_chooser_server, "mod_chooser")
  callModule(mod_webVr_server, "webvr")
  callModule(mod_phylo_server, "phylowidget")
  
}
