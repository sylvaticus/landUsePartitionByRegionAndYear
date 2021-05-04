# Land Use partitioned by sub-national region and year (1992-2019)


[![DOI](https://zenodo.org/badge/364212542.svg)](https://zenodo.org/badge/latestdoi/364212542)


## What is this ?

This archive reports the land use partitioned by sub-national administrative region and year, i.e. for each year a table reports the count of each land-use class per region.
Data is available as one CSV file per year in the folder "out-computedLUseStatsByRegionAndYear".

This archive contains also the set of scripts used to compute that partition (including input data download) and that can be easily modified to retrieve a partition by a different geographical level.

## Warnings

- This data should only be used to compute the _relative_ ratio of each land-use class in each region. Due to several issues in projecting the data, the sum of the counts multiplied by the nominal area of each pixel (90000 sq.m) is **NOT** equal to the area of the region. However the shares of land uses should remain invariant to the projections and unbiased.
- By construction, land use classes are hierarchically organised. For example, to obtain land use in class "Tree cover, broadleaved, deciduous, closed to open (>15%) (class 60), one has to sum the cells in classes 60+61+62. Same for classes 10, 70, 80, 120, 150 and 200.

## Data Sources

### Land use

Land Cover Maps - v2.0.7 and v2.1.1 from the Climate Research Data Package (CRDP) http://maps.elie.ucl.ac.be/CCI/viewer/download.php (300m x 300m resolution)
- overview: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=overview
- documentation: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=doc
- manual download form: https://cds.climate.copernicus.eu/cdsapp#!/dataset/satellite-land-cover?tab=form
- api instructions: https://cds.climate.copernicus.eu/api-how-to
- archive download: http://maps.elie.ucl.ac.be/CCI/viewer/download.php

| ClassID | ClassNames                                                                         |
|---------|------------------------------------------------------------------------------------|
| 10      | Cropland, rainfed                                                                  |
| 11      | Herbaceous cover                                                                   |
| 12      | Tree or shrub cover                                                                |
| 20      | Cropland, irrigated or post-flooding                                               |
| 30      | Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%) |
| 40      | Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%) |
| 50      | Tree cover, broadleaved, evergreen, closed to open (>15%)                          |
| 60      | Tree cover, broadleaved, deciduous, closed to open (>15%)                          |
| 61      | Tree cover, broadleaved, deciduous, closed (>40%)                                  |
| 62      | Tree cover, broadleaved, deciduous, open (15-40%)                                  |
| 70      | Tree cover, needleleaved, evergreen, closed to open (>15%)                         |
| 71      | Tree cover, needleleaved, evergreen, closed (>40%)                                 |
| 72      | Tree cover, needleleaved, evergreen, open (15-40%)                                 |
| 80      | Tree cover, needleleaved, deciduous, closed to open (>15%)                         |
| 81      | Tree cover, needleleaved, deciduous, closed (>40%)                                 |
| 82      | Tree cover, needleleaved, deciduous, open (15-40%)                                 |
| 90      | Tree cover, mixed leaf type (broadleaved and needleleaved)                         |
| 100     | Mosaic tree and shrub (>50%) / herbaceous cover (<50%)                             |
| 110     | Mosaic herbaceous cover (>50%) / tree and shrub (<50%)                             |
| 120     | Shrubland                                                                          |
| 121     | Shrubland evergreen                                                                |
| 122     | Shrubland deciduous                                                                |
| 130     | Grassland                                                                          |
| 140     | Lichens and mosses                                                                 |
| 150     | Sparse vegetation (tree, shrub, herbaceous cover) (<15%)                           |
| 151     | Sparse tree (<15%)                                                                 |
| 152     | Sparse shrub (<15%)                                                                |
| 153     | Sparse herbaceous cover (<15%)                                                     |
| 160     | Tree cover, flooded, fresh or brakish water                                        |
| 170     | Tree cover, flooded, saline water                                                  |
| 180     | Shrub or herbaceous cover, flooded, fresh/saline/brakish water                     |
| 190     | Urban areas                                                                        |
| 200     | Bare areas                                                                         |
| 201     | Consolidated bare areas                                                            |
| 202     | Unconsolidated bare areas                                                          |
| 210     | Water bodies                                                                       |


### Administrative borders

GADM (https://gadm.org)


## Instructions to compute the partition

- Install the CDS API key as described on https://cds.climate.copernicus.eu/api-how-to
- Run the `runLandUsePartition.sh` shell script in a Linux environment (tested on Ubuntu 20.04)

## Requirements

- Linux OS (tested on Ubuntu 20.04)
- Python 3 and python modules `cdsapi`, `rasterstats` and `geopandas` on path
- Julia 1.6 (the julia packages `PyCall`, `DataFrames`, `CSV` and `Tables` will be automatically downloaded and installed in a local environmant by the script itself)

## Cite as

Antonello Lobianco. (2021). Land use partitioned by region (sub-national) and year (1992-2019) (Version v0.0.1) [Data set]. Zenodo. http://doi.org/10.5281/zenodo.4736886

## Licence

The script and the partitioned data are Copyright Antonello Lobianco (2021) released under the MIT licence.
Input data belong to the authoring organisations.

## Acknowledgements

The development of this dataset at the _Bureau d'Economie Théorique et Appliquée_ (BETA, Nancy) was supported by the French National Research Agency through the [Laboratory of Excellence ARBRE](http://mycor.nancy.inra.fr/ARBRE/), a part of the “Investissements d'Avenir” Program (ANR 11 – LABX-0002-01).

[![BLogos](assets/logos_betaumr.png)](hhttp://www.beta-umr7522.fr/)
