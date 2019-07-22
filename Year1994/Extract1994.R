
Extract_table1994<-function(page,NE=FALSE,Col=FALSE,Gam=FALSE,Ma=FALSE,Ja=FALSE,An=FALSE,Ba=FALSE,Ga=FALSE)
{
  # extract the district name after removing the text "Electoral district : No." formats----
  district<-str_squish(
                       str_remove_all(
                       str_remove(
                       str_remove(
                       str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][3])
                                  ,"Electoral District : No. ")
                                  ,"Electoral District :No. ")
                                  ,"Electoral District : No.")              
                                      ,"[[:digit:]]")
                      )
  
  if(Col==TRUE)
  {
    # if it is extracting electorate names of colombo district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                           ,"Colombo - ","Colombo-")
                                           ,"Colombo ","Colombo-")
                           ," ")
  }
  
  if(Gam==TRUE)
  {
    # if it is extracting electorate names of Gampaha district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                            ,"Ja - ","Ja-")
                          ," ")
  }
  
  if(Ma==TRUE)
  {
    # if it is extracting electorate names of mahanuwara district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                          ," - Dumbara","-Dumbara")
                          ," ")  
  }
  
  if(Ja==TRUE)
  {
    # if it is extracting electorate names of Jaffna district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                           ,"Point ","Point-")
                          ," ")   
  }
  
  if(An==TRUE)
  {
    # if it is extracting electorate names of Anuradhapura district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                          ," - E","-East")
                                          ," -w","-West")
                          ," ")    
  }    
  
  if(Ba==TRUE)
  {
    # if it is extracting electorate names of Batticaloa district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                          ,"Hali - ","Hali-")
                                          ,"Uva - ","Uva-")
                          ," ")    
  }    
  
  if(Ga==TRUE)
  {
    # if it is extracting electorate names of Galle district make some changes----
    # adjusting the name so that they would fit properly
    electorate1<-str_split(
                           str_replace_all(
                           str_remove(
                           str_remove(str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                                           ," - Elpiti","-Elpitiya")
                          ," ")    
  }   
  
  if(NE==TRUE)
  {
    # extracting a table of values differently because there is an----
    # extra row
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove_all(
                      str_split(SL_PE_1994[[page]],"\n")[[1]][7:31]
                                     ,"[[:alpha:]]")
                                ,"\r"))
                      ," ")
    
    # if it is extracting electorate names of Nuwara Eliya district make some changes----
    # adjusting the name so that they would fit properly    
    electorate1<-str_split(
                 str_replace_all(
                 str_remove(
                 str_remove(
                 str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][6])
                            ,"Names of Candidates ")
                            ," Postal Votes Total")
                                 ,"N'Eliya- ","Nuwara-Eliya-")
                          ," ")        
  }
  
  if(Col==FALSE && Gam==FALSE && Ma==FALSE && NE==FALSE && Ja==FALSE && An==FALSE && Ba==FALSE && Ga==FALSE)
  {    
    # extracting Electorate names without any problems by removing----
    # the texts "Names of Candidates " and " Postal Votes"
    electorate1<-str_split(
                           str_remove(
                           str_remove(
                           str_squish(str_split(SL_PE_1994[[page]],"\n")[[1]][5])
                                      ,"Names of Candidates ")
                                      ," Postal Votes Total")
                          ," ")
  }
  
  electorate<-do.call("cbind",electorate1)
  
  # adding the column names Postal Votes and Final District Results----
  # after electorates for a district
  electorate<-c(electorate,"Postal Votes","Final District Results")
  
  if(NE==FALSE)
  {    
    Table1<-str_split(str_squish(
                      str_remove(
                      str_remove_all(
                      str_split(SL_PE_1994[[page]],"\n")[[1]][6:30]
                                     ,"[[:alpha:]]")
                                 ,"\r"))
                      ," ")
  }
  
  Table1<-do.call("rbind",Table1)    
  
  # removing few rows which does not have numeric values----
  Table1<-Table1[-c(2,5,8,11,14,17),]
  # shifting a specific row with one column because it has a non numeric value----
  Table1[17,]<-c(Table1[17,c(2:dim(Table1)[2])],NA)
  # removing that extrac column which is repeated because of pervious non numierc value----
  Table1<-Table1[,-dim(Table1)[2]]
  # extracting votes from the table----
  Votes<-as.numeric(str_remove_all(Table1[seq(1,dim(Table1)[1],2),],","))
  # extracting percentages from the table----
  Perc<-as.numeric(str_remove(rbind(Table1[seq(2,(dim(Table1)[1]-1),2),],NA),"%"))
  # names on the table, which are in the same order for all tables----
  Names<-c("Mrs. Chandrika Bandaranaike Kumarathunga","Mr. Galappaththi Arachchige Nihal",
           "Mrs. Vajira Srimathi Dissanayake","Mr. A.J. Ranashinge",
           "Dr. Harischandra Wijayatunga","Mr. Hudson Samarasinghe",
           "No of valid votes","No of Rejected votes",
           "Total No. of votes polled","No of Registered Electors")
  # final table with 6 columns----
  output<-data.table("Year"=1994,"District"=district,
                     "Electorate"=rep(electorate,each=10),
                     "ColNames"=rep(Names,length(Votes)/10),
                     "Votes"=Votes,"Percentage"=Perc)
  
  return(output)
}



