# R code to answer the following question:
#   Across the United States, how have emissions from coal 
#   combustion-related sources changed from 1999–2008?

# Library
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find relevant SCC's. "ccs" = coal combustion sources.
ccs <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal",]["SCC"]

# Subset NEI based on relevant SSC's. "efc" = emissions from coal.
efc <- NEI[NEI$SCC %in% ccs$SCC,]

# Plotting coal combustion related emissions per year. (Optional)
g <- ggplot(efc,aes(factor(year),Emissions)) +
      geom_bar(stat = "identity", fill = "red", width = 0.75) +
      theme_bw() +  
      guides(fill = F) +
      labs(x = "year", y = expression("Total PM"[2.5]*" Emission")) + 
      labs(title = expression("PM"[2.5]*" Coal Combustion Emissions Across US 1999-2008"))

print(g)

# Plot to file
png('plot4.png', width = 800, height = 500, units = "px")
print(g)
dev.off()






