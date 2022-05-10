library(sp)
library(rgdal)
library(tidyverse)
library(here)
library(sf)
library(mapview)

###----------- Load csv showing wrsi_pixel
wrsi_pix <- read.csv(here("data","csv","wrsi_pixel.csv"))
zam<-read_sf(here("data","shp","adm1_zambia.shp"))
vuln <- read_sf(here("data","shp","vuln.shp"),crs = 4326)

# Remove the prefix
names(wrsi_pix)<- gsub("X","",names(wrsi_pix))

####----- For wide dataframe---------------
prj <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
select <- dplyr::select #this tells R to use the select() function from the dplyr package, not the select function stored in some of the spatial packages
coords <- wrsi_pix %>% select(Lon, Lat)
wrsi_pix_pt <- SpatialPointsDataFrame(coords = coords, data = wrsi_pix, proj4string = prj)
wrsi_pix_pt <-st_as_sf(wrsi_pix_pt)
mapview(wrsi_pix_pt)

###########- Intersect with Admin and district --------
wrsi_pix_pt_Poly=wrsi_pix_pt %>%
  st_intersection(zam)%>%
  st_intersection(vuln)

mapview(wrsi_pix_pt,zcol = "ADM1_NAME")

## --------- WRSI colored by district ----------------------
wrsi_pix_poly_district=wrsi_pix_poly %>%
  st_intersection(vuln)
mapview(wrsi_pix_poly_district,zcol = "Area")





#######---- Convert to Long dataframe --------
wrsi_pix_pt_wide <- wrsi_pix_pt %>%
  pivot_longer('2001':'2021', names_to = "year", values_to = "wrsi")

head(wrsi_pix_pt_wide)









