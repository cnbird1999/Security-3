##load in the necessary libraries to make this all work
library(ggplot2)

#End of libraries

##set global/environmental variables
setwd("~/Documents/Core /TELUS/security intelligence")

#End of environmental variables


##set up variables for downloading of the relevant data 
avURL <- "http://datadrivensecurity.info/book/ch03/data/reputation.data"
avRep <- "data/reputation.data"

#check to see if file already downloaded 
if (file.access(avRep)) {  
  download.file(avURL, avRep)
}

#Load the data into the appropiate dataframe
av <- read.csv(avRep,sep="#", header=FALSE)

#Give data some menaingful colimn names
colnames(av) <-c("IP", "Reliability", "Risk", "Type", "Country",
                 "Locale", "Coords", "x")

#Run sme very exploratory analysis of the data to validate 
str(av)
head(av)
summary(av$Reliability)
summary(av$Risk)

#Subset the data for a particular region 
us <- subset(av, Country == "CA" & Locale == "Vancouver")
head(us)


summary(av$Country, maxsum=40)

##test some basic gplot of the data

#get the top 20 country names
country.top20 <- (names(summary(av$Country))[1:20])

#subset the data and plot
gg <- ggplot(data=subset(av,Country %in% country.top20), 
             aes(x=reorder(Country, Country, length)))
gg <- gg + geom_bar(fill="#000099")


#cleanup the gg labels
gg <- gg + labs(title="Country Counts",
                x="Country", y="Count")
#rotate
gg <- gg +coord_flip()

gg <- gg + theme(panel.grid=element_blank(),
               panel.background=element_blank())

print(gg)

##Working on cotigency tables
rr.tab <-xtabs(~Risk+Reliability, data=av)
ftable(rr.tab) #print table

#graph view of levelplot using lattice
library(lattice)
rr.df = data.frame(table(av$Risk, av$Reliability))

#set column names
colnames(rr.df) <- c("Risk", "Reliability", "Freq")

levelplot(Freq~Risk*Reliability, data=rr.df, main="Risk~Reliability",
          ylab= "Reliability", xlab = "Risk", shrink=c(0.5,1),
          col.regions = colorRampPalette(c("#F5F5F5", "#01665E"))(20))



##Random Samples
set.seed(1492) 

#generate 260,000 random samples
rel=sample(1:7, 260000, replace=T)
rsk=sample(1:10, 260000, replace=T)

#cast table into dataframe
tmp.df = data.frame(table(factor(rsk), factor(rel)))

colnames(tmp.df) <- c("Risk", "Reliability", "Freq")

levelplot(Freq~Risk*Reliability, data=tmp.df, main="Risk~Reliability",
          ylab= "Reliability", xlab = "Risk", shrink=c(0.5,1),
          col.regions = colorRampPalette(c("#F5F5F5", "#01665E"))(20))


##three way risk/reliability/type contigency table
av$simpletype <- as.character(av$Type)
av$simpletype[grep(';', av$simpletype)] <- "Multiples"
av$simpletype <- factor(av$simpletype)

rrt.df = data.frame(table(av$Risk, av$Reliability, av$simpletype))
colnames(rrt.df) <- c("Risk", "Reliability", "simpletype", "Freq")

levelplot(Freq~Risk*Reliability|simpletype, data=rrt.df, 
          main="Risk~Reliability | Type", 
          ylab= "Risk", xlab = "Reliability", shrink=c(0.5,1),
          col.regions = colorRampPalette(c("#F5F5F5", "#01665E"))(20))

#Without scanning host
rrt.df <- subset(rrt.df, simpletype !="Scanning Host")

levelplot(Freq~Risk*Reliability|simpletype, data=rrt.df, 
          main="Risk~Reliability | Type", 
          ylab= "Risk", xlab = "Reliability", shrink=c(0.5,1),
          col.regions = colorRampPalette(c("#F5F5F5", "#01665E"))(20))

#Final
rrt.df=subset(rrt.df,
              !(simpletype %in% c("Malware distribution",
                                  "Malware Domain")))
sprintf("Count: %d; Percent: %2.1f%%",
        sum(rrt.df$Freq),
        100*sum(rrt.df$Freq)/nrow(av))

levelplot(Freq~Risk*Reliability|simpletype, data=rrt.df, 
          main="Risk~Reliability | Type", 
          ylab= "Risk", xlab = "Reliability", shrink=c(0.5,1),
          col.regions = colorRampPalette(c("#F5F5F5", "#01665E"))(20))
