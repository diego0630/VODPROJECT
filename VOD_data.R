#turn vod raster data to spatial points DF
library(dplyr)
library(magrittr)
library(raster)
library(rgdal)
library(tiff)

# Current Code
  
str_name<-'/Users/student/Documents/VOD_Project/vod_summer_geotiff/vod_june_2016_3.tiff'
imported_raster = raster(str_name)
plot(imported_raster)

locations <- read.csv("/Users/student/Documents/VOD_Project/locations.csv", header=TRUE)
coords = data.frame(lat=locations[,2],long=locations[,3])
coordinates(coords)=c("long","lat")
points(coords,col="red")

VOD_Extract = as.data.frame(extract(x=imported_raster,y=coords),row.names=as.character(locations$site),)
print(VOD_Extract)




# Previous Code
vod_june_2017 <- str_name %>%
  select(nrow, ncol, ncell)
rownames(vod_june_2017) <- NULL

# prepare coordinates, data, and proj4string
coords_vod <- vod_june_2017[ , c("nrow", "ncol")]   # coordinates
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