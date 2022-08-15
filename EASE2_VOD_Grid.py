from ease_lonlat import EASE2GRID, SUPPORTED_GRIDS
import pyproj
import netCDF4 as nc
import numpy as np

# define new grid by yourself
grid = EASE2GRID(name='VOD_9km_GRID', epsg=6933, x_min=-179.9533, y_max=84.65644073, res=9000, n_cols=3856, n_rows=1624)

# or using parameters taken from NSIDC and kept in SUPPORTED_GRIDS
#grid = EASE2GRID(name='EASE2_G36km', **SUPPORTED_GRIDS['EASE2_G36km'])

# convert longitude and latitude to row and col indices
point_lon = 147.85
point_lat = 64.86

# row should be 48, col should be 528
col, row = grid.lonlat2rc(lon=point_lon, lat=point_lat)

print(col, row)