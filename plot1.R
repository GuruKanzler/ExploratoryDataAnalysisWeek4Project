# R code to answer the following question:
#   Have total emissions from PM2.5 decreased in the United States 
#   from 1999 to 2008? Using the base plotting system, make a plot 
#   showing the total PM2.5 emission from all sources for each of 
#   the years 1999, 2002, 2005, and 2008.

## Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Aggregate
EmissionsAgg <- aggregate(NEI[,'Emissions'], by=list(NEI$year), sum)

# Change columns names
names(EmissionsAgg) <- c("year", "TotEmission")

# Barplotting (optional)
barplot(EmissionsAgg$TotEmission
        , names.arg = EmissionsAgg$year
        , xlab = "year"
        , ylab = "Emission per year"
        , main = "PM2.5 Emission Totals"
        )

# Save barplot to file
png('plot1.png')

barplot(EmissionsAgg$TotEmission
        , names.arg = EmissionsAgg$year
        , xlab = "year"
        , ylab = "Emission per year"
        , main = "PM2.5 Emission Totals"
        )

dev.off()
