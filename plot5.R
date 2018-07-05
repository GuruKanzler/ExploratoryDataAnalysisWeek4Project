# R code to answer the following question:
#   How have emissions from motor vehicle sources changed from 1999–2008 
#   in Baltimore City?

# Library stuff
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find vehicle related data
v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
scc_vehicles <- SCC[v,]$SCC
nei_vehicles <- NEI[NEI$SCC %in% scc_vehicles,]

# Focus on Baltimore data
nei_vehicles_baltimore <- nei_vehicles[nei_vehicles$fips == 24510,]

# Plot vehicle data related to Balitmore
g <- ggplot(nei_vehicles_baltimore,aes(factor(year),Emissions)) +
      geom_bar(stat = "identity",fill = "pink",width = 0.75) +
      theme_bw() +  
      guides(fill = F) +
      labs(x = "year", y = expression("Total PM"[2.5]*" Emission")) + 
      labs(title = expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore 1999-2008"))

print(g)

# Plot to file
png('plot5.png', width = 800, height = 500, units = "px")
print(g)
dev.off()