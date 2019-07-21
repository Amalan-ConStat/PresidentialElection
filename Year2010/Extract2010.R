# creating the function for extracting two table situation----
Extract_twotable2010<-function(page,district)
{
  # dividing the page into two tables----
  table1<-data.table(str_split(SL_PE_2010[[page]],"\n")[[1]][3:28])
  table2<-data.table(str_split(SL_PE_2010[[page]],"\n")[[1]][31:56])
  
  # name the only column in these tables----
  names(table1)<-"hello"
  names(table2)<-"hello"
  
  # extracting the text information in the beginning of table----
  NamesTop<-lapply(table1, function(x) 
                           str_squish(
                           str_replace_all(
                           str_remove_all(x,"[[:digit:]{1,}\r]")
                                           ,"[:punct:]"," "))
                    )
  
  # extract the numeric information at the end of table----
  ValuesTop<-lapply(table1, function(x) 
                            str_split(
                            str_squish(
                            str_remove_all(
                            str_remove(str_squish(x),"%")
                                           ,"[[:alpha:],]"))
                                      ," ")
                    )
  
  # clearing the changes in votes and percentages columns of top table----
  ValuesT<-data.frame(do.call("rbind",ValuesTop$hello))
  ValuesT<-lapply(1:nrow(ValuesT), function(x) 
                                   ValuesT[x,][!ValuesT[x,] ==".." & !ValuesT[x,] =="."])
  ValuesT<-do.call("rbind",ValuesT)[,c(1,2)]
  ValuesT[26,2]<-NA
  
  # extracting the text information in the beginning of table----
  NamesBottom<-lapply(table2, function(x) 
                              str_squish(
                              str_replace_all(
                              str_remove_all(x,"[[:digit:]{1,}\r]")
                                              ,"[:punct:]"," "))
                      )
  
  # extract the numeric information at the end of table----
  ValuesBottom<-lapply(table2, function(x) 
                               str_split(
                               str_squish(
                               str_remove_all(
                               str_remove(str_squish(x),"%")
                                          ,"[[:alpha:],]"))
                                        ," ")
                      )
  
  # clearing the changes in votes and percentages columns of bottom table----
  ValuesB<-data.frame(do.call("rbind",ValuesBottom$hello))
  ValuesB<-lapply(1:nrow(ValuesB), function(x) 
                                   ValuesB[x,][!ValuesB[x,] ==".." & !ValuesB[x,] =="."])
  ValuesB<-do.call("rbind",ValuesB)[,c(1,2)]
  ValuesB[26,2]<-NA
  
  # extracting the electorate name above the table----
  Name1<-str_remove(str_split(SL_PE_2010[[page]],"\n")[[1]][1],"\r")
  Name2<-str_remove(str_split(SL_PE_2010[[page]],"\n")[[1]][29],"\r")
  
  # creating a proper table with separate columns for names, votes and percentage----
  Top1<-data.table("ColumnNames"=NamesTop$hello,"Votes"=ValuesT[,1],"Percentage"=ValuesT[,2])
  Bottom1<-data.table("ColumnNames"=NamesBottom$hello,"Votes"=ValuesB[,1],"Percentage"=ValuesB[,2])
  
  # converting the factors to numeric for votes and percentage columns----
  Top1[,2] <- lapply(Top1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  Bottom1[,2] <- lapply(Bottom1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  
  Top1[,3]<-lapply(Top1[,3], function(x) as.numeric(as.character(x)))
  Bottom1[,3]<-lapply(Bottom1[,3], function(x) as.numeric(as.character(x)))
  
  # creating the final table with all the information----
  Electorate1<-data.table("Year"=2010,"District"=district,
                          "Electorate"=Name1,"ColNames"=Top1$ColumnNames,
                          "Votes"=Top1$Votes,
                          "Percentage"=Top1$Percentage)
  Electorate2<-data.table("Year"=2010,"District"=district,
                          "Electorate"=Name2,"ColNames"=Bottom1$ColumnNames,
                          "Votes"=Bottom1$Votes,
                          "Percentage"=Bottom1$Percentage)
  
  output<-rbind2(Electorate1,Electorate2)
  
  return(output)
}

# creating the function for extracting one table situation----
Extract_onetable2010<-function(page,district)
{
  # dividing the page into one table----        
  table1<-data.table(str_split(SL_PE_2010[[page]],"\n")[[1]][3:28])
  
  # name the only column in this table----
  names(table1)<-"hello"
  
  # extracting the text information in the beginning of table----
  NamesTop<-lapply(table1, function(x) 
                           str_squish(
                           str_replace_all(
                           str_remove_all(x,"[[:digit:]{1,}\r]")
                                           ,"[:punct:]"," "))
                  )
  
  # extract the numeric information at the end of table----
  ValuesTop<-lapply(table1, function(x) 
                            str_split(
                            str_squish(
                            str_remove_all(
                            str_remove(str_squish(x),"%")
                                       ,"[[:alpha:],]"))
                                      ," ")
                    )
  
  # clearing the changes in votes and percentages columns----
  ValuesT<-data.frame(do.call("rbind",ValuesTop$hello))
  ValuesT<-lapply(1:nrow(ValuesT), function(x) 
                                   ValuesT[x,][!ValuesT[x,] ==".." & !ValuesT[x,] =="."])
  ValuesT<-do.call("rbind",ValuesT)[,c(1,2)]
  ValuesT[26,2]<-NA
  
  # extracting the electorate name above the table----
  Name1<-str_remove(str_split(SL_PE_2010[[page]],"\n")[[1]][1],"\r")
  
  # creating a proper table with separate columns for names, votes and percentage----
  Top1<-data.table("ColumnNames"=NamesTop$hello,"Votes"=ValuesT[,1],"Percentage"=ValuesT[,2])
  
  # converting the factors to numeric for votes and percentage columns----
  Top1[,2] <- lapply(Top1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  
  Top1[,3]<-lapply(Top1[,3], function(x) as.numeric(as.character(x)))
  
  # creating the final table with all the information----
  Electorate1<-data.table("Year"=2010,"District"=district,
                          "Electorate"=Name1,"ColNames"=Top1$ColumnNames,
                          "Votes"=Top1$Votes,
                          "Percentage"=Top1$Percentage)
  
  return(Electorate1)
}
