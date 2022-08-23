#turn vod raster data to spatial points DF
library(dplyr)
library(magrittr)
library(raster)
library(rgdal)
library(tiff)
str_name<-'/Users/student/Documents/VOD_Project/vod_june_2017.tif' 
imported_raster=raster(str_name)
vod_june_2017 <- imported_raster %>%
  select(lon,lat,VOD)
rownames(vod_june_2017) <- NULL

# prepare coordinates, data, and proj4string
coords_vod <- vod_june_2017[ , c("lon", "lat")]   # coordinates
data_vod   <- vod_june_2017[ , 3]          # data

# make the SpatialPointsDataFrame object
spdf_vod <- SpatialPointsDataFrame(coords      = coords_vod,
                                   data        = data_vod, 
                                   proj4string = crs)

library(FNN)

#link ground-based coordinates to vod coordinates for storage
nn1 = get.knnx(coordinates(spdf_vod), coordinates(spdf_ground), 1)
vector <- data.frame(nn1[1])
vector <- vector[c(1:nrow(vector)),]
spdf_vod_df <- data.frame(spdf_vod)
new_df <- spdf_vod_df[c(vector),]
new_df <- new_df %>%
  select(VOD,lon,lat)