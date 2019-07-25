Extract_Type1_1988<-function(page,Colo=FALSE,Ga=FALSE,NE=FALSE,Ba=FALSE,Ke=FALSE,Mat=FALSE,Van=FALSE,Bat=FALSE,Put=FALSE,Pol=FALSE,Mon=FALSE)
{
  # extracting electorates of Colombo special situation----
  if(Colo==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                          ," ")[[1]] 
    
    electorate2<-str_split(
                 str_replace_all(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Votes"))
                                 ,c("North"="Colombo-North"
                                 ,"Central"="Colombo-Central"
                                 ,"East"="Colombo-East"
                                 ,"West"="Colombo-West"))
                           ," ")[[1]]  
    
    electorate<-c(electorate2[1:2],electorate1[1],electorate2[3:4],
                  electorate1[2:5],electorate2[5:10])
  }    
  # extracting electorates of Gampaha special situation----
  if(Ga==TRUE)    
  {
    electorate<-str_split(
                str_replace(
                str_squish(
                str_remove(
                str_remove_all(
                str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                               ,"[:ALPHA:]-")
                           ,"Total"))
                            ,"JEla","Ja-Ela")
                          ," ")[[1]]   
  }
  # extracting electorates of Nuwara-Eliya special situation-----
  if(NE==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                           ," ")[[1]]   
    
    electorate<-c("Nuwara-Eliya-Maskeliya",electorate1[1],"Hanguranketha",electorate1[2])
  }    
  # extracting electorates of Badulla special situation-----
  if(Ba==TRUE)        
  {
    electorate1<-str_split(
                 str_replace(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                             ,"HalEla","Hali-Ela")
                           ," ")[[1]]  
    
    electorate<-c(electorate1[1:5],"Uva-Paranagama",electorate1[6:8])
  }
  # extracting electorates of kegalle special situation----
  if(Ke==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                          ," ")[[1]]    
    
    electorate2<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Votes"))
                          ," ")[[1]]    
    
    electorate<-c(electorate2[1:2],electorate1,electorate2[3:6])
  }    
  # extracting the district name----
  district<-str_squish(
            str_remove(
            str_remove(
            str_remove(
            str_remove(
            str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][3])
                       ,"Electoral District No. ")
                       ,"Electoral District No.")
                       ,"[:digit:]+")
                       ,"[:punct:]"))
  
  # extracting electorates except special situations----
  if(Colo==FALSE & Ga==FALSE & NE==FALSE & Ba==FALSE & Ke==FALSE)
  {
    electorate<-str_split(
                str_squish(
                str_remove(
                str_remove_all(
                str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                               ,"[:ALPHA:]-")
                          ,"Total"))
                         ," ")[[1]]
  }
  # adding postal votes and total at the end of electorates----
  electorate<-c(electorate,"Postal Votes","Total")
  # adding column names as a variable----
  Names<-c("Mr.Ranasinghe Premadasa","Mrs.Sirimavo Ratwatte Dias Bandaranaike",
           "Mr.Ahangama Vithanage Oswin Nandimitra Abhayagunasekara",
           "Total No of Valied Votes","No of Rejected Votes",
           "Total No of Votes Polled","No of Registered Electors")
  
  # extracting table of values ----
  Table<-str_remove_all(
         str_remove_all(
         str_squish(str_split(
                    str_remove_all(SL_PE_1988[[page]][[1]],"[:alpha:]+")
                              ,"\n")[[1]][-1])
                        ,",")
                        ,"%")
  
  # removing empty rows and cleaning the table----
  Table<-Table[-c(1:5,7,10,21)]
  
  Table<-do.call("rbind",str_split(Table," "))
  Table<-do.call("rbind",lapply(1:nrow(Table), function(x) Table[x,][!Table[x,] =="." ]))
  Table<-Table[,-dim(Table)[2]]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]]<-Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]<-c(NA,NA)
  
  # Matale district special table manipulation----
  if(Mat==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-214938    
  }    
  
  # Vanni district special table manipulation----
  if(Van==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-142723
    Table[seq(2,10,2),5]<-Table[seq(2,10,2),4]
    Table[seq(2,10,2),4]<-NA
  }
  
  # Batticaloa district special table manipulation----
  if(Bat==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-215585
    Table[dim(Table)[1]-1,dim(Table)[2]]<-58.48
  }
  
  # Puttalam district special table manipulation----
  if(Put==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-319003
    Table[dim(Table)[1]-1,dim(Table)[2]]<-71.23
  }
  
  # Polonaruwa district special table manipulation----
  if(Pol==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-163741    
  }  
  
  # Monaragala district special table manipulation----
  if(Mon==TRUE)
  {
    Table[dim(Table)[1],dim(Table)[2]]<-161927    
  }  
  
  #extracting votes and percentages from the table----
  Votes<-as.numeric(Table[seq(1,dim(Table)[1],2),])
  Percentage<-as.numeric(rbind(Table[seq(2,dim(Table)[1],2),],NA))
  
  # final table constructed----
  output<-data.table("Year"=1988,"District"=district,
                     "Electorate"=rep(electorate,each=7),
                     "ColNames"=rep(Names,length(electorate)),
                     "Votes"=Votes,"Percentage"=Percentage)
  return(output)
}

Extract_Type2_1988<-function(page,Ma=FALSE,Ja=FALSE,Ku=FALSE,Anu=FALSE,Ga=FALSE,Mat=FALSE,Ha=FALSE)
{
  # extracting district name----
  district<-str_squish(
            str_remove(
            str_remove(
            str_remove(
            str_remove(str_squish(
                       str_split(SL_PE_1988[[page]],"\n")[[1]][3])
                      ,"Electoral District No. ")
                      ,"Electoral District No.")
                      ,"[:digit:]+")
                      ,"[:punct:]"))
  
  # extracting table of values----
  Table<-str_remove_all(
         str_remove_all(
         str_squish(str_split(
                    str_remove_all(SL_PE_1988[[page]][[1]],"[:alpha:]+")
                              ,"\n")[[1]][-1])
                        ,",")
                        ,"%")
  
  # special case of electorate name for mahanuwara district----
  if(Ma==TRUE)        
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                          ," ")[[1]]  
    
    electorate<-c(electorate1[1:2],"Patha-dumbara","Udu-dumbara",electorate1[3:11])
    
    Table<-Table[-c(1:7,9,12,17,24)]
  }
  # special case of electorate name for jaffna district----
  if(Ja==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_replace_all(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total")
                                ,c("Kankesant"="Kankesanthurai"
                                   ,"Chavakac"="Chavakacheri")))
                            ," ")[[1]]  
    
    electorate<-c(electorate1[1],"Vaddukoddai",electorate1[2:5],"Point-Pedro",
                  electorate1[6:8],"Kilinochchi")
    
    Table<-Table[-c(1:7,9,12,23)]    
  }
  # special case of electorate name for Kurunegala district----
  if(Ku==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][4])
                                ,"[:ALPHA:]-")
                            ,"Names of Candidates")
                            ,"Postal"))
                           ," ")[[1]]  
    
    electorate2<-str_split(
                 str_squish(
                 str_replace_all(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                                ,c("Panduwas"="Panduwasnuwara"
                                   ,"Mawathaga"="Mawathagama"
                                   ,"Dodangasl"="Dodangaslanda")))
                           ," ")[[1]]  
    
    electorate<-c(electorate1[1:5],electorate2[1],electorate1[6],electorate2[2:8])
    
    Table<-Table[-c(1:6,8,11,22)]    
  }
  # special case of electorate name for Anuradhapura district----
  if(Anu==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][6])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                           ," ")[[1]]   
    
    electorate<-c(electorate1[1:2],"Anuradhapura-East","Anuradhapura-West",
                  electorate1[3:5])
    
    Table<-Table[-c(1:7,9,12,23)]    
  }
  # special case of electorate name for Galle district-----
  if(Ga==TRUE)
  {
    electorate1<-str_split(
                 str_squish(
                 str_remove(
                 str_remove_all(
                 str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                                ,"[:ALPHA:]-")
                            ,"Total"))
                          ," ")[[1]]   
    
    electorate<-c(electorate1[1:3],"Bentara-Elpitiya",electorate1[4:9])
    
    Table<-Table[-c(1:5,7,9,11,18,23)]
  }
  # special case of electorate name for matara district-----
  if(Mat==TRUE)
  {
    electorate1<-str_split(
      str_squish(
        str_remove(
          str_remove_all(
            str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
            ,"[:ALPHA:]-")
          ,"Total")
      )
      ," ")[[1]]   
    
    electorate<-c(electorate1[1:3],"Kamburupitiya",electorate1[4:6])
    
    Table<-Table[-c(1:5,7,11,13,22)]    
  }
  # special case of electorate name for Hambanthota district----
  if(Ha==TRUE)
  {
    electorate<-str_split(
                str_squish(
                str_replace(
                str_remove(
                str_remove_all(
                str_squish(str_split(SL_PE_1988[[page]],"\n")[[1]][5])
                              ,"[:ALPHA:]-")
                          ,"Total")
                            ,"Tissamahara","Tissamaharamaya"))
                         ," ")[[1]]
    
    Table<-Table[-c(1:5,7,9,21)]    
  }
  
  # adding Postal votes and total at the end of electorates----
  electorate<-c(electorate,"Postal Votes","Total")
  
  # a variable for column names----
  Names<-c("Mr.Ranasinghe Premadasa","Mrs.Sirimavo Ratwatte Dias Bandaranaike",
           "Mr.Ahangama Vithanage Oswin Nandimitra Abhayagunasekara",
           "Total No of Valied Votes","No of Rejected Votes",
           "Total No of Votes Polled","No of Registered Electors")
  
  # converting the extracted table into more meaningful content----
  Table<-do.call("rbind",str_split(Table," "))
  Table<-do.call("rbind",lapply(1:nrow(Table), function(x) Table[x,][!Table[x,] =="." ]))
  Table<-Table[,-dim(Table)[2]]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]]<-Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]
  Table[c(dim(Table)[1]-1,dim(Table)[1]),dim(Table)[2]-1]<-c(NA,NA)
  
  # Table manipulation for special case in Jaffna district----
  if(Ja==TRUE)
  {
    Table[seq(2,10,2),13]<-Table[seq(2,10,2),12]
    Table[seq(2,10,2),12]<-NA
  }
  # Table manipulation for special case in Kurunegala district----
  if(Ku==TRUE)
  {
    Table[seq(2,10,2),16]<-Table[seq(2,10,2),15]
    Table[seq(2,10,2),15]<-NA
    Table[13,16]<-784989
  }
  # Table manipulation for special case in Anuradhapura district----
  if(Anu==TRUE)
  {
    Table[13,9]<-334074
    Table[12,9]<-40.36
  }
  # Table manipulation for special case in Galle district----
  if(Ga==TRUE)
  {
    Table[12,12]<-Table[12,10]
    Table[12,c(7:10)]<-Table[12,c(6,9)]
    Table[12,6]<-NA
  }
  
  # using the table to extract votes and percentage values----
  Votes<-as.numeric(Table[seq(1,dim(Table)[1],2),])
  Percentage<-as.numeric(rbind(Table[seq(2,dim(Table)[1],2),],NA))
  
  # final extracted table----
  output<-data.table("Year"=1988,"District"=district,
                     "Electorate"=rep(electorate,each=7),
                     "ColNames"=rep(Names,length(electorate)),
                     "Votes"=Votes,"Percentage"=Percentage)
  return(output)
}