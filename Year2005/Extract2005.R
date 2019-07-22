Extract_Inittable2005<-function(page,nc,other=FALSE,dis=FALSE,colo=FALSE,anu=FALSE,amp=FALSE,jaff=FALSE,NE=FALSE)
{
  if(amp==FALSE)        
  {
    # both column names look the same except Aruna de Soyza----
    Names<-c("Wimal Geeganage","Chamil Jayaneththi","Ajith Kumara Jayaweera Arachchige",
             "Siritunga Jayasuriya","P. Nelson Perera","Wije Dias","Anura De Silva",
             "Aruna de Soyza","Mahinda Rajapaksha","Ranil Wickramasinghe",
             "Achala Ashoka Suraweera","Victor Hettigoda",
             "Hewaheenipallage Shantha Dharmadwaja","Total Valid",
             "Total Rejected","Total Polled")
  }
  
  if(amp==TRUE)
  {
    Names<-c("Wimal Geeganage","Chamil Jayaneththi","Ajith Kumara Jayaweera Arachchige",
             "Siritunga Jayasuriya","P. Nelson Perera","Wije Dias","Anura De Silva",
             "Aruna De Soyza","Mahinda Rajapaksha","Ranil Wickramasinghe",
             "Achala Ashoka Suraweera","Victor Hettigoda",
             "Hewaheenipallage Shantha Dharmadwaja","Total Valid",
             "Total Rejected","Total Polled")        
  }        
  
  # extract the district name----
  District<-str_squish(
            str_remove(
            str_remove(
            str_remove(
            str_remove(
            str_remove(
            str_remove(
                       str_split(SL_PE_2005[[page]],"\n")[[1]][2]
                       ,"ELECTORAL DISTRICT - ")
                       ,"\r")
                       ,"ELECTORALE DISTRICT - ")
                       ,"ELECTORAL DISTRICT- ")
                       ,"ELECTORAL DISTRICT -")
                       ,"ELECTRAL DISTRICT -")
                       )
  
  if(jaff==FALSE && NE==FALSE)
  {
    # extracting table values but except for jaffna and Nuwara Eliya districts----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                                 str_split(SL_PE_2005[[page]],"\n")[[1]][7:22]
                                 ,Names)
                                 ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)        
  }
  
  if(NE==TRUE)
  {
    # Special case of extracting values from Nuwara eliya district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                                 str_split(SL_PE_2005[[page]],"\n")[[1]][9:24]
                                 ,Names)
                                 ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)    
    # electorate name for Nuwara Eliya----
    Name<-c("Maskelliya","Kotmale","Hanguranketa","Walapane","Postal","Total")
  }        
  
  if(jaff==TRUE)
  {
    # Special case of extracting values from Jaffna district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][8:23]
                                ,Names)
                                ,","))
                                ," ")
    
    Table1<-do.call("rbind",Table1)               
  }
  
  if(colo ==TRUE)
  {   
    # extracting electorate names for colombo because of special case----
    Name<-str_split(
          str_replace_all(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][3])
                     ,"Candidate Name ")
                          ,"Colombo ","Colombo-")
                    ," ")[[1]]
  }
  
  if(anu ==TRUE)
  {        
    # extracting electorate names for anuradhapura because of special case----
    Name<-str_split(
          str_replace_all(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][3])
                     ,"Candidate Name ")
                          ,"Anuradhapura ","Anuradhapura-")
                    ," ")[[1]]
  }
  
  if(anu ==FALSE && colo==FALSE && NE==FALSE)
  {        
    # extracting electorate names for districts except special cases----
    Name<-str_split(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][3])
                     ,"Candidate Name ")
                    ," ")[[1]]
  }
  
  if(other==FALSE && dis==FALSE)
  {        
    # extracting votes and percentage only from table when there is no ----
    # Postal Votes, Final district votes and displace votes
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-1,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")
  }
  
  if(other==TRUE && dis==FALSE)
  {
    # extracting votes and percentage for special cases when table has ----
    # Postal votes and Final district votes
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-3,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    Votes[[dim(Table1)[2]-1]]<-data.table(Table1[,dim(Table1)[2]-1],NA)
    Votes[[dim(Table1)[2]]]<-data.table(Table1[,dim(Table1)[2]],NA)        
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")        
  }
  
  if(other==TRUE && dis==TRUE)
  {
    # extracting votes and percentage for special cases when table has ----
    # Postal votes, Final district votes and displaced votes
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-4,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    Votes[[dim(Table1)[2]-2]]<-data.table(Table1[,dim(Table1)[2]-2],NA)
    Votes[[dim(Table1)[2]-1]]<-data.table(Table1[,dim(Table1)[2]-1],NA)
    Votes[[dim(Table1)[2]]]<-data.table(Table1[,dim(Table1)[2]],NA)        
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")                
  }
  
  # converting votes and percentages from factors to numeric----
  Values[,c("Votes")]<-lapply(Values[,c(1)], function(x) as.numeric(as.character(x)))
  Values[,c("Percentage")]<-lapply(Values[,c(2)], function(x) as.numeric(as.character(x)))
  
  # intermediate table----
  DistrictT<-data.table("Year"=2005,"District"=factor(District),
                        "Electorate"=factor(rep(Name,each=16)),
                        "ColNames"=rep(Names,nc),"Votes"=Values$Votes,
                        "Percentage"=Values$Percentage)
  
  if(jaff==FALSE && NE==FALSE)
  {
    # extracting Total Polled votes except jaffna and nuwara eliya----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][23]
                                ,"Total Registered")
                                ,","))
                      ," ")[[1]]
  }       
  
  if(jaff==TRUE)
  {
    # extracting Total polled votes for jaffna district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][24]
                                ,"Total Registered")
                                ,","))
                      ," ")[[1]]
  }        
  
  if(NE==TRUE)
  {
    # extracting Total polled votes for Nuwara Eliya district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][25]
                                ,"Total Registered")
                                ,","))
                      ," ")[[1]]
  }  
   # Table for Total registered votes----
  DistrictTadd<-data.table("Year"=2005,"District"=District,
                           "Electorate"=factor(Name),
                           "ColNames"="Total Registered",
                           "Votes"=as.numeric(Table1),
                           "Percentage"=NA)
  # Final Table----
  FinalDistrict<-rbind(DistrictT,DistrictTadd)
  return(FinalDistrict)
}


Extract_othertable2005<-function(page,District,nc,other=TRUE,dis=FALSE,jaff=FALSE,NE=FALSE)
{
  # names on the column----
  Names<-c("Wimal Geeganage","Chamil Jayaneththi","Ajith Kumara Jayaweera Arachchige",
           "Siritunga Jayasuriya","P. Nelson Perera","Wije Dias","Anura De Silva",
           "Aruna de Soyza","Mahinda Rajapaksha","Ranil Wickramasinghe","Achala Ashoka Suraweera",
           "Victor Hettigoda","Hewaheenipallage Shantha Dharmadwaja","Total Valid",
           "Total Rejected","Total Polled")
  
  if(jaff==TRUE)
  {
    # special case of extracting table values for jaffna district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][6:21]
                                ,Names)
                                ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)   
    
    # Extracting electorate names for jaffna district----
    Name<-str_split(
          str_replace(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][1])
                    ,"Candidate Name ")
                      ,"Point ","Point-")
                   ," ")[[1]]
    
  }
  
  if(jaff==FALSE)
  {
    # extracting table values except for jaffna district----
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][5:20]
                                 ,Names)
                                ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)
    
    # Extracting electorate names except for jaffna district----
    Name<-str_split(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][1])
                     ,"Candidate Name ")
                   ," ")[[1]]
  }
  
  # extracting votes and percentages except when postal, displaced ----
  # and final votes are not in the table 
  if(other==FALSE && dis==FALSE)
  {        
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-1,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")
  }
  
  if(other==TRUE && dis==FALSE)
  {
    # extracting votes and percentages except when postal ----
    # and final votes are in the table 
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-3,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    Votes[[dim(Table1)[2]-1]]<-data.table(Table1[,dim(Table1)[2]-1],NA)
    Votes[[dim(Table1)[2]]]<-data.table(Table1[,dim(Table1)[2]],NA)        
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")        
  }     
  
  if(other==TRUE && dis==TRUE)
  {
    # extracting votes and percentages except when postal, displaced ----
    # and final votes are in the table 
    Votes<-NULL
    for (i in seq(1,dim(Table1)[2]-4,2)) 
    {
      Votes[[i]]<-Table1[,c(i,i+1)]
    }
    Votes[[dim(Table1)[2]-2]]<-data.table(Table1[,dim(Table1)[2]-2],NA)
    Votes[[dim(Table1)[2]-1]]<-data.table(Table1[,dim(Table1)[2]-1],NA)
    Votes[[dim(Table1)[2]]]<-data.table(Table1[,dim(Table1)[2]],NA)        
    
    Values<-data.table(do.call("rbind",Votes))
    names(Values)<-c("Votes","Percentage")                
  }
  
  # converting factors to numeric ----
  Values[,c("Votes")]<-lapply(Values[,c(1)], function(x) as.numeric(as.character(x)))
  Values[,c("Percentage")]<-lapply(Values[,c(2)], function(x) as.numeric(as.character(x)))
  
  # creating intermeidate table----
  DistrictT<-data.table("Year"=2005,"District"=District,
                        "Electorate"=factor(rep(Name,each=16)),
                        "ColNames"=rep(Names,nc),"Votes"=Values$Votes,
                        "Percentage"=Values$Percentage)
  
  # extracting Total votes except jaffna district----
  Table1<-str_split(
          str_squish(
          str_remove(
          str_remove(str_split(SL_PE_2005[[page]],"\n")[[1]][21]
                     ,"Total Registered")
                     ,","))
                    ," ")[[1]]
  
  if(jaff==TRUE)
  {
    # extracting Total votes special case of jaffna district----
    Table1<-str_split(
            str_squish(
            str_remove(
            str_remove(str_split(SL_PE_2005[[page]],"\n")[[1]][22]
                       ,"Total Registered")
                      ,","))
                     ," ")[[1]]
  }
  # intermediate data set for total registered ----
  DistrictTadd<-data.table("Year"=2005,"District"=District,
                           "Electorate"=factor(Name),
                           "ColNames"="Total Registered",
                           "Votes"=as.numeric(Table1),
                           "Percentage"=NA)
  
  # Final data set----
  FinalDistrict<-rbind(DistrictT,DistrictTadd)
  return(FinalDistrict)
}