#' @import shiny shinydashboard dashboardthemes leaflet dplyr
#'  lattice scales RColorBrewer googleCharts shinyaframe phylowidget
#'  datamaps mapview leaftime htmltools leaflet.minicharts rChartsCalmap
#'  htmlwidgets shinyscroll DT
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
        ),
        menuItem(
          "Leaflet",
          menuSubItem(
            "Example 1",
            tabName = "leafletTabOne"
          ),
          menuSubItem(
            "DataMaps",
            tabName = "dataMaps"
          ),
          menuSubItem(
            "Map View",
            tabName = "mapView"
          ),
          menuSubItem(
            "Leftime",
            tabName = "leaftime"
          ),
          menuSubItem(
            "Leaflet Minicharts",
            tabName = "leafchart"
          )
        ),
        menuItem(
          "Heatmap",
          tabName = "heatmap"
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
          ),
          menuSubItem(
            "Scroll",
            tabName = "scroll"
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
          tabName = "leafletTabOne",
          mod_leaflet_ui("mod_leaflet")
        ),
        tabItem(
          tabName = "dataMaps",
          mod_datamaps_ui("datamaps")
        ),
        tabItem(
          tabName = "mapView",
          mod_mapview_ui("mapview")
        ),
        tabItem(
          tabName = "leaftime",
          mod_leaftime_ui("leaftime")
        ),
        tabItem(
          tabName = "leafchart",
          mod_leaftime.minicharts_ui("leafchart")
        ),
        tabItem(
          tabName = "heatmap",
          mod_heatmap_ui("heatmap")
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
          tabName = "scroll",
          mod_scroll_ui("scroll")
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
