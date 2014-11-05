setwd("~/Documents/Core /TELUS/security intelligence")
pkg <- c("bitops", "ggplot2", "maps", "maptools",
          "sp", "maps", "grid", "car")
new.pkg <- pkg[!(pkg %in% installed.packages())]
if(length(new.pkg)){
  install.packages(new.pkg)
}

library(bitops)

ip2long <-function(ip){
  ips<-unlist(strsplit(ip,'.', fixed=TRUE))
  octet <- function(x,y) bitOr(bitShiftL(x,8),y)
  Reduce(octet, as.integer(ips))

}

long2ip <- function(longip){
  octet <-function(nbits) bitAnd(bitShiftR(longip, nbits),0xFF)
  paste(Map(octet, c(24,16,8,0)), sep="", collapse=".")
}

#test functionality
#long2ip(ip2long("192.168.0.0"))
#long2ip(ip2long("192.168.100.6"))


# Listing 4-2
# requires packages: bitops
# requires all objects from 4-1
# Define function to test for IP CIDR membership
# take an IP address (string) and a CIDR (string) and
# return whether the given IP address is in the CIDR range
ip.is.in.cidr <- function(ip, cidr) {
  long.ip <- ip2long(ip)
  cidr.parts <- unlist(strsplit(cidr, "/"))
  cidr.range <- ip2long(cidr.parts[1])
  cidr.mask <- bitShiftL(bitFlip(0), (32-as.integer(cidr.parts[2])))
  return(bitAnd(long.ip, cidr.mask) == bitAnd(cidr.range, cidr.mask))
}

ip.is.in.cidr("10.0.1.15","10.0.1.3/24")
## TRUE
ip.is.in.cidr("10.0.1.15","10.0.2.255/24")
## FALSE

# Listing 4-3
# R code to extract longitude/latitude pairs from AlienVault data
# read in the AlienVault reputation data
avRep <- "data/reputation.data"
av.df <- read.csv(avRep, sep="#", header=FALSE)
colnames(av.df) <- c("IP", "Reliability", "Risk", "Type",
                     "Country", "Locale", "Coords", "x")

# create a vector of lat/long data by splitting on ","
av.coords.vec <- unlist(strsplit(as.character(av.df$Coords), ","))
# convert the vector in a 2-column matrix
av.coords.mat <- matrix(av.coords.vec, ncol=2, byrow=TRUE)
# project into a data frame
av.coords.df <- as.data.frame(av.coords.mat)
# name the columns 
colnames(av.coords.df) <- c("lat","long")
# convert the characters to numeric values
av.coords.df$long <- as.double(as.character(av.coords.df$long))
av.coords.df$lat <- as.double(as.character(av.coords.df$lat))

# Listing 4-4
# requires packages: ggplot2, maps, RColorBrewer, scales
# requires object: av.coords.df (4-3)
# generates Figure 4-2
# R code to extract longitude/latitude pairs from AlienVault data
# need plotting and mapping functions plus colors
library(ggplot2)
library(maps)
library(RColorBrewer)
library(scales)


# extract a color palette from the RColorBrewer package
set2 <- brewer.pal(8,"Set2")

# extract the polygon information for the world map, minus Antarctica
world <- map_data('world')
world <- subset(world, region != "Antarctica")

# plot the map with the points marking lat/lon of the geocoded entries
# plotting ~200K takes a bit of time
# Chapter 5 examples explain mapping in greater detail
gg <- ggplot()
gg <- gg + geom_polygon(data=world, aes(long, lat, group=group), 
                        fill="white")
gg <- gg + geom_point(data=av.coords.df, aes(x=long, y=lat),  
                      color=set2[2], size=1, alpha=0.1)
gg <- gg + labs(x="", y="")
gg <- gg + theme(panel.background=element_rect(fill=alpha(set2[3],0.2), 
                                               colour='white'))
gg