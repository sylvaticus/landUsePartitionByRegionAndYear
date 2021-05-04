# luse overview: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=overview
# luse documentation: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=doc
# manual download form: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=form
# api instructions: https://cds.climate.copernicus.eu/api-how-to

# archive download: http://maps.elie.ucl.ac.be/CCI/viewer/download.php


# The maps can be transformed to the GeoTiff format using GDAL as follows, replacing Year, Band_Name and Output_Filename with the parameters of interest:
# gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-Year-v2.1.1.nc:BandName OutputFilename.tif

# with Year the year : 2016, 2017, 2018 or 2019; and BandName one of the following: lccs_class; processed_flag; current_pixel_state; observation_count; change_count.

# Example code translating the 2017 LC map from netCDF to GeoTiff:
# gdalwarp -of Gtiff -co COMPRESS=LZW -co TILED=YES -ot Byte -te -180.0000000 -90.0000000 180.0000000 90.0000000 -tr 0.002777777777778 0.002777777777778 -t_srs EPSG:4326 NETCDF:C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.nc:lccs_class C3S-LC-L4-LCCS-Map-300m-P1Y-2017-v2.1.1.tif 
# 1992-2015 maps download tiff  directly:

# wget ftp://geo10.elie.ucl.ac.be/v207/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.zip

import cdsapi

c = cdsapi.Client()

#c.retrieve(
#    'satellite-land-cover',
#    {
#        'year': [
#            '1992', '1993', '1994',
#            '1995', '1996', '1997',
#        ],
#        'version': 'v2.0.7cds',
#        'variable': 'all',
#        'format': 'tgz',
#    },
#    'luse1992-1997.tar.gz')

#c.retrieve(
#    'satellite-land-cover',
#    {
#        'year': [
#            '1998', '1999', '2000',
#            '2001', '2002', '2003',
#        ],
#        'version': 'v2.0.7cds',
#        'variable': 'all',
#        'format': 'tgz',
#    },
#    'luse1998-2003.tar.gz')

#c.retrieve(
#    'satellite-land-cover',
#    {
#        'year': [
#            '2004', '2005', '2006','2007', '2008', '2009',
#        ],
#        'version': 'v2.0.7cds',
#        'variable': 'all',
#        'format': 'tgz',
#    },
#    'luse2004-2009.tar.gz')

#c.retrieve(
#    'satellite-land-cover',
#    {
#        'year': [
#            '2010', '2011', '2012','2013', '2014', '2015',
#        ],
#        'version': 'v2.0.7cds',
#        'variable': 'all',
#        'format': 'tgz',
#    },
#    'luse2010-2015.tar.gz')


c.retrieve(
    'satellite-land-cover',
    {
        'year': [
            '2016', '2017', '2018','2019',
        ],
        'version': 'v2.1.1',
        'variable': 'all',
        'format': 'tgz',
    },
    'luse2016-2019.tar.gz')
