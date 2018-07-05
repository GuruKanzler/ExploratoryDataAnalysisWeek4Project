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
nei_vehicles_baltimore <- nei_vehicles[nei_vehicles$fips == "24510",]
nei_vehicles_losangeles <- nei_vehicles[nei_vehicles$fips == "06037",]

# Add city column
nei_vehicles_baltimore$city <- "Baltimore"
nei_vehicles_losangeles$city <- "LosAngeles"

# Combine data
nei_vehicles_bothcities <- rbind(nei_vehicles_baltimore, nei_vehicles_losangeles)

# Create and plot graph
g <- ggplot(nei_vehicles_bothcities, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year), stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  guides(fill = F) + 
  theme_bw() +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore & LA, 1999-2008"))

print(g)

# Save plot to file
png('plot6.png', width = 800, height = 500, units = "px")
print(g)
dev.off()







