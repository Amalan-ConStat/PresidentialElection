Extract_Table1982<-function(page,Kur=FALSE,Keg=FALSE,Colo=FALSE,Maha=FALSE,Ga=FALSE)
{ # extracting the district----   
  district<-str_squish(
            str_remove(
            str_remove(
            str_remove(
            str_remove(str_squish(
                       str_split(SL_PE_1982[[page]],"\n")[[1]][3])
                      ,"Electoral District : No.")
                      ,"Electoral District:No. ")
                      ,"Electoral District :No.")
                      ,"[:digit:]+"))
  # extracting the electorates special case for colombo district----
  if(Colo==TRUE)
  { 
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes"))
                          ," ")[[1]]   
    
    electorate1<-c("Colombo-North","Colombo-Central",electorate1[1],"Colombo-East",
                   "Colombo-West",electorate1[2:11])
  }
  # extracting the electorates special case for mahanuwara district----  
  if(Maha==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes"))
                          ," ")[[1]]   
    
    electorate2<-str_split(
                 str_squish(
                 str_replace_all(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Postal Votes")
                            ,"Names of Candidates")
                                ,c("UdDumbara"="Udu-Dumbara"
                                  ,"Pathdumbara"="Patha-dumbara")))
                          ," ")[[1]]   
    
    electorate1<-c(electorate1[1:2],electorate2[1:2],electorate1[3:6],
                   electorate2[3],electorate1[7],electorate2[4:6])    
  }
  # extracting the electorates special case for galle district----  
  if(Ga==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_replace(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                             ,"Bentara ","Bentara-"))
                          ," ")[[1]]    
    
    electorate1<-c(electorate1[1:8],"Akmeemana",electorate1[9])
  }
  # extracting the electorates except for the special case of district----  
  if(Colo==FALSE & Maha==FALSE & Ga==FALSE)
  {    
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes"))
                          ," ")[[1]]   
  }
  # adding the Postal Votes and Total votes after extracted electorates----
  electorate<-c(electorate1,"Postal Votes","Total")
  # extracting vote counts and percentages from a page----
  Table<-str_remove_all(
         str_remove_all(
         str_squish(str_split(
                    str_remove_all(SL_PE_1982[[page]][[1]],"[:alpha:]+")
                              ,"\n")[[1]][-1])
                        ,",")
                        ,"%")  
  # speciic table manipulation for colombo district----
  if(Colo==TRUE)
  {
    Table<-Table[-c(1:5,19,24,27)]   
  }
  # speciic table manipulation for mahanuwara district----  
  if(Maha==TRUE)
  {
    Table<-Table[-c(1:5,19,26,27)]       
  }   
  # speciic table manipulation except for the above spcial cases----
  if(Colo==FALSE & Maha==FALSE)
  {
    Table<-Table[-c(1:5,25:26)]
  }
  # More necessary table manipulations----
  Table<-do.call("rbind",str_split(Table," "))
  Table<-do.call("rbind",lapply(1:nrow(Table), function(x) Table[x,][!Table[x,] =="." &
                                                                       !Table[x,] =="...." &
                                                                       !Table[x,] ==".." ]))
  Table<-Table[,-c((dim(Table)[2]-1),dim(Table)[2])]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]]<-Table[c((dim(Table)[1]-1),dim(Table)[1]),
                                                               (dim(Table)[2]-1)]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]<-c(NA,NA)
  # More intrinsic table manipulations for Kurunegala district----
  if(Kur==TRUE)
  {
    Table[18,16]<-87.16
  }
  # More intrinsic table manipulations for Kegalle district----
  if(Keg==TRUE)
  {
    Table[18,10]<-86.78
  }
  # extracting the votes and percentages from table----
  Votes<-as.numeric(Table[seq(1,dim(Table)[1],2),])
  Percentage<-as.numeric(rbind(Table[seq(2,dim(Table)[1],2),],NA))
  # creating  a variable name for column names and adding the content----
  Names<-c("Mr.J.R. Jayawardene","Mr.H.S.R.B.K. Kobbekaduwa",
           "Mr. Rohana Wijeweera","Mr.G.G. Ponnambalam",
           "Dr. Colvin R. De Silva","Mr. Vasudeva Nanayakkara",
           "No of Valid Votes","No of Rejected Votes",
           "Total No of Votes Polled","No of Registered Electors")
  # final table generated----
  output<-data.table("Year"=1982,"District"=district,
                     "Electorate"=rep(electorate,each=10),
                     "ColNames"=rep(Names,length(electorate)),
                     "Votes"=Votes,"Percentage"=Percentage)
  return(output)
}

Extract_Table2_1982<-function(page,HP=FALSE,Gam=FALSE,Jaf=FALSE,Anu=FALSE,Bad=FALSE)    
{
  # extracting the district----
  district<-str_squish(
            str_remove(
            str_remove(
            str_remove(
            str_remove(str_squish(
                       str_split(SL_PE_1982[[page]],"\n")[[1]][3])
                      ,"Electoral District : No.")
                      ,"Electoral District:No. ")
                      ,"Electoral District :No.")
                      ,"[:digit:]+"))    
  # extracting the electorate names except for special cases----
  electorate1<-str_split(
               str_squish(
               str_remove(
               str_remove(
               str_remove(
               str_remove_all(
               str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][5])
                              ,"[:ALPHA:]-")
                          ,"Total")
                          ,"Postal Votes")
                          ,"Names of Candidates"))
                        ," ")[[1]]   
  # extracting the table from a page----
  Table<-str_remove_all(
         str_remove_all(
         str_squish(str_split(
                    str_remove_all(SL_PE_1982[[page]][[1]],"[:alpha:]+")
                              ,"\n")[[1]][-1])
                        ,",")
                        ,"%")  
  # special case of table manipulation for hambantota and polonnaruwa district----
  if(HP==TRUE)
  {
    Table<-Table[-c(1:4,24:25)]
  }
  # special table manipulation except the special cases----
  if(HP==FALSE & Gam==FALSE & Jaf==FALSE & Anu==FALSE & Bad==FALSE)
  {
    Table<-Table[-c(1:4,18,25)]
  }
  # electorate extraction for gampaha district----
  if(Gam==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_replace(
                 str_remove(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes")
                            ,"Names of Candidates")
                              ,"JEla","Ja-Ela"))
                          ," ")[[1]]   
    
    Table<-Table[-c(1:4,18,25,26)]
    
  }
  # electorate extraction for jaffna district----  
  if(Jaf==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_replace(
                 str_remove(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes")
                            ,"Names of Candidates")
                              ,"Chavakachch","Chavakachcheri"))
                          ," ")[[1]]   
    
    electorate1<-c("Kayts",electorate1[1:8],"Jaffna","Kilinochchi")
    
    Table<-Table[-c(1:6,26:27)]    
  }
  # electorate extraction for anuradhapura district----  
  if(Anu==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes")
                            ,"Names of Candidates"))
                          ," ")[[1]]   
    
    electorate1<-c(electorate1[1:2],"Anuradhapura-East",
                   "Anuradhapura-West",electorate1[3:5])
    
    Table<-Table[-c(1:6,26:27)]        
  }
  # electorate extraction for badulla district----  
  if(Bad==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_replace(
                 str_remove(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1982[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                            ,"Postal Votes")
                            ,"Names of Candidates")
                              ,"Hali ","Hali-"))
                          ," ")[[1]]   
    
    electorate1<-c(electorate1[1:5],"Uva-Paranagama",electorate1[6:8])
    
    Table<-Table[-c(1:6,26:27)]      
  }
  # adding electorate names and then adding postal votes, total at the end----
  electorate<-c(electorate1,"Postal Votes","Total")
  # much more specific table manipulation----
  Table<-do.call("rbind",str_split(Table," "))
  Table<-do.call("rbind",lapply(1:nrow(Table), function(x) Table[x,][!Table[x,] =="." &
                                                                       !Table[x,] =="...." &
                                                                       !Table[x,] ==".." ]))
  Table<-Table[,-c((dim(Table)[2]-1),dim(Table)[2])]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]]<-Table[c((dim(Table)[1]-1),dim(Table)[1]),
                                                               (dim(Table)[2]-1)]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]<-c(NA,NA)
  # special table manipulation for anuradhapura district----
  if(Anu==TRUE)
  {
    Table[18,9]<-85.72
  }
  # extracting votes and percentages from the table----
  Votes<-as.numeric(Table[seq(1,dim(Table)[1],2),])
  Percentage<-as.numeric(rbind(Table[seq(2,dim(Table)[1],2),],NA))
  # creating a variable for column names----
  Names<-c("Mr.J.R. Jayawardene","Mr.H.S.R.B.K. Kobbekaduwa",
           "Mr. Rohana Wijeweera","Mr.G.G. Ponnambalam",
           "Dr. Colvin R. De Silva","Mr. Vasudeva Nanayakkara",
           "No of Valid Votes","No of Rejected Votes",
           "Total No of Votes Polled","No of Registered Electors")
  # final table constructed----
  output<-data.table("Year"=1982,"District"=district,
                     "Electorate"=rep(electorate,each=10),
                     "ColNames"=rep(Names,length(electorate)),
                     "Votes"=Votes,"Percentage"=Percentage)
  return(output)
}    