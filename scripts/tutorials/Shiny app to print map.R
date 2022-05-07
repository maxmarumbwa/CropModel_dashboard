library(shiny)
library(shinydashboard)
library(shinyjs)
library(htmlwidgets)
library(htmltools)
library(leaflet)
library(leaflet.extras)
library(sp)

shinyApp(
  ui = fluidPage(
    leafletOutput("map", height = 750)
  ),
  server = function(input, output) {

    registerPlugin <- function(map, plugin) {
      map$dependencies <- c(map$dependencies, list(plugin))
      map
    }

    easyPrintPlugin <- htmlDependency("leaflet-easyprint", "2.1.8",
                                      src = c(href = "https://github.com/rowanwins/leaflet-easyPrint/blob/gh-pages/dist/"),
                                      script = "index.js")

    # Map
    output$map <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        registerPlugin(easyPrintPlugin) %>%
        onRender("function(el, x) {
                 L.easyPrint({
                 position: 'topleft',
                 sizeModes: ['A4Portrait', 'A4Landscape']
                 }).addTo(map);}")
    })

  }
)

shinyApp(ui, server)
