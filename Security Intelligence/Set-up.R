####The purpose of this project is to start bringing together the necessary 
##scripts I require to do security aalysis  These will allow for a full 
#understanding of the variety of security environments from a data analytics 
#persepctive


###Import OSINT data and clean as required and format into the standard analysis
##framework we are using

#set-up this are all the requirements for a standadr analysis machine that I 
#would use" will need to be changed if on a different machine.

#The main functions are
#1)Set-up analysis machine
#2)Capability to download OSINT IP information off the web and merge into 
#single file structure as designed
#3)Run basic analysis verification on these files tomake sure data is clean and valid
#4)

#check for existience of directory if not there then create it

mkdir . . .

install.packages()
#install the package for VCDB
##install verisr
install_github("verisr","jayjaobs")




####Functio session for repeat activity

####modified freegoip function to translate IP Address to geo information


freegeoip <- function(ip, format = ifelse(length(ip)==1,'list','dataframe'))
{
  if (1 == length(ip))
  {
    # a single IP address
    require(rjson)
    url <- paste(c("http://freegeoip.net/json/", ip), collapse='')
    ret <- fromJSON(readLines(url, warn=FALSE))
    if (format == 'dataframe')
      ret <- data.frame(t(unlist(ret)))
    return(ret)
  } else {
    ret <- data.frame()
    for (i in 1:length(ip))
    {
      r <- freegeoip(ip[i], format="dataframe")
      ret <- rbind(ret, r)
    }
    return(ret)
  }
  
  ret=NULL
}   



###downloading and importing the data to a locale location. This section is in
#progress.  Right now, the files are manually downloaded and edited by hand.  
#Eventually, the hopeis that this will be all automated.


#load the current URL list IP database into the file 
urllist <- read.table("dataapache.txt",sep="#", header=FALSE)
colnames(urllist) <-c("URL")


###download all the files for the repository 
lapply(urlList, function(x) {
  download.file(x, destfile=paste("~/Documents/code/Project/data", 
                gsub(".+/", "", x), sep=""), quiet = FALSE, mode = "w", 
                cacheOK = TRUE)
})


######individual file clean-up, data entry

####read in ip addressess and add Type, Repo, Reliability, Risk information.  
#This is done on a per file basis where necessary and as a bulk opeartions when
#the files align.  Doing it this way so othes can reproduce


###source 1 -

###add additional column names
av$Type <- "NA"
av$Repo <-"NA"

#look-up the IP address in freegeoip and add the location information
av$Country <-"NA"
av$Locale <-"NA"
av$yCoord<-"NA"
av$xCoord<-"NA"

#add the relaibility info where possible.  Leave netural when not available
av$Reliability <-"NA"
av$Risk <-"NA"



###source 2 -




###source 3 -



##take the ip addresses and add geo information



#create empty dataframe 
df_red <- data.frame(ip=(character()),
                     country_code=character(), 
                     country_name=character(), 
                     region_code=character(), 
                     region_name=character(), 
                     city=character(), 
                     zipcode=character(), 
                     latitude=numeric(), 
                     longitude=numeric(), 
                     metro_code=character(), 
                     area_code=character(), 
                     stringsAsFactors=FALSE) 


addr<- c("1.168.206.81", "1.214.250.97" )
addr2<- c("1.168.206.81", "192.121.77", "1.214.250.97")

### test the IP to see if it is working.  If not then add NA to all.  If it 
#is then add geo information

# ips <- c("8.8.8,8", '555.22.333.111')
# try.ip   <- function(ip) suppressWarnings(try(freegeoip(ip), silent = TRUE))
# outcomes <- lapply(ips, try.ip)
# 
# is.ok    <- function(x) !inherits(x, "try-error")
# sapply(outcomes, is.ok)


#### run the ip address through freegoip and add the needed geo information to 
#the df_red dataframe 
for (i in 1:length(addr)) {
  print(addr[i])
  red <- freegeoip(addr[i])
  print(red)

   newrow = c(red$ip, red$country_code, red$country_name, red$region_code,
             red$region_name, red$city, red$zipcode, red$latitude, 
              red$longitude, red$metro_code, red$area_code)
  
 library(data.table)
  df_red <- rbindlist(list(df_red, as.list(newrow)))
}

df_red

df_red = null


### run basic statitical tests on the resulting data set

##Clean out all IP address without geo information

##Run basic EDA




###script done 











