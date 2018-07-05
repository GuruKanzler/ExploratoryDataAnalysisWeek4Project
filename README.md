# Introduction
Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In 
the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine 
PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on 
emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at 
the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of 
the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

## Review criteria 
For each question

1. Does the plot appear to address the question being asked?
2. Is the submitted R code appropriate for construction of the submitted plot?

## Data 
The data for this assignment are available from the course web site as a single zip file:

* [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, 
and 2008. For each year, the table contains number of **tons** of PM2.5 emitted from a specific type of source for the entire year. 
Here are the first few rows.

````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* fips: A five-digit number (represented as a string) indicating the U.S. county
* SCC: The name of the source as indicated by a digit string (see source code classification table)
* Pollutant: A string indicating the pollutant
* Emissions: Amount of PM2.5 emitted, in tons
* type: The type of source (point, non-point, on-road, or non-road)
* year: The year of emissions recorded

Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the 
Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to 
more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known 
as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS() function in R. For example, reading in each file can be done with the 
following code:
````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling \color{red}{\verb|dir()|}dir() and see if 
those files are in the listing).

# Assignment
The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support 
your analysis.

## Making and Submitting Plots 
For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs 
the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must 
also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code 
for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.
* You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make 
a single plot. Unless specified, you can use any plotting system in R to make your plot.

# Questions & code to answer them
0. Initial activities include manual downloading and extracting of data (see link further up), then loading the data into R using:
````r
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````
Above initialization of data is used for all questions below.

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot 
showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
````r
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
````
**Answer:** Yes.
2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008? Use the base 
plotting system to make a plot answering this question.
````r
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
````
**Answer:** Yes, but the data is jumpy.

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use 
the ggplot2 plotting system to make a plot answer this question.
````r
# Library
library(ggplot2)

# Subsetting
BaltEM <- subset(NEI, fips == 24510)

# Factoring $year
BaltEM$year <- factor(BaltEM$year, levels = c("1999", "2002", "2005", "2008"))

# Barplotting - one boxtplot per type
g <- ggplot(data = BaltEM, aes(x = year, y = log(Emissions))) +
      facet_grid(. ~type) +
      guides(fill = F) + 
      geom_boxplot(aes(fill = type)) +
      stat_boxplot(geom = 'errorbar') +
      ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
      xlab('Year') +
      ggtitle("Emissions per type; Baltimore") +
      geom_jitter(alpha = 0.05)
print(g)

# Save barplot to file
png('plot3b.png', width = 800, height = 500, units = "px")
print(g)
dev.off()
````
**Answer:** decreases: non-road, on-road, and point. 
Increases: none. The nonpoint type remains unchanged over the years.

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
````r
# Library
library(ggplot2)

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
````
**Answer:** Emissions from coal combustion-related sources have decreased.

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
````r
# Library
library(ggplot2)

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
````
**Answer:** Emissions from motor vehicles in Baltimore City have decreased.

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
California fips == "06037". Which city has seen greater changes over time in motor vehicle emissions?
````r
# Library
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
````
**Answer:** There's a decrease in Baltimore, whereas there's an increase in Los Angeles County. Relatively speaking, the change seems 
to be bigger in Baltimore.
