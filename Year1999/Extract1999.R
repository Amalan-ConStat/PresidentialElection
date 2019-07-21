

Extract_table1999<-function(page,nr,GA=FALSE)
{
  
  district<-str_remove(
            str_remove(
            str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][2])
                       ," DISTRICT")
                       ," DISTRECT")
  
  if(GA==FALSE)
  {    
    Table1<-str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][seq(7,nr*2+6,2)])
  }
  if(GA==TRUE)
  {    
    Table1<-str_squish(str_split(SL_PE_1999[[page]],"\n")[[1]][seq(8,nr*2+6,2)])
  }
  
  Votes<-t(do.call("rbind",
                   str_split(
                   str_squish(str_remove_all(Table1,"[[[:alpha:]-],]"))
                             ," "))[c(1:(length(Table1)-2),length(Table1)),c(2:17)]
          )
  
  PosVotes<-str_split(
            str_squish(
                       str_remove_all(
                       str_remove_all(Table1[length(Table1)-1],"[[:alpha:]-]")
                                      ,","))
                      ," ")[[1]]
  
  PosVotes<-c(PosVotes,NA)
  
  RegVote<-t(do.call("rbind",
                     str_split(
                     str_squish(str_remove_all(Table1,"[[[:alpha:]-],]"))
                               ," "))[c(1:(length(Table1)-2),length(Table1)),1]
            )
  
  FinVotes<-rbind(Votes,RegVote)
  FinFinVotes<-cbind(FinVotes[,1:dim(FinVotes)[2]-1],PosVotes)
  FinFinVotes<-cbind(FinFinVotes,FinVotes[,dim(FinVotes)[2]])
  
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
  
  electorates<-do.call("rbind",
                       lapply(1:(nr-2), function(i)
                                        str_squish(
                                        str_remove(
                                        str_remove_all(Table1[i],"[[:digit:]+,\r]")
                                                   ,"[:alpha:]"))
                              )
                      )
  
  electorates<-c(electorates,"POSTAL VOTES","FINAL DISTRICT RESULTS")
  
  ColumnNames<-c("SLMK","PFF","DUNF","JVP","PLSF","PA",
                 "IND1","IND2","UNP","LP","LDA","IND3",
                 "SMBP","Valid Votes","Rejected Votes","Total Polled",
                 "Registered Electors")
  
  output<-data.table("Year"=1999,"District"=district,
                     "Electorate"=rep(electorates,each=17),
                     "ColNames"=rep(ColumnNames,nr),
                     "Votes"=as.numeric(Reduce(rbind,FinFinVotes)),
                     "Percentage"=as.numeric(Reduce(rbind,Perc)))
  return(output)
}    