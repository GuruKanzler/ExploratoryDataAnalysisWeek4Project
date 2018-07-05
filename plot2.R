# R code to answer the following question:
#   Have total emissions from PM2.5 decreased in the Baltimore City, 
#   Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 
#   1999 to 2008? Use the base plotting system to make a plot 
#   answering this question.

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting
BaltimoreEm <- NEI[which(NEI$fips == 24510),]

# Aggregate
BaltimoreEmAgg <- aggregate(BaltimoreEm[,'Emissions'], by=list(BaltimoreEm$year), sum)

# Change names
names(BaltimoreEmAgg) <- c("year", "emissions")

# Barplotting (optional)
barplot(BaltimoreEmAgg$emission
        , names.arg = BaltimoreEmAgg$year
        , xlab = "year"
        , ylab = "Emission per year"
        , main = "Baltimore PM2.5 Emission Totals"
)

# Save barplot to file
png('plot2.png')

barplot(BaltimoreEmAgg$TotEmission
        , names.arg = BaltimoreEmAgg$year
        , xlab = "year"
        , ylab = "Emission per year"
        , main = "PM2.5 Emission Totals"
)

dev.off()
