library(sp)
library(rgdal)
library(tidyverse)

###----------- Load csv showing wrsi_pixel
wrsi_pix <- read.csv(here("data","csv","wrsi_pixel.csv"))
glimpse(wrsi_pix)

prj <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
select <- dplyr::select #this tells R to use the select() function from the dplyr package, not the select function stored in some of the spatial packages
coords <- wrsi_pix %>% select(Lon, Lat)
wrsi_pix_pt <- SpatialPointsDataFrame(coords = coords, data = wrsi_pix, proj4string = prj)
plot(wrsi_pix_pt)
