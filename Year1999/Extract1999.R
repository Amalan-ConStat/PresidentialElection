Extract_table1999<-function(page,nr,GA=FALSE)
{
  # extracting district name from table
  district<-str_remove(
            str_remove(
            str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][2])
                       ," DISTRICT")
                       ," DISTRECT")
  
  # extracting table of values for Gampaha district 
  if(GA==FALSE)
  {    
    Table1<-str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][seq(7,nr*2+6,2)])
  }
  
  # special case in extracting table of values for Gampaha district  
  if(GA==TRUE)
  {    
    Table1<-str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][seq(8,nr*2+6,2)])
  }
  # extracting only votes except postal votes
  Votes<-t(do.call("rbind",
                   str_split(
                   str_squish(str_remove_all(Table1,"[[[:alpha:]-],]"))
                             ," "))[c(1:(length(Table1)-2),length(Table1)),c(2:17)]
          )
  
  # extracting postal votes only
  PosVotes<-str_split(
            str_squish(
                       str_remove_all(
                       str_remove_all(Table1[length(Table1)-1],"[[:alpha:]-]")
                                      ,","))
                      ," ")[[1]]
  
  PosVotes<-c(PosVotes,NA)
  
  # extracting registered votes only
  RegVote<-t(do.call("rbind",
                     str_split(
                     str_squish(str_remove_all(Table1,"[[[:alpha:]-],]"))
                               ," "))[c(1:(length(Table1)-2),length(Table1)),1]
            )
  # final final votes table with votes, postal votes and registered votes
  FinVotes<-rbind(Votes,RegVote)
  FinFinVotes<-cbind(FinVotes[,1:dim(FinVotes)[2]-1],PosVotes)
  FinFinVotes<-cbind(FinFinVotes,FinVotes[,dim(FinVotes)[2]])
  
  # extracting percentages except Gampaha district
  if(GA==FALSE)
  {
    Perc<-t(do.call("rbind",
                    str_split(
                    str_remove_all(
                    str_squish(str_split(SL_PE_1999[[page]]
                                         ,"\n")[[1]][seq(8,nr*2+6,2)])
                                   ,"%")
                              ," ")
                    )
            )
    
    Perc[dim(Perc)[1],dim(Perc)[2]-1]<-NA
    
    Perc<-rbind(Perc,NA)
  }
  
  # extracting percentages specially for Gampaha district
  if(GA==TRUE)
  {
    Perc<-t(do.call("rbind",
                    str_split(
                    str_remove_all(
                    str_squish(str_split(SL_PE_1999[[page]]
                                         ,"\n")[[1]][seq(9,nr*2+7,2)])
                                  ,"%")
                              ," ")
                    )
            )
    
    Perc[dim(Perc)[1],(dim(Perc)[2]-1)]<-NA
    
    Perc<-rbind(Perc,NA)
  }
  
  # extracting the electorates 
  electorates<-do.call("rbind",
                       lapply(1:(nr-2), function(i)
                                        str_squish(
                                        str_remove(
                                        str_remove_all(Table1[i],"[[:digit:]+,\r]")
                                                   ,"[:alpha:]"))
                              )
                      )
  
  # adding postal votes and final district results with electorates
  electorates<-c(electorates,"POSTAL VOTES","FINAL DISTRICT RESULTS")
  
  # Column names which are similar to all tables
  ColumnNames<-c("SLMK","PFF","DUNF","JVP","PLSF","PA",
                 "IND1","IND2","UNP","LP","LDA","IND3",
                 "SMBP","Valid Votes","Rejected Votes","Total Polled",
                 "Registered Electors")
  
  # final output table
  output<-data.table("Year"=1999,"District"=district,
                     "Electorate"=rep(electorates,each=17),
                     "ColNames"=rep(ColumnNames,nr),
                     "Votes"=as.numeric(Reduce(rbind,FinFinVotes)),
                     "Percentage"=as.numeric(Reduce(rbind,Perc)))
  return(output)
}    