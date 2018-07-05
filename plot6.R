# R code to answer the following question:
#   Compare emissions from motor vehicle sources in Baltimore City 
#   with emissions from motor vehicle sources in Los Angeles County, 
#   California (\color{red}{\verb|fips == "06037"|}fips=="06037"). 
#   Which city has seen greater changes over time in motor vehicle emissions?

# Library stuff
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find vehicle related data
v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
scc_vehicles <- SCC[v,]$SCC
nei_vehicles <- NEI[NEI$SCC %in% scc_vehicles,]

# Focus on Baltimore and  Los Angeles data
nei_vehicles_baltimore <- nei_vehicles[nei_vehicles$fips == 24510,]
nei_vehicles_losangeles <- nei_vehicles[nei_vehicles$fips == 06037,]



