#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  options(shiny.maxRequestSize = 5000 * 1024 ^ 2)
  inputDataset <-
    callModule(
      bdutilities.app::mod_add_data_server,
      id = "bdFileInput"
    )
}
