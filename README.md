# vimt
Scripts to calculate and plot the vertically integrated moisture transport using ERA-Interim data

## Data
Downloaded data from https://apps.ecmwf.int/datasets/data/interim-full-moda/levtype=sfc/
The following variables are needed: 
- "Vertical integral of eastward water vapour flux" (p71.162)
- "Vertical integral of northward water vapour flux" (p72.162)
- "Vertical integral of divergence of moisture flux" (p.84.162)
Downloaded as annual files with monthly values. 

## VIMT calculation
```bash
./calc_vimt.sh
```

## VIMT plot
```bash
Rcsript plot_vimt.r
```

This script also uses coastline data (ne_coastlines_10m shapefiles from http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_coastline.zip), downloadable with R as

```bash
download.file("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/physical/ne_10m_coastline.zip", destfile = 'coastlines.zip')
```

