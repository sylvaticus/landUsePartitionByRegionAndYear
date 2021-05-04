# ## Main shell script to download world land use cover and world regions and to compute luse summary statistics by region ##

# If needed, create the directory:
# mkdir luse

# (1) Retrieving 1992-2015 luse data
wget -O ./luse/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip ftp://geo10.elie.ucl.ac.be/v207/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip

cd luse

unzip ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip 
mv scratch/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.tif .
rm -rf scratch/
rm -rf ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip

# (2) Retrieving 2016-2019 luse data
# python downloadLUse.py

tar -xzf luse2016-2019.tar.gz

gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-2016-v2.1.1.nc:lccs_class C3S-LC-L4-LCCS-Map-300m-P1Y-2016-v2.1.1.tif

gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.nc:lccs_class C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.tif

gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-2018-v2.1.1.nc:lccs_class C3S-LC-L4-LCCS-Map-300m-P1Y-2018-v2.1.1.tif

gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-2019-v2.1.1.nc:lccs_class C3S-LC-L4-LCCS-Map-300m-P1Y-2019-v2.1.1.tif

rm -rf C3S-LC-L4-LCCS-Map-300m-P1Y-2016-v2.1.1.nc
rm -rf C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.nc
rm -rf C3S-LC-L4-LCCS-Map-300m-P1Y-2018-v2.1.1.nc
rm -rf C3S-LC-L4-LCCS-Map-300m-P1Y-2019-v2.1.1.nc
#rm -rf luse2016-2019.tar.gz

# (3) Download administrative areas
cd ..

# If needed, create the directory:
# mkdir adminAreas
# mkdir adminAreas/byLevels
wget -O ./adminAreas/byLevels/gadm36_levels_shp.zip https://biogeo.ucdavis.edu/data/gadm3.6/gadm36_levels_shp.zip

cd adminAreas/byLevels
unzip gadm36_levels_shp.zip 
rm -rf gadm36_levels_shp.zip 

# (4) Compute the statistics..
cd ../..

# If needed, create the directory:
# mkdir out-computedLUseStatsByRegionAndYear
julia computeZonalStats.jl







