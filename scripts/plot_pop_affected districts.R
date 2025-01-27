library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package


# pop affected data
pop_affe <- read.csv(here("data","csv","pop_affe.csv"))
prj <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
vuln <- read_sf(here("data","shp","vuln.shp"),crs = 4326)

# Rename the pop affected to match shp
pop_affe<- pop_affe %>%
                rename(Area = 1)

pop_affected = left_join(vuln, pop_affe, by = "Area")
#facets = names(pop_affe)
facets = c("Pop_affected_2004.05", "Pop_affected_2010.11")
tm_shape(pop_affected) + tm_polygons(facets) +
  tm_facets(nrow = 1, sync = TRUE)

#Using mapview to create maps
#mapview(world_coffee1) #
mapview(pop_affected, zcol = "Pop_affected_2004.05")


world_coffee = left_join(world, coffee_data, by = "name_long")
facets = c("coffee_production_2016", "coffee_production_2017")
tm_shape(world_coffee) + tm_polygons(facets) +
  tm_facets(nrow = 1, sync = TRUE)





