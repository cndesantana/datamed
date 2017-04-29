install.packages("splus2R")
install.packages("tm")
install.packages("googleVis")
library(splus2R)
library(tm)
library(googleVis)


#Function to remove the "." from the sentences ended by "."
removeDotString <- function(str){
   str = ifelse(substr(str,nchar(str),nchar(str)) == ".", substr(str,1,nchar(str)-1), str)
   return(str)
}

#Function to return from the database the unity of time for each treatment (week, day, hour, minute)
findTimeUnityTreatment <- function(file){
   allTimeUnities=""
   splittedCharacters <- strsplit(as.character(file$FREQUENCIA),"")
   for(j in 1:length(splittedCharacters)){
      sentence <- as.character(unlist(splittedCharacters[j]));
      n <- length(sentence);
      if(n >= 3){
         timeUnity <- paste(sentence[(n-2):n],collapse='')
      }else{
         timeUnity <- ""
      }
      allTimeUnities <- c(allTimeUnities,timeUnity)
   }
   return(allTimeUnities[-1])
}

#Function to plot the words of a vector of words as a wordcloud
plotVectorOfWordsAsWC<-function(vector){
   wordcloud(paste(vector,collapse=' '), min.freq = 5,
             colors=brewer.pal(6,"Dark2"));
}


setwd("/home/cdesantana/Bilhao/datamed/data")

inputfiles <- system("ls *.tsv", intern = TRUE)

for(i in 2:length(inputfiles)){
   #i<-3
   file <- read.csv(inputfiles[i],sep="\t",header=TRUE)
   
   if(i == 3){
      description <- lowerCase(as.character(unlist(file$DESCRICAO)));
      plotVectorOfWordsAsWC(description);
   }
   if(i == 5){
      #removing all the records with no defined frequency of treatment
      file <- file[which(file$FREQUENCIA != "undefined"),]
      timeUnities <- findTimeUnityTreatment(file)
   }
}



