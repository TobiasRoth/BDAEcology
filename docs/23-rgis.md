
# Spatial analyses and maps {#rgis}

## Hintergrund
Some useful packages
- `raster`: Very efficient for raster data.
- `sf`: Very efficient package for data other than raster data. It also link to GEOS, GDAL proj.4.


```r
library(sf)
library(raster)
```

## Coordinate systems
The following are some definitions of coordinate systems that I often use:


```r
ch1903 <- CRS("+init=epsg:21781")       # Old Swiss grid 1903
chLV95 <- CRS("+init=epsg:2056")        # New Swiss grid 1903+ 
wgs84 <-   CRS("+init=epsg:4326")       # WGS 84
```

The following code transfers a spatial point from one coordinate reference system to an ohter:


```r
pt <- data.frame(x=650007.0, y=227023.0)
coordinates(pt) <- ~ x + y
proj4string(pt) <-   ch1903 
spTransform(pt, chLV95)
```

```
## class       : SpatialPoints 
## features    : 1 
## extent      : 2650007, 2650007, 1227023, 1227023  (xmin, xmax, ymin, ymax)
## coord. ref. : +init=epsg:2056 +proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs
```



