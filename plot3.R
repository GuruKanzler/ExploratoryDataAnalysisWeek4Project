# R code to answer the following question:
#   Of the four types of sources indicated by the 
#   \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
#   which of these four sources have seen decreases in emissions from 
#   1999–2008 for Baltimore City? Which have seen increases in emissions from 
#   1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Library
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

agg_type_year <- aggregate(NEI$Emissions, list(NEI$type, NEI$year),mean)
g <- ggplot(agg_type_year, aes(y=x, x=Group.2))+geom_point(aes(colour = factor(Group.1)), size = 4)
g+geom_line(aes(group=Group.1,colour=Group.1))


# Subsetting
BaltEM <- subset(NEI, fips == 24510)

# Factoring $year
BaltEM$year <- factor(BaltEM$year, levels = c("1999", "2002", "2005", "2008"))

png(filename='~/Exploratory_Data_Analysis/Assignment_2/plot3.png', width=800, height=500, units='px')

ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') +
  geom_jitter(alpha=0.10)

dev.off()

head(BaltEM)

# Barplotting (optional)
ggplot(data = BaltEM, aes(x = year, y = log(Emissions))) +
  facet_grid(. ~type) +
  guides(fill=F) + 
  geom_boxplot(aes(fill = type)) +
  stat_boxplot(geom = 'errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
  xlab('Year') +
  ggtitle("Emissions per type; Baltimore") +
  geom_jitter(alpha = 0.05)

# Save barplot to file
png('plot3.png', width = 800, height = 500, units = "px")

ggplot(data = BaltEM, aes(x = year, y = log(Emissions))) +
  facet_grid(. ~type) +
  guides(fill=F) + 
  geom_boxplot(aes(fill = type)) +
  stat_boxplot(geom = 'errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) +
  xlab('Year') +
  ggtitle("Emissions per type; Baltimore") +
  geom_jitter(alpha = 0.05)

dev.off()