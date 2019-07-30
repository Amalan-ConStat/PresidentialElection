Extracted Data
================

7 Presidential elections happened until now(2019 July). The results of
these elections are stored in 7 different pdf files. Using R we can
extract that information without much issues. It is not enough, we need
to valid the data as well. So each election has been validated.

Sri Lanka has 22 districts or a total of 160 electorates. A unique
collection of electorates represent a district. Therefore, Total votes
gained by all districts should be equal to Total votes gained by all
electorates. Luckily until 2005 the election documents provided a
summary of votes thoroughly. Which made my data validation easy. In the
documents mentioned above there are district summary results always at
the last, almost like a summary.

So I figured better to tally the district summary results and electorate
summary results to see if the counts are equal. Most of the times they
are equal, but not always. Further, when tallying is not equal it lead
to problems in the table. These problems were mainly misprints of
values, missing labels for values and misrepresented labels for values.
After understanding such issues in the acquired pdf files from the
Elections Commission website, I found the exact places where these
errors occur and tabled them below. It consists information such as
Number of Candidates, Number of Districts, Number of Electorates and
finally No of Issues to be Resolved.

# Presidential Elections Summarized

| Year | Number of Candidates | Number of Districts |    No of Electorates    | No of Issues to be Resolved |
| :--: | :------------------: | :-----------------: | :---------------------: | :-------------------------: |
| 1982 |          5           |         22          |           160           |             10              |
| 1988 |          3           |         22          |           160           |              1              |
| 1994 |          6           |         22          |           160           |              1              |
| 1999 |          13          |         22          |           160           |              2              |
| 2005 |          13          |         22          | 160(W/O Displace Votes) |              1              |
| 2010 |          22          |         22          | 160(W/O Displace Votes) |              1              |
| 2015 |          19          |         22          |           160           |              0              |

# Resolving Extracted Data

Issues can be resolved in these data-sets without any trouble and below
is the process of performing those tasks. If you need to take a thorough
look at the issues please refer the respective folders, which includes a
markdown page pin pointing exact issues and their respective places.

## Resolving Year 1982 Data

First ensure the first four columns of the data-set are factor variables
and final two columns are numeric variables. The rectifying process is
to change the misprinted values in the data-frame and in this case there
are 10 values.

``` r
# changing variable type
Election1982$Year<-factor(Election1982$Year) ; class(Election1982$Year)
Election1982$District<-factor(Election1982$District) ; class(Election1982$District)
Election1982$Electorate<-factor(Election1982$Electorate) ; class(Election1982$Electorate)
Election1982$ColNames<-factor(Election1982$ColNames) ; class(Election1982$ColNames)
class(Election1982$Votes)
class(Election1982$Percentage)

# Rectify Colombo district misprint
# it should be 972191 but printed as 972196
Election1982$Votes[Election1982$District=="Colombo" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="No of Registered Electors"]<-972191

# Rectify Matale district misprint
# it should be 187276 but printed as 187286
Election1982$Votes[Election1982$District=="Matale" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="No of Registered Electors"]<-187276

# Rectify Monaragala district misprint
# it should be 126540 but printed as 126558
Election1982$Votes[Election1982$District=="Monaragala" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="No of Registered Electors"]<-126540

# Rectify Nuwara-Eliya district misprint
# it should be 164817 but printed as 174817
Election1982$Votes[Election1982$District=="Nuwara-Eliya" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="Total No of Votes Polled"]<-164817

# Rectify Batticaloa district misprint
# it should be 2879 but printed as 2869
Election1982$Votes[Election1982$District=="Batticaloa" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="No of Rejected Votes"]<-2879

# Rectify Gampaha district misprint
# it should be 696844 but printed as 696838
Election1982$Votes[Election1982$District=="Gampaha" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="No of Valid Votes"]<-696844

# Rectify Batticaloa district misprint
# it should be 365847 but printed as 365838
Election1982$Votes[Election1982$District=="Gampaha" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="Mr.J.R. Jayawardene"]<-365847

# Rectify Batticaloa district misprint
# it should be 44775 but printed as 44780
Election1982$Votes[Election1982$District=="Jaffna" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="Mr.J.R. Jayawardene"]<-44775

# Rectify Colombo district misprint
# it should be 9219 but printed as 9655
Election1982$Votes[Election1982$District=="Colombo" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="Dr. Colvin R. De Silva"]<-9219

# Rectify Jaffna district misprint
# it should be 2176 but printed as 2186
Election1982$Votes[Election1982$District=="Jaffna" & 
                   Election1982$Electorate =="Total" & 
                   Election1982$ColNames=="Mr. Vasudeva Nanayakkara"]<-2176
```

After rectifying, check if the district tallying and electorate tallying
provide same values as below.

``` r
# Extracting only Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting except Final District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting except Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="Total No of Votes Polled")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# No of Rejected Votes
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting except Final District Results of 
# No of Rejected Votes
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="No of Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# No of Valid Votes
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# No of Valid Votes
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="No of Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Mr.J.R. Jayawardene
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="Mr.J.R. Jayawardene")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mr.J.R. Jayawardene
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="Mr.J.R. Jayawardene")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Dr. Colvin R. De Silva 
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="Dr. Colvin R. De Silva")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Dr. Colvin R. De Silva 
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="Dr. Colvin R. De Silva")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]

# Extracting only Final District Results of 
# Mr. Vasudeva Nanayakakra 
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate=="Total" 
                      & ColNames=="Mr. Vasudeva Nanayakkara")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mr. Vasudeva Nanayakakra 
# and then adding all the votes 
ElecFinal1982<-subset(Election1982,Electorate!="Total" 
                      & ColNames=="Mr. Vasudeva Nanayakkara")
# added votes will be cross checked with the pdf document
ElecFinal1982[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

According to the tests they seem fine.

## Resolving Year 1988 Data

Year 1988 presidential election file has no misprints that needs to be
considered.

``` r
# changing variable type
Election1988$Year<-factor(Election1988$Year) ; class(Election1988$Year)
Election1988$District<-factor(Election1988$District) ; class(Election1988$District)
Election1988$Electorate<-factor(Election1988$Electorate) ; class(Election1988$Electorate)
Election1988$ColNames<-factor(Election1988$ColNames) ; class(Election1988$ColNames)
class(Election1988$Votes)
class(Election1988$Percentage)
```

There are no rectifications need to be done.

## Resolving Year 1994 Data

In the year 1994 there is only rectification needs to be done.
Rectifying the district tally value issues for Battiacaloa district in
related to Mr. Hudson Samarasinghe.

``` r
# changing variable type
Election1994$Year<-factor(Election1994$Year) ; class(Election1994$Year)
Election1994$District<-factor(Election1994$District) ; class(Election1994$District)
Election1994$Electorate<-factor(Election1994$Electorate) ; class(Election1994$Electorate)
Election1994$ColNames<-factor(Election1994$ColNames) ; class(Election1994$ColNames)
class(Election1994$Votes)
class(Election1994$Percentage)

# Rectify Batticaloa district misprint
# it should be 5030 but printed as 5028
Election1994$Votes[Election1994$District=="Batticaloa" & 
                   Election1994$Electorate =="Final District Results" & 
                   Election1994$ColNames=="Mr. Hudson Samarasinghe"]<-5030
```

It seems the rectification is successful.

``` r
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

## Resolving Year 1999 Data

Two value misprints occur for the year 1999, where one of them is for
rejected votes of Jaffna district and other is for Valid votes from
Anuradhapura district.

``` r
# changing variable type
Election1999$Year<-factor(Election1999$Year) ; class(Election1999$Year)
Election1999$District<-factor(Election1999$District) ; class(Election1999$District)
Election1999$Electorate<-factor(Election1999$Electorate) ; class(Election1999$Electorate)
Election1999$ColNames<-factor(Election1999$ColNames) ; class(Election1999$ColNames)
class(Election1999$Votes)
class(Election1999$Percentage)

# Rectify Jaffna district misprint
# it should be 5981 but printed as 5982
Election1999$Votes[Election1999$District=="JAFFNA" & 
                   Election1999$Electorate =="FINAL DISTRICT RESULTS" & 
                   Election1999$ColNames=="Rejected Votes"]<-5981
# Rectify Anuradhapura district misprint
# it should be 349201 but printed as 349209
Election1999$Votes[Election1999$District=="ANURADHAPURA" & 
                   Election1999$Electorate =="FINAL DISTRICT RESULTS" & 
                   Election1999$ColNames=="Valid Votes"]<-349201
```

It seems the rectification is successful.

``` r
# Extracting only Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal1999<-subset(Election1999,Electorate=="FINAL DISTRICT RESULTS" 
                      & ColNames=="Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1999[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal1999<-subset(Election1999,Electorate!="FINAL DISTRICT RESULTS" 
                      & ColNames=="Rejected Votes")
# added votes will be cross checked with the pdf document
ElecFinal1999[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Valid Votes
# and then adding all the votes 
ElecFinal1999<-subset(Election1999,Electorate=="FINAL DISTRICT RESULTS" 
                      & ColNames=="Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1999[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Valid Votes
# and then adding all the votes 
ElecFinal1999<-subset(Election1999,Electorate!="FINAL DISTRICT RESULTS" 
                      & ColNames=="Valid Votes")
# added votes will be cross checked with the pdf document
ElecFinal1999[,sum(Votes),by="ColNames"]
```

## Resolving Year 2005 Data

Year 2005 has only one issue to be rectified and it is not related to
votes. The rectification needs to be done in a name replacing of “De”
with “de”.

``` r
# changing variable type
Election2005$Year<-factor(Election2005$Year) ; class(Election2005$Year)
Election2005$District<-factor(Election2005$District) ; class(Election2005$District)
Election2005$Electorate<-factor(Election2005$Electorate) ; class(Election2005$Electorate)
Election2005$ColNames<-factor(Election2005$ColNames) ; class(Election2005$ColNames)
class(Election2005$Votes)
class(Election2005$Percentage)

# Rectify name misprint
# it should be de but printed as De
Election2005$ColNames[Election2005$ColNames=="Aruna De Soyza"]<-"Aruna de Soyza"
```

After rectification checking if it has worked.

``` r
# Extracting only Final District Results of 
# Mr. Aruna de Zoya     
# and then adding all the votes 
ElecFinal2005<-subset(Election2005,Electorate=="Total" 
                      & ColNames=="Aruna de Soyza")
# added votes will be cross checked with the pdf document
ElecFinal2005[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Mr. Aruna de Zoya    
# and then adding all the votes 
ElecFinal2005<-subset(Election2005,Electorate!="Total" 
                      & ColNames=="Aruna de Soyza")
# added votes will be cross checked with the pdf document
ElecFinal2005[,sum(Votes),by="ColNames"]
```

It seems successful.

## Resolving Year 2010 Data

Similar to year 2005 mislabeling a value is the error that needs to be
rectified. Which is from the Kurunegala district Kuliyapitiya electorate
and the issue is where the last vote value should be labelled as “Regis
Electors” not “Total Polled”.

``` r
# changing variable type
Election2010$Year<-factor(Election2010$Year) ; class(Election2010$Year)
Election2010$District<-factor(Election2010$District) ; class(Election2010$District)
Election2010$Electorate<-factor(Election2010$Electorate) ; class(Election2010$Electorate)
Election2010$ColNames<-factor(Election2010$ColNames) ; class(Election2010$ColNames)
class(Election2010$Votes)
class(Election2010$Percentage)

# Rectify Column name misprint
# it should be Regis Electors but printed as Total Polled
Election2010$ColNames[Election2010$District=="Kurunegala" & 
                      Election2010$Electorate=="Kuliyapitiya" &
                      Election2010$Votes==94743]<-"Regis Electors"
```

After Rectification clearly there are no issues which occurred earlier.

``` r
# Extracting only Final District Results of 
# Registered Electors
# and then adding all the votes 
ElecFinal2010<-subset(Election2010,Electorate=="Final District Result" 
                      & ColNames=="Regis Electors")
# added votes will be cross checked with the pdf document
ElecFinal2010[,sum(Votes),by="ColNames"]
# Extracting only Final District Results of 
# Registered Electors
# and then adding all the votes
ElecFinal2010<-subset(Election2010,Electorate!="Final District Result"
                      & Electorate!="Postal District Votes" 
                      & Electorate!="Displace Votes"
                      & ColNames=="Regis Electors")
# added votes will be cross checked with the pdf document
ElecFinal2010[,sum(Votes),by="ColNames"]

# Extracting only Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal2010<-subset(Election2010,Electorate=="Final District Result" 
                      & ColNames=="Total Polled")
# added votes will be cross checked with the pdf document
ElecFinal2010[,sum(Votes),by="ColNames"]

# Extracting except Final District Results of 
# Total Polled
# and then adding all the votes 
ElecFinal2010<-subset(Election2010,Electorate!="Final District Result" 
                      & ColNames=="Total Polled")
# added votes will be cross checked with the pdf document
ElecFinal2010[,sum(Votes),by="ColNames"]
```

## Resolving Year 2015 Data

There are no issues which needs to be resolved in the year 2015 and all
looks good.

``` r
# changing variable type
Election2015$Year<-factor(Election2015$Year) ; class(Election2015$Year)
Election2015$District<-factor(Election2015$District) ; class(Election2015$District)
Election2015$Electorate<-factor(Election2015$Electorate) ; class(Election2015$Electorate)
Election2015$ColNames<-factor(Election2015$ColNames) ; class(Election2015$ColNames)
class(Election2015$Votes)
class(Election2015$Percentage)
```

# 

*THANK YOU*
