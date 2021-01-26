# module load R/3.3.3-intel-2017a-X11-20170314 
library(ncdf4)
library(fields)
require(utils)
require(rasterVis)
library(rgdal)
source("/data/gent/vo/000/gvo00090/vsc42383/tools/flexpart/projects/wsrecycling/000_misc/coastlines.r")

# READ WIND DATA
ncfile	= nc_open("/scratch/gent/vo/000/gvo00090/vsc42383/eradata/vimt_monthly/umean.nc")
wlon    = ncvar_get(ncfile,"longitude")
wlon[which(wlon>180)]=wlon[which(wlon>180)]-360
wlat    = (ncvar_get(ncfile,"latitude"))
u	= as.array(ncvar_get(ncfile,"p71.162"))	# u-wind
ncfile	= nc_open("/scratch/gent/vo/000/gvo00090/vsc42383/eradata/vimt_monthly/vmean.nc")
v	= as.array(ncvar_get(ncfile,"p72.162"))	# v-wind
u	= raster(t(u))#raster(t(u)[ncol(u):1, ])
v 	= raster(t(v))#raster(t(v)[ncol(v):1, ])
w	= brick(u,v)
#projection(w) <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")#CRS("+init=ellps:WGS84")
projection(w) <- CRS("+init=epsg:4326")
#crs(w) <-"+init=epsg:4326"
#projection(w) <- CRS("+init=ellps:WGS84")
extent(w) <- c(min(wlon), max(wlon), min(wlat), max(wlat))
#newproj <- CRS("+proj=longlat +datum=WGS84")#CRS("+init=ellps:WGS84")
#w = projectRaster(w, CRS("+proj=longlat +datum=WGS84"))
# plot(w[[1]]): plot(w[[2]])
# vectorplot(w, isField = "dXY", region = FALSE, margin = FALSE, narrows = 100)
slope <- sqrt(w[[1]]^2 + w[[2]]^2)
aspect <- atan2(w[[1]], w[[2]])

ncfile	= nc_open("/scratch/gent/vo/000/gvo00090/vsc42383/eradata/vimt_monthly/vimtdmean_summer_box.nc")
vimtd	= as.array(ncvar_get(ncfile,"p84.162"))#*86400 #to get mm/d
vimtd	= raster(t(vimtd))#raster(t(vimtd)[ncol(vimtd):1,])
#projection(vimtd) <- CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")#CRS("+init=ellps:WGS84")
projection(vimtd) <- CRS("+init=epsg:4326")
extent(vimtd) <- c(min(wlon), max(wlon), min(wlat), max(wlat))

#vectorplot(w, isField = "dXY", 
#	   region = slope, margin = FALSE, narrows = 100, at = 0:10)
#vectorplot(stack(slope , aspect), isField = TRUE, region = slope, margin = FALSE)

#vectorplot(w, isField = "dXY", region = slope, margin = FALSE, xlim=c(-60,60),ylim=c(20,80), narrows=5000, at=0:10, col.regions=brewer.pal("RdBu",n=10)
#	  ) + layer(sp.polygons(coastlines))
mybreaks=seq(-5,5,0.5)
vectorplot(w, isField = "dXY", region = vimtd, margin = FALSE, xlim=c(-60,60),ylim=c(20,80), narrows=3500, col.regions=colorRampPalette(rev(brewer.pal("RdBu",n=11)))(length(mybreaks)), at=mybreaks)+ layer(sp.polygons(coastlines))

vectorplot(w, isField = "dXY", region = vimtd, margin = FALSE, narrows=2500, col.regions=colorRampPalette(rev(brewer.pal("RdBu",n=11)))(length(mybreaks)), at=mybreaks)+ layer(sp.polygons(coastlines))

