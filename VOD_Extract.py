import netCDF4 as nc
from netCDF4 import Dataset
import numpy as np
import xarray as xr
#with Dataset as VOD_9km_File:
#    nc_attrValue = VOD_9km_File.variables['VOD'][1585][737]
#    print(type(nc_attrValue)

def ExtractVOD(ncdir, varnames):
    col = 1585
    row = 737

    with Dataset(ncdir, "r") as nc:
        # Return a np.array with the netcdf data
        nc_data = np.ma.getdata(
            [nc.variables['VOD'][0, row, col] for varname in varnames]
        )
        return nc_data
    
    

VOD_Extract = ExtractVOD(ncdir = '/Users/student/Documents/VOD_Project/MTDCA_9km_V4_nc/MTDCA_201704_201706_9km_V4.nc',varnames = ['VOD','time'])

#New_VOD_File = nc4.Dataset('Extracted_VOD_Data','w', format='NETCDF4')

df = xr.DataArray(VOD_Extract)
df.to_netcdf('VOD_Extract_Data.nc')
