One Useful Data Frame 2
================

# Useful Data-frame

There are three types of table information for votes and percentages.
Below are three tables explaining them clearly. It should be noted that
these are mock tables. Most of the issues occur with related to Postal
District Votes. In year 2005 there are lot of missing values that needs
to be calculated.

Each table is a mock representation of how an entire district results
can be represented with all the necessary information. In the tables Yes
means the value exists and No means the cell is empty.

## Format of Data-frame for 1994, 2010 and 2015

The years 1994, 2010 and 2015 have the same format.

|         ColNames          | Electorate 1 | Electorate 1 | Electorate … | Electorate … | Postal District Votes | Postal District Votes | Final District Results | Final District Results |
| :-----------------------: | :----------: | :----------: | :----------: | :----------: | :-------------------: | :-------------------: | :--------------------: | :--------------------: |
|                           |    Votes     |  Percentage  |    Votes     |  Percentage  |         Votes         |      Percentage       |         Votes          |       Percentage       |
|     Candidate Name 1      |     Yes      |     Yes      |     Yes      |     Yes      |          Yes          |          Yes          |          Yes           |          Yes           |
|     Candidate Name …      |     Yes      |     Yes      |     Yes      |     Yes      |          Yes          |          Yes          |          Yes           |          Yes           |
|  Total No of Valid Votes  |     Yes      |     Yes      |     Yes      |     Yes      |          Yes          |          Yes          |          Yes           |          Yes           |
|   No of Rejected Votes    |     Yes      |     Yes      |     Yes      |     Yes      |          Yes          |          Yes          |          Yes           |          Yes           |
| Total No of Votes Polled  |     Yes      |     Yes      |     Yes      |     Yes      |          Yes          |          Yes          |          Yes           |          Yes           |
| No of Registered Electors |     Yes      |      No      |     Yes      |      No      |          Yes          |          No           |          Yes           |           No           |

# Rectify Votes and Percentages

## Rectify Data-frame for 1994

Nothing much change needs to be done, which is changing several missing
values to zero.

``` r
# setting missing votes values as zeros
Election1994$Votes[is.na(Election1994$Votes)]<-0
```

## Ensure if Still Tallying of District and Electorate votes are Equal for Year 1994

``` r
# Extracting only Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & Electorate!="Postal District Votes"
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Total polled
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Total polled
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# No of Rejected votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# No of Rejected votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# No of valid votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Total No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# No of valid votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Total No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Mrs. Chandrika Bandaranaike Kumarathunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mrs. Chandrika Bandaranaike Kumarathunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mrs. Chandrika Bandaranaike Kumarathunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mrs. Chandrika Bandaranaike Kumarathunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Mrs. Vajira Srimathi Dissanayake
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mrs. Vajira Srimathi Dissanayake")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mrs. Vajira Srimathi Dissanayake
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mrs. Vajira Srimathi Dissanayake")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Mr.Galappaththi Arachchige Nihal
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. Galappaththi Arachchige Nihal")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mr.Galappaththi Arachchige Nihal
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. Galappaththi Arachchige Nihal")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
#  Mr. A.J. Ranashinge
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. A.J. Ranashinge")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
#  Mr. A.J. Ranashinge
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. A.J. Ranashinge")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Dr. Harischandra Wijayatunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Dr. Harischandra Wijayatunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Dr. Harischandra Wijayatunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Dr. Harischandra Wijayatunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Mr. Hudson Samarasinghe 
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. Hudson Samarasinghe")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mr. Hudson Samarasinghe 
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. Hudson Samarasinghe")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

So now the Totals have changed and below is the final tally :

1.  No of Registered Electors : 10945065
2.  Total No of Valid Votes : 7561526
3.  No of Rejected Votes : 151706
4.  Total No of Polled Votes : 7713232
5.  Mrs. Chandrika Bandaranaike Kumarathunga : 4709205
6.  Mrs. Vajira Srimathi Dissanayake : 2715283  
7.  Mr. Galappaththi Arachchige Nihal : 22749
8.  Mr. A.J. Ranashinge : 22752
9.  Dr. Harischandra Wijayatunga : 32651
10. Mr. Hudson Samarasinghe : 58888

## Rectify Data-frame for 2010

Nothing needs to be done.

## Rectify Data-frame for 2015

Three changes needs to be done, one is changing several missing values
to zero in votes, second is replacing missing values in percentages and
finally adding a percentage value for Rambukkana Electorate Kegalle
District Total no of Votes Polled which is empty.

``` r
# setting missing votes values as zeros
Election2015$Percentage[is.na(Election2015$Votes)]<-0
Election2015$Votes[is.na(Election2015$Votes)]<-0

# Missing percentage value for Rambukkana electorate
# Kegalle district Total No of Votes Polled
Election2015$Percentage[Election2015$Electorate=="Rambukkana" & 
                        Election2015$District =="Kegalle" &
                        Election2015$ColNames=="Total No of Votes Polled"]<-round(5108500/65337,2)
```

## Ensure if Still Tallying of District and Electorate votes are Equal for Year 2015

``` r
# Extracting only Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & Electorate!="Postal District Votes"
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results"
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Rejected Votes
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Rejected Votes
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results"
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Valid Votes
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Total No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Valid Votes
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results"
                      & ColNames=="Total No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Maithripala Sirisena
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Maithripala Sirisena")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Maithripala Sirisena
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Maithripala Sirisena")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Mahinda Rajapaksa
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Mahinda Rajapaksha")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Mahinda Rajapaksa
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Mahinda Rajapaksha")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Aithurus Mohamed Illias 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Aithurus Mohamed Illias")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Aithurus Mohamed Illias 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Aithurus Mohamed Illias")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Ibrahim Miflar 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Ibrahim Miflar")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Ibrahim Miflar 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Ibrahim Miflar")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Prasanna Priyankara 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Prasanna Priyankara")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Prasanna Priyankara 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Prasanna Priyankara")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Wimal Geeganage 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Wimal Geeganage")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Wimal Geeganage 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Wimal Geeganage")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Sirithunga Jayasuriya 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Sirithunga Jayasuriya")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Sirithunga Jayasuriya 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Sirithunga Jayasuriya")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# M. B. Theminimulla 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="M. B. Theminimulla")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# M. B. Theminimulla 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="M. B. Theminimulla")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Pani Wijesiriwardane 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Pani Wijesiriwardane")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Pani Wijesiriwardane 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Pani Wijesiriwardane")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Duminda Nagamuwa
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Duminda Nagamuwa")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Duminda Nagamuwa 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Duminda Nagamuwa")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Panagoda Don Prince Soloman Anura Liyanage
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Panagoda Don Prince Soloman Anura Liyanage")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Panagoda Don Prince Soloman Anura Liyanage 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Panagoda Don Prince Soloman Anura Liyanage")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Ruwanthilaka Peduru Arachchi
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Ruwanthilaka Peduru Arachchi")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Ruwanthilaka Peduru Arachchi 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Ruwanthilaka Peduru Arachchi")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Anuruddha Polgampala
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Anuruddha Polgampala")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Anuruddha Polgampala 
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Anuruddha Polgampala")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Baththaramulle Seelarathana Thero
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Baththaramulle Seelarathana Thero")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Baththaramulle Seelarathana Thero
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Baththaramulle Seelarathana Thero")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Sarath Manamendra
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Sarath Manamendra")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Sarath Manamendra
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Sarath Manamendra")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Arachchige Rathnayaka Sirisena
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Arachchige Rathnayaka Sirisena")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Arachchige Rathnayaka Sirisena
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Arachchige Rathnayaka Sirisena")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Namal Rajapaksa
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Namal Rajapaksa")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Namal Rajapaksa
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Namal Rajapaksa")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Sundaram Mahendran
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Sundaram Mahendran")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Sundaram Mahendran
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Sundaram Mahendran")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Jayantha Kulathunga
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate=="Final District Results" 
                      & ColNames=="Jayantha Kulathunga")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Jayantha Kulathunga
# and then adding all the votes 
ElecFinal2015<-subset(Election2015,Electorate!="Final District Results" 
                      & ColNames=="Jayantha Kulathunga")
# added votes will be cross checked with the pdf document
ElecFinal2015[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

So now the Totals have changed and below is the final tally :

1.  No of Registered Electors : 15044490
2.  Total No of Valid Votes : 12123452
3.  No of Rejected Votes : 140925
4.  Total No of Polled Votes : 12264377
5.  Maithripala Sirisena : 6217162
6.  Mahinda Rajapaksha : 5768090
7.  Aithurus Mohamed Illias : 10618
8.  Ibrahim Miflar : 14379
9.  Prasanna Priyankara : 2793
10. Wimal Geeganage : 1826
11. Sirithunga Jayasuriya : 8840
12. M. B. Theminimulla : 3846
13. Pani Wijesiriwardane : 4277
14. Duminda Nagamuwa : 9941
15. Panagoda Don Prince Soloman Anura Liyanage : 14351
16. Ruwanthilaka Peduru Arachchi : 12436
17. Anuruddha Polgampala : 4260
18. Baththaramulle Seelarathana Thero : 3750
19. Sarath Manamendra : 6875
20. Arachchige Rathnayaka Sirisena : 18174
21. Namal Rajapaksa : 15726
22. Sundaram Mahendran : 4047
23. Jayantha Kulathunga : 2061

# Useful Data-frames

*THANK YOU*
