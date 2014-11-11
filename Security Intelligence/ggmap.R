library(ggmap)
library(ggpplot2)

la <- get_map(location="Los Angeles", zoom=10, color="bw", maptype="toner")

# get base map layer
gg <- ggmap(la) 