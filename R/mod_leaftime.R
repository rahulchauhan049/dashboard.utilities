# Module UI
  
#' @title   mod_leaftime_ui and mod_leaftime_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_leaftime
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_leaftime_ui <- function(id){
  ns <- NS(id)
  tagList(
  leaflet::leafletOutput(ns("map"))
  )
}
    
# Module Server
    
#' @rdname mod_leaftime
#' @export
#' @keywords internal
    
mod_leaftime_server <- function(input, output, session){
  ns <- session$ns
  power <- data.frame(
    "Latitude" = c(
      33.515556, 38.060556, 47.903056, 49.71, 49.041667, 31.934167,
      54.140586, 54.140586, 48.494444, 48.494444
    ),
    "Longitude" = c(
      129.837222, -77.789444, 7.563056, 8.415278, 9.175, -82.343889,
      13.664422, 13.664422, 17.681944, 17.681944
    ),
    "start" = seq.Date(as.Date("2015-01-01"), by = "day", length.out = 10),
    "end" = seq.Date(as.Date("2015-01-01"), by = "day", length.out = 10) + 1
  )
  
  power_geo <- geojsonio::geojson_json(power,lat="Latitude",lon="Longitude")
  
  
  output$map <- leaflet::renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(data = power_geo)
    
    # or we can add data in leaflet()
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline()
    
    # we can control the slider controls through sliderOptions
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        sliderOpts = sliderOptions(
          formatOutput = htmlwidgets::JS(
            "function(date) {return new Date(date).toDateString()}
      "),
          position = "bottomright",
          step = 10,
          duration = 3000,
          showTicks = FALSE
        )
      )
    
    # we can control the timeline through timelineOptions
    #  wondering what should be the default
    #  currently timeline uses marker
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        timelineOpts = timelineOptions(
          pointToLayer = htmlwidgets::JS(
            "
function(data, latlng) {
  return L.circleMarker(latlng, {
    radius: 3
  })
}
"
          )
        )
      )
    
    # change styling manually
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        timelineOpts = timelineOptions(
          pointToLayer = htmlwidgets::JS(
            "
function(data, latlng) {
  return L.circleMarker(latlng, {
    radius: 10,
    color: 'black',
    fillColor: 'pink',
    fillOpacity: 1
  })
}
"
          )
        )
      )
    
    # change style with styleOptions helper function
    #   this will change style for all points
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        timelineOpts = timelineOptions(
          styleOptions = styleOptions(
            radius = 10,
            color = "black",
            fillColor = "pink",
            fillOpacity = 1
          )
        )
      )
    
    # to style each point differently based on the data
    power_styled <- power
    # IE does not like alpha so strip colors of alpha hex
    power_styled$color <- substr(topo.colors(6)[ceiling(runif(nrow(power),0,6))],1,7)
    power_styled$radius <- ceiling(runif(nrow(power),3,10))
    leaflet(geojsonio::geojson_json(power_styled)) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addCircleMarkers(
        data = power_styled, lat = ~Latitude, lng = ~Longitude, radius = 11
      ) %>%
      addTimeline(
        timelineOpts = timelineOptions(
          styleOptions = styleOptions(
            radius = htmlwidgets::JS("function getRadius(d) {return +d.properties.radius}"),
            color = htmlwidgets::JS("function getColor(d) {return d.properties.color}"),
            fillOpacity = 1,
            stroke = FALSE
          )
        )
      )
    
    
    # we can use onchange to handle timeline change event
    leaflet(power_geo) %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        onchange = htmlwidgets::JS("function(e) {console.log(e, arguments)}")
      )
    
    
    leaflet(power_geo, elementId = "leaflet-wide-timeline") %>%
      addTiles() %>%
      setView(44.0665,23.74667,2) %>%
      addTimeline(
        width = "96%"
      )
    
  })
}
    
## To be copied in the UI
# mod_leaftime_ui("leaftime_ui_1")
    
## To be copied in the server
# callModule(mod_leaftime_server, "leaftime_ui_1")
 
