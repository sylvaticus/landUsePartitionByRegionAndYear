# https://pythonhosted.org/rasterstats/manual.html#raster-data-sources

println("Welcome... computing land use by region and year [1992-2019]...")

cd(@__DIR__)
using Pkg
Pkg.activate(".")
Pkg.instantiate()

#Pkg.add("PyCall")
#Pkg.add("DataFrames")
#Pkg.add("CSV")
#Pkg.add("Tables")
using PyCall, Tables, DataFrames, CSV

vectorBoundariesFile     = "./adminAreas/byLevels/gadm36_1.shp"
rasterDataFile_1992_2015 = "./luse/ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992_2015-v2.0.7.tif"

sqKmPerCell          = (300*300)/(1000*1000)

const rs  = pyimport("rasterstats")
const gpd = pyimport("geopandas")

println("Modules loaded, reading the regions definition shapefile..")

regdf     = gpd.read_file(vectorBoundariesFile)
gid_0     = convert(Vector{String},regdf.GID_0)
name_0    = convert(Vector{String},regdf.NAME_0)
gid_1     = convert(Vector{String},regdf.GID_1)
name_1    = convert(Vector{String},regdf.NAME_1)
nRegions  = length(gid_0)

# see https://datastore.copernicus-climate.eu/documents/satellite-land-cover/D3.3.12-v1.3_PUGS_ICDR_LC_v2.1.x_PRODUCTS_v1.3.pdf
# Attention that the classification is hierarchical, e.g. "60" includes also "61" and "62"
luseIds = [ 10,  11,  12,  20,  30,  40,  50,  60,  61,  62,  70,  71,  72,
            80,  81,  82,  90, 100, 110, 120, 121, 122, 130, 140, 150, 151,
           152, 153, 160, 170, 180, 190, 200, 201, 202, 210, 220]
headersForExport = vcat("gid_0","name_0","gid_1","name_1",string.(luseIds)...)

years = 1992:2019
years = 2015:2019

for year in years
    println("Starting processing year $(year)...")
    if year <= 2015
        band = year-1992+1
        stats   = rs.zonal_stats(vectorBoundariesFile, rasterDataFile_1992_2015, band=band, categorical=true)  # stats=['count', 'mean', 'count','sum']
        stats   = convert(Vector{Dict{Int64,Int64}},stats)
        length(stats) == nRegions || @error "Oug, we have different number of regions in these computed stats!"
    else
        yearlyRasterFile = "./luse/C3S-LC-L4-LCCS-Map-300m-P1Y-$(year)-v2.1.1.tif"
        stats   = rs.zonal_stats(vectorBoundariesFile, yearlyRasterFile, band=1, categorical=true)  # stats=['count', 'mean', 'count','sum']
        stats   = convert(Vector{Dict{Int64,Int64}},stats)
        length(stats) == nRegions || @error "Oug, we have different number of regions in these computed stats!"
    end
    luseValues = [get(stat,luc,0) for stat in stats, luc in luseIds]
    yearlUseValue = hcat(gid_0,name_0,gid_1,name_1,luseValues)
    CSV.write("./out-computedLUseStatsByRegionAndYear/lUseByLev1Regions_$(year).csv",Tables.table(yearlUseValue), delim=';', header=headersForExport)
end

println("** Done!")
