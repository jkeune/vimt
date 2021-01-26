#!/bin/bash


# 1) merge years
cdo -b F64 mergetime eraint_vimt_monmean_* eraint_vimt_monmean.nc

# 2) calculate average u and v fluxes
cdo -timmean -selvar,p71.162 -selmon,6,7,8 eraint_vimt_monmean.nc umean.nc
cdo -timmean -selvar,p72.162 -selmon,6,7,8 eraint_vimt_monmean.nc vmean.nc

# 3) calculate average direction
cdo -mulc,57.3 -atan2 -mulc,-1 umean.nc -mulc,-1 vmean.nc uvdir.nc

# 4) calculate average flux
cdo merge umean.nc vmean.nc uvmean.nc
cdo sqrt -add -sqr umean.nc -sqr vmean.nc uvmean.nc

# 5) mean divergence
#cdo -timmean -selvar,p84.162 -selmon,6,7,8 eraint_vimt_monmean.nc vimtdmean.nc 
cdo -mulc,86400 -timmean -selvar,p84.162 eraint_vimt_monmean.nc vimtdmean_year.nc 
cdo -mulc,86400 -timmean -selmon,6,7,8 -selvar,p84.162 eraint_vimt_monmean.nc vimtdmean_summer.nc 
