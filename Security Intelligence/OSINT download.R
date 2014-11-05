
setwd("~/Documents/Core /TELUS/security intelligence")

avURL1 <- "http://www.projecthoneypot.org/list_of_ips.php?rss=1"
avURL2 <-  "http://www.openbl.org/lists/base_30days.txt"
avURL3 <-  "http://www.blocklist.de/lists/ssh.txt"
avURL4 <-  "http://www.blocklist.de/lists/apache.txt"
avURL5 <-  "http://www.blocklist.de/lists/asterisk.txt"
avURL6 <-  "http://www.blocklist.de/lists/bots.txt"
avURL7 <-  "http://www.blocklist.de/lists/courierimap.txt"
avURL8 <-  "http://www.blocklist.de/lists/courierpop3.txt"
avURL9 <-  "http://www.blocklist.de/lists/email.txt"
avURL10 <-  "http://www.blocklist.de/lists/ftp.txt"
avURL11 <-  "http://www.blocklist.de/lists/imap.txt"
avURL12 <-  "http://www.blocklist.de/lists/ircbot.txt"
avURL13 <-  "http://www.blocklist.de/lists/pop3.txt"
avURL14 <-  "http://www.blocklist.de/lists/postfix.txt"
avURL15 <-  "http://www.blocklist.de/lists/proftpd.txt"
avURL16 <-  "http://www.blocklist.de/lists/sip.txt"
avURL17 <-  "http://www.ciarmy.com/list/ci-badguys.txt"
avURL18 <-  "http://reputation.alienvault.com/reputation.data"
avURL19 <-  "http://dragonresearchgroup.org/insight/sshpwauth.txt"
avURL20 <-  "http://dragonresearchgroup.org/insight/vncprobe.txt"
avURL21 <-  "http://danger.rulez.sk/projects/bruteforceblocker/blist.php"
avURL22 <-  "https://isc.sans.edu/ipsascii.html"
avURL23 <-  "http://www.nothink.org/blacklist/blacklist_ssh_day.txt"
avURL24 <-  "https://www.packetmail.net/iprep.txt"
avURL25 <-  "http://www.autoshun.org/files/shunlist.csv"
avURL26 <-  "http://charles.the-haleys.org/ssh_dico_attack_hdeny_format.php/hostsdeny.txt"
avURL27 <-  "http://virbl.org/download/virbl.dnsbl.bit.nl.txt"
avURL28 <-  "http://botscout.com/last_caught_cache.htm"
avURL29 <- "https://zeustracker.abuse.ch/blocklist.php?download=badips"

####Loop to access the websites and download the files.  Also, check if file exists and if not then download.  Please
####note this directory is purged at the end of each session 

for (i in 1:29){
  if (file.access(avRep2)) {  
    download.file(avURL[i], avRep[i])
  }
}
avURL2 <- "http://www.openbl.org/lists/base_30days.txt"
avRep2 <- "data/open.txt"

if (file.access(avRep2)) {  
  download.file(avURL2, avRep2)
}


#Load the data into the appropiate dataframe
av <- read.csv(avRep2,sep="#", header=FALSE, skip = 4)

colnames(av) <-c("IP")

head(av, n= 100)


avURL3 <- "http://www.blocklist.de/lists/bots.txt"
avRep3 <- "data/bbots.txt"

if (file.access(avRep3)) {  
  download.file(avURL3, avRep3)
}


#Load the data into the appropiate dataframe
av3 <- read.csv(avRep3,sep="#", header=FALSE)
head(av3)
head(av)

colnames(a3) <-c("IP")

head(av, n= 100)

##################
avURL4 <- "http://www.projecthoneypot.org/list_of_ips.php?rss=1"
avRep4 <- "data/xml4.txt"

if (file.access(avRep4)) {  
  download.file(avURL4, avRep4)
}


#Load the data into the appropiate dataframe
av4 <- read.csv(avRep4,sep="", header=FALSE)
head(av4)
head(av)


