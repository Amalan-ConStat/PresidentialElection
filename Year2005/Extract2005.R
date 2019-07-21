Extract_Inittable2005<-function(page,nc,other=FALSE,dis=FALSE,colo=FALSE,anu=FALSE,amp=FALSE,jaff=FALSE,NE=FALSE)
{
  if(amp==FALSE)        
  {
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
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                                 str_split(SL_PE_2005[[page]],"\n")[[1]][9:24]
                                 ,Names)
                                 ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)    
    
    Name<-c("Maskelliya","Kotmale","Hanguranketa","Walapane","Postal","Total")
  }        
  
  if(jaff==TRUE)
  {
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
    Name<-str_split(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][3])
                     ,"Candidate Name ")
                    ," ")[[1]]
  }
  
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
  
  Values[,c("Votes","Percentage")]<-lapply(Values[,c(1,2)], 
                                           function(x) as.numeric(as.character(x))
                                           )
  
  DistrictT<-data.table("Year"=2005,"District"=factor(District),
                        "Electorate"=factor(rep(Name,each=16)),
                        "ColNames"=rep(Names,nc),"Votes"=Values$Votes,
                        "Percentage"=Values$Percentage)
  
  if(jaff==FALSE && NE==FALSE)
  {
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
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][25]
                                ,"Total Registered")
                                ,","))
                      ," ")[[1]]
  }  
  
  DistrictTadd<-data.table("Year"=2005,"District"=District,
                           "Electorate"=factor(Name),
                           "ColNames"="Total Registered","Votes"=Table1,
                           "Percentage"=NA)
  
  FinalDistrict<-rbind(DistrictT,DistrictTadd)
  return(FinalDistrict)
}


Extract_othertable2005<-function(page,District,nc,other=TRUE,dis=FALSE,jaff=FALSE,NE=FALSE)
{
  Names<-c("Wimal Geeganage","Chamil Jayaneththi","Ajith Kumara Jayaweera Arachchige",
           "Siritunga Jayasuriya","P. Nelson Perera","Wije Dias","Anura De Silva",
           "Aruna de Soyza","Mahinda Rajapaksha","Ranil Wickramasinghe","Achala Ashoka Suraweera",
           "Victor Hettigoda","Hewaheenipallage Shantha Dharmadwaja","Total Valid",
           "Total Rejected","Total Polled")
  
  if(jaff==TRUE)
  {
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][6:21]
                                ,Names)
                                ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)   
    
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
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove(
                      str_split(SL_PE_2005[[page]],"\n")[[1]][5:20]
                                 ,Names)
                                ,","))
                      ," ")
    
    Table1<-do.call("rbind",Table1)
    
    Name<-str_split(
          str_remove(
          str_squish(str_split(SL_PE_2005[[page]],"\n")[[1]][1])
                     ,"Candidate Name ")
                   ," ")[[1]]
  }
  
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
  
  Values[,c("Votes","Percentage")]<-lapply(Values[,c(1,2)], function(x) as.numeric(as.character(x)))
  
  DistrictT<-data.table("Year"=2005,"District"=District,
                        "Electorate"=factor(rep(Name,each=16)),
                        "ColNames"=rep(Names,nc),"Votes"=Values$Votes,
                        "Percentage"=Values$Percentage)
  
  Table1<-str_split(
          str_squish(
          str_remove(
          str_remove(str_split(SL_PE_2005[[page]],"\n")[[1]][21]
                     ,"Total Registered")
                     ,","))
                    ," ")[[1]]
  
  if(jaff==TRUE)
  {
    Table1<-str_split(
            str_squish(
            str_remove(
            str_remove(str_split(SL_PE_2005[[page]],"\n")[[1]][22]
                       ,"Total Registered")
                      ,","))
                     ," ")[[1]]
  }
  
  DistrictTadd<-data.table("Year"=2005,"District"=District,
                           "Electorate"=factor(Name),
                           "ColNames"="Total Registered","Votes"=Table1,
                           "Percentage"=NA)
  
  FinalDistrict<-rbind(DistrictT,DistrictTadd)
  return(FinalDistrict)
}