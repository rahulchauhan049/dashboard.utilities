#' @import shiny shinydashboard dashboardthemes leaflet dplyr
#'  lattice scales RColorBrewer googleCharts shinyaframe phylowidget
app_ui <- function() {
  shinydashboard::dashboardPage(
    
    skin = "green",
    dashboardHeader(title = "bdvis Dashboard"),
    dashboardSidebar(
      sidebarMenu(
        id = "sideBar",
        menuItem(
          "Data Input",
          tabName = "dataInputTab",
          icon = icon("database")
        )
      ),
      sidebarMenu(
        id = "leaflet",
        menuItem(
          "Leaflet",
          tabName = "leafletTab"
        ),
        menuItem(
          "Yearly Chart",
          tabName = "yearlyTab"
        ),
        menuItem(
          "Miscellaneous",
          menuSubItem(
            "Chooser",
            tabName = "chooserTab"
          )
        ),
        menuItem(
          "3D Visualization",
          tabName = "webVr"
        ),
        menuItem(
          "Phylowidget",
          tabName = "phylowidget"
        )
      )
    ),
    dashboardBody(
      shinyDashboardThemes(
        theme = "grey_dark"
      ),
      golem_add_external_resources(),
      tabItems(
        tabItem(
          tabName = "dataInputTab",
          bdutilities.app::mod_add_data_ui("bdFileInput")
        ),
        tabItem(
          tabName = "leafletTab",
          mod_leaflet_ui("mod_leaflet")
        ),
        tabItem(
          tabName = "yearlyTab",
          mod_yearly_chart_ui("mod_yearly")
        ),
        tabItem(
          tabName = "chooserTab",
          mod_chooser_ui("mod_chooser")
        ),
        tabItem(
          tabName = "webVr",
          mod_webVr_ui("webvr")
        ),
        tabItem(
          tabName = "phylowidget",
          mod_phylo_ui("phylowidget")
        )
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'dashboard.utilities')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    
    tags$link(rel="stylesheet", type="text/css", href="www/styles.css")
  )
}
