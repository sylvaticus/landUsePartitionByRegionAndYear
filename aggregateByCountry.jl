println("Welcome... aggregating by country and year [1992-2019]...")

# Note: this is a separate script just for my needs, as the (main) computation by region was already done and
# I have to make just this (small) task.
# It would be better integrated in the main script, but it change little, as the task of this script is
# computationally very small

cd(@__DIR__)
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using CSV, DataFrames

luseIds = [ 10,  11,  12,  20,  30,  40,  50,  60,  61,  62,  70,  71,  72,
            80,  81,  82,  90, 100, 110, 120, 121, 122, 130, 140, 150, 151,
           152, 153, 160, 170, 180, 190, 200, 201, 202, 210, 220]
years = 1992:2019

countryData = DataFrame(cID = String[], country=String[], year=Int64[],luseID=String[],sumRegArea=Int64[])

for thisYear in years
    yearData = CSV.read("./out-computedLUseStatsByRegionAndYear/lUseByLev1Regions_$(thisYear).csv", DataFrame, delim=';')
    yearStacked = stack(yearData,string.(luseIds))
    select!(yearStacked,Not([:gid_1,:name_1]))
    cYearData = combine(groupby(yearStacked,[:gid_0,:variable])) do subdf
        return (cID=subdf.gid_0[1], country=subdf.name_0[1], year = thisYear, luseID = subdf.variable[1], sumRegArea = sum(subdf.value))
    end
    select!(cYearData,Not([:gid_0,:variable]))
    countryData = vcat(countryData,cYearData)
end

cDataLong = unstack(countryData,:luseID,:sumRegArea)
CSV.write("./out-computedLUseStatsByRegionAndYear/lUseByCountry.csv",cDataLong, delim=';')
