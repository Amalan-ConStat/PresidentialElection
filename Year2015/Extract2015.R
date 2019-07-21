# developing the function for two table situation----
Extract_twotable<-function(page)
{
  # dividing the page into two tables----
  table1<-data.table(str_split(SL_PE_2015[[page]],"\n")[[1]][4:26])
  table2<-data.table(str_split(SL_PE_2015[[page]],"\n")[[1]][29:51])
  
  # naming the column name----
  names(table1)<-"hello"
  names(table2)<-"hello"
  
  # same type of information in all tables----
  Names=c("Aithurus Mohamed Illias","Ibrahim Miflar","Prasanna Priyankara",
          "Wimal Geeganage","Sirithunga Jayasuriya","M. B. Theminimulla",
          "Pani Wijesiriwardane","Duminda Nagamuwa",
          "Panagoda Don Prince Soloman Anura Liyanage",
          "Maithripala Sirisena","Ruwanthilaka Peduru Arachchi",
          "Anuruddha Polgampala","Baththaramulle Seelarathana Thero",
          "Sarath Manamendra","Arachchige Rathnayaka Sirisena",
          "Mahinda Rajapaksa","Namal Rajapaksa","Sundaram Mahendran",
          "Jayantha Kulathunga","Valid Votes","Rejected Votes",
          "Total Polled","Regis.Electors")
  
  # remove the same type information and creating numbers only tables----
  Top<-cSplit(lapply(table1, function(x) str_remove(x,Names)),"hello"," ")
  Bottom<-cSplit(lapply(table2, function(x) str_remove(x,Names)),"hello"," ")
  
  # extracting the electorate Name above table----
  Name1<-str_remove(str_split(SL_PE_2015[[page]],"\n")[[1]][2],"\r")
  Name2<-str_remove(str_split(SL_PE_2015[[page]],"\n")[[1]][27],"\r")
  
  # creating a clean table with same type informaton votes and percentages----
  Top1<-data.table("ColumnNames"=Names,"Votes"=Top$hello_1,
                   "Percentage"=str_remove(Top$hello_2,"%"))
  Bottom1<-data.table("ColumnNames"=Names,"Votes"=Bottom$hello_1,
                      "Percentage"=str_remove(Bottom$hello_2,"%"))
  
  # converting class from factor to numeric for percentage and votes columns----
  Top1[,2] <- lapply(Top1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  Bottom1[,2] <- lapply(Bottom1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  
  Top1[,3]<-lapply(Top1[,3], function(x) as.numeric(as.character(x)))
  Bottom1[,3]<-lapply(Bottom1[,3], function(x) as.numeric(as.character(x)))
  
  # Creating the final tables with all information----
  Electorate1<-data.table("Year"=2015,
                          "District"=str_remove(
                                     str_split(SL_PE_2015[[page]],"\n")[[1]][1],
                                                " Districts Results\r"), 
                          "Electorate"=Name1,"ColNames"=Top1$ColumnNames,
                          "Votes"=Top1$Votes,
                          "Percentage"=Top1$Percentage)
  Electorate2<-data.table("Year"=2015,
                          "District"=str_remove(
                                     str_split(SL_PE_2015[[page]],"\n")[[1]][1],
                                                " Districts Results\r"),
                          "Electorate"=Name2,"ColNames"=Bottom1$ColumnNames,
                          "Votes"=Bottom1$Votes,
                          "Percentage"=Bottom1$Percentage)
  
  output<-rbind2(Electorate1,Electorate2)
  
  return(output)
}


# developing the function for one table situation----
Extract_onetable<-function(page)
{
  # extracting into one table----
  table1<-data.table(str_split(SL_PE_2015[[page]],"\n")[[1]][4:26])
  
  # naming the column name----
  names(table1)<-"hello"
  
  # same type of information in all table----
  Names=c("Aithurus Mohamed Illias","Ibrahim Miflar","Prasanna Priyankara",
          "Wimal Geeganage","Sirithunga Jayasuriya","M. B. Theminimulla",
          "Pani Wijesiriwardane","Duminda Nagamuwa",
          "Panagoda Don Prince Soloman Anura Liyanage",
          "Maithripala Sirisena","Ruwanthilaka Peduru Arachchi",
          "Anuruddha Polgampala","Baththaramulle Seelarathana Thero",
          "Sarath Manamendra","Arachchige Rathnayaka Sirisena",
          "Mahinda Rajapaksa","Namal Rajapaksa","Sundaram Mahendran",
          "Jayantha Kulathunga","Valid Votes","Rejected Votes",
          "Total Polled","Regis.Electors")
  
  # remove the same type information and creating numbers only table----
  Top<-cSplit(lapply(table1, function(x) str_remove(x,Names)),"hello"," ")
  
  # extracting the electorate Name above table----
  Name1<-str_remove(str_split(SL_PE_2015[[page]],"\n")[[1]][2],"\r")
  
  # creating a clean table with same type informaton votes and percentages----
  Top1<-data.table("ColumnNames"=Names,"Votes"=Top$hello_1,
                   "Percentage"=str_remove(Top$hello_2,"%"))
  
  # converting class from factor to numeric for percentage and votes columns----
  Top1[,2] <- lapply(Top1[,2], function(x) as.numeric(as.character(str_remove_all(x,","))))
  
  Top1[,3]<-lapply(Top1[,3], function(x) as.numeric(as.character(x)))
  
  # Creating the final table with all information----
  Electorate1<-data.table("Year"=2015,
                          "District"=str_remove(
                                     str_split(SL_PE_2015[[page]],"\n")[[1]][1],
                                                " Districts Results\r"), 
                          "Electorate"=Name1,"ColNames"=Top1$ColumnNames,
                          "Votes"=Top1$Votes,
                          "Percentage"=Top1$Percentage)
  
  output<-Electorate1
  
  return(output)
}