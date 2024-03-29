Extracted Data Part 1
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

First ensure out of the first four columns the last three are character
variables and the rest three columns are numeric variables. This needs
to be done for all seven data-frames.

## Resolving Year 1982 Data

The rectifying process is to change the misprinted values in the
data-frame and in this case there are 10 values.

``` r
# checking variable type
class(Election1982$Year)
class(Election1982$District)
class(Election1982$Electorate)
class(Election1982$ColNames)
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
# checking variable type
class(Election1988$Year)
class(Election1988$District)
class(Election1988$Electorate)
class(Election1988$ColNames)
class(Election1988$Votes)
class(Election1988$Percentage)
```

There are no rectifications need to be done.

## Resolving Year 1994 Data

In the year 1994 there is only rectification needs to be done.
Rectifying the district tally value issues for Batticaloa district in
related to Mr. Hudson Samarasinghe.

``` r
# checking variable type
class(Election1994$Year)
class(Election1994$District)
class(Election1994$Electorate)
class(Election1994$ColNames)
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
# checking variable type
class(Election1999$Year)
class(Election1999$District)
class(Election1999$Electorate)
class(Election1999$ColNames)
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
# checking variable type
class(Election2005$Year)
Election2005$District<-as.character(Election2005$District) ;class(Election2005$District)
Election2005$Electorate<-as.character(Election2005$Electorate) ; class(Election2005$Electorate)
class(Election2005$ColNames)
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
# checking variable type
class(Election2010$Year)
class(Election2010$District)
class(Election2010$Electorate)
class(Election2010$ColNames)
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
# checking variable type
class(Election2015$Year)
class(Election2015$District)
class(Election2015$Electorate)
class(Election2015$ColNames)
class(Election2015$Votes)
class(Election2015$Percentage)
```

# One Useful Data-frame

After resolving issues related to data mislabeling and value misprinting
all seven data-frames will look adequate individually. Yet this is not
enough because combining these seven presidential elections and
producing one data-frame will be more useful.

In order to create this one data-frame we have to ensure that in all
years the districts and electorates are not misspelled. Further ensure
vote counts such as Rejected, Polled, Valid and Registered are labelled
throughout these respective seven years under similar names. This naming
variables should also be used for “Postal votes” and “Final District
Results”.

After completing these conditions it is possible to combine all seven
data-frames to one useful data-frame. Below is the code for completing
that task.

## Comparing District Names

1.  Change case sensitiveness for year 1999 and 2005.
2.  Ampara - 2015 but Digamadulla - 1982,1988,1994,1994,1999,2005,2010.
3.  Moneragala - 1988,1994,1999 but Monaragala - 1982,2005,2010,2015.
4.  Kandy - 2015 but Mahanuwara - 1982,1988,1994,1999,2005,2010,2015.
5.  Nuwara-Eliya - 1982,1988,2005 but Nuwara Eliya - 1999,2010,2015 and
    Nuwara - Eliya - 1994.
6.  Kalutara - 1982,1988,1994,1999,2005,2010 but Kaluthara - 2015.
7.  Batticaloa - 1982,1994,1999,2005,2010,2015 but Batticoloa - 1988.

<!-- end list -->

``` r
#data.table(sort(unique(Election1982$District)),
#           sort(unique(Election1988$District)),
#           sort(unique(Election1994$District)),
#           sort(unique(Election1999$District)),
#           sort(unique(Election2005$District)),
#           sort(unique(Election2010$District)),
#           sort(unique(Election2015$District))
#           )

# 1. Case sensitive
Election1999$District<-tools::toTitleCase(tolower(Election1999$District))
Election2005$District<-tools::toTitleCase(tolower(Election2005$District))

# 2. Ampara or Digamadulla to Digamadulla
Election2015$District[Election2015$District=="Ampara"]<-"Digamadulla"

# 3. Monaragala or Moneragala to Monaragala 
Election1988$District[Election1988$District=="Moneragala"]<-"Monaragala"
Election1994$District[Election1994$District=="Moneragala"]<-"Monaragala"
Election1999$District[Election1999$District=="Moneragala"]<-"Monaragala"

# 4. Kandy to Mahanuwara 
Election2015$District[Election2015$District=="Kandy"]<-"Mahanuwara"

# 5. Nuwara-Eliya or Nuwara Eliya or Nuwara - Eliya to Nuwara-Eliya
Election1999$District[Election1999$District=="Nuwara Eliya"]<-"Nuwara-Eliya"
Election2010$District[Election2010$District=="Nuwara Eliya"]<-"Nuwara-Eliya"
Election2015$District[Election2015$District=="Nuwara Eliya"]<-"Nuwara-Eliya"
Election1994$District[Election1994$District=="Nuwara - Eliya"]<-"Nuwara-Eliya"

# 6. Kalutara or Kaluthara to Kalutara
Election2015$District[Election2015$District=="Kaluthara"]<-"Kalutara"

# 7. Batticaloa or Batticoloa to Batticaloa
Election1988$District[Election1988$District=="Batticoloa"]<-"Batticaloa"
```

## Comparing Electorate Names

1.  Change case sensitiveness for year 1999.
2.  Electorate spelling check for year 1982.
3.  Electorate spelling check for year 1988.
4.  Electorate spelling check for year 1994.
5.  Electorate spelling check for year 1999.
6.  Electorate spelling check for year 2005.
7.  Electorate spelling check for year 2010.
8.  Electorate spelling check for year 2015.

<!-- end list -->

``` r
#sort(unique(c(sort(unique(Election1982$Electorate)),
#           sort(unique(Election1988$Electorate)),
#           sort(unique(Election1994$Electorate)),
#           sort(unique(Election1999$Electorate)),
#           sort(unique(Election2005$Electorate)),
#           sort(unique(Election2010$Electorate)),
#           sort(unique(Election2015$Electorate))
#             )
#           )
#    )

#data.table(sort(unique(Election1982$Electorate)),
#           sort(unique(Election1988$Electorate)),
#           sort(unique(Election1994$Electorate)),
#           sort(unique(Election1999$Electorate)),
#           sort(unique(Election2005$Electorate)),
#           sort(unique(Election2010$Electorate)),
#           sort(unique(Election2015$Electorate))
#             )

# 1. Case Sensitive for Year 1999
Election1999$Electorate<-tools::toTitleCase(tolower(Election1999$Electorate))

# 2. Spelling check for year 1982
Election1982$Electorate[Election1982$Electorate=="Bddegama"]<-"Baddegama"
Election1982$Electorate[Election1982$Electorate=="Bibila"]<-"Bibile"
Election1982$Electorate[Election1982$Electorate=="Biyagma"]<-"Biyagama"
Election1982$Electorate[Election1982$Electorate=="Copay"]<-"Kopay"
Election1982$Electorate[Election1982$Electorate=="Ehaliyagoda"]<-"Eheliyagoda"
Election1982$Electorate[Election1982$Electorate=="Galgamuva"]<-"Galgamuwa"
Election1982$Electorate[Election1982$Electorate=="Habraduwa"]<-"Habaraduwa"
Election1982$Electorate[Election1982$Electorate=="Haguranketa"]<-"Hanguranketha"
Election1982$Electorate[Election1982$Electorate=="Harispttuwa"]<-"Harispattuwa"
Election1982$Electorate[Election1982$Electorate=="Hewahata"]<-"Hewaheta"
Election1982$Electorate[Election1982$Electorate=="Horowpatana"]<-"Horowapatana"
Election1982$Electorate[Election1982$Electorate=="Kaburupitiya"]<-"Kamburupitiya"
Election1982$Electorate[Election1982$Electorate=="Kalkudha"]<-"Kalkuda"
Election1982$Electorate[Election1982$Electorate=="Kankesanturai"]<-"Kankesanthurai"
Election1982$Electorate[Election1982$Electorate=="karandeniya"]<-"Karandeniya"
Election1982$Electorate[Election1982$Electorate=="Kesbawa"]<-"Kesbewa"
Election1982$Electorate[Election1982$Electorate=="Kothmale"]<-"Kotmale"
Election1982$Electorate[Election1982$Electorate=="Madirigiriya"]<-"Medirigiriya"
Election1982$Electorate[Election1982$Electorate=="Madawachchiya"]<-"Medawachchiya"
Election1982$Electorate[Election1982$Electorate=="Mahiyanganaya"]<-"Mahiyangane"
Election1982$Electorate[Election1982$Electorate=="Mawathgama"]<-"Mawathagama"
Election1982$Electorate[Election1982$Electorate=="Mavanella"]<-"Mawanella"
Election1982$Electorate[Election1982$Electorate=="Mulativu"]<-"Mullaitivu"
Election1982$Electorate[Election1982$Electorate=="N.Eliya.-Maskeliya"]<-"Nuwara-Eliya-Maskeliya"
Election1982$Electorate[Election1982$Electorate=="Nikavaratiya"]<-"Nikaweratiya"
Election1982$Electorate[Election1982$Electorate=="Pallmadulla"]<-"Pelmadulla"
Election1982$Electorate[Election1982$Electorate=="Patha-dumbara"]<-"Patha-Dumbara"
Election1982$Electorate[Election1982$Electorate=="PointPedro"]<-"Point-Pedro"
Election1982$Electorate[Election1982$Electorate=="Postal Votes"]<-"Postal District Votes"
Election1982$Electorate[Election1982$Electorate=="Rathgama"]<-"Ratgama"
Election1982$Electorate[Election1982$Electorate=="Rathtota"]<-"Rattota"
Election1982$Electorate[Election1982$Electorate=="Samanthurai"]<-"Sammanthurai"
Election1982$Electorate[Election1982$Electorate=="Tangalla"]<-"Tangalle"
Election1982$Electorate[Election1982$Electorate=="Total"]<-"Final District Results"
Election1982$Electorate[Election1982$Electorate=="UduNuwara"]<-"Udunuwara"
Election1982$Electorate[Election1982$Electorate=="Vawniya"]<-"Vavuniya"
Election1982$Electorate[Election1982$Electorate=="Wallawaya"]<-"Wellawaya"
Election1982$Electorate[Election1982$Electorate=="YatiNuwara"]<-"Yatinuwara"

# 3. Spelling Check for year 1988
Election1988$Electorate[Election1988$Electorate=="Biyagma"]<-"Biyagama"
Election1988$Electorate[Election1988$Electorate=="Chavakacheri"]<-"Chavakachcheri"
Election1988$Electorate[Election1988$Electorate=="Galagamuwa"]<-"Galgamuwa"
Election1988$Electorate[Election1988$Electorate=="Galagedera"]<-"Galagedara"
Election1988$Electorate[Election1988$Electorate=="Horawupotana"]<-"Horowapatana"
Election1988$Electorate[Election1988$Electorate=="Kaikudah"]<-"Kalkuda"
Election1988$Electorate[Election1988$Electorate=="Kesbawa"]<-"Kesbewa"
Election1988$Electorate[Election1988$Electorate=="Mahiyangana"]<-"Mahiyangane"
Election1988$Electorate[Election1988$Electorate=="Moneragala"]<-"Monaragala"
Election1988$Electorate[Election1988$Electorate=="Patha-dumbara"]<-"Patha-Dumbara"
Election1988$Electorate[Election1988$Electorate=="Postal Votes"]<-"Postal District Votes"
Election1988$Electorate[Election1988$Electorate=="Tangalla"]<-"Tangalle"
Election1988$Electorate[Election1988$Electorate=="Total"]<-"Final District Results"
Election1988$Electorate[Election1988$Electorate=="Tissamaharamaya"]<-"Tissamaharama"
Election1988$Electorate[Election1988$Electorate=="Udu-dumbara"]<-"Udu-Dumbara"
Election1988$Electorate[Election1988$Electorate=="Vaddukoddai"]<-"Vaddukkoddai"

# 4. Spelling Check for year 1994
Election1994$Electorate[Election1994$Electorate=="Colombo-Cental"]<-"Colombo-Central"
Election1994$Electorate[Election1994$Electorate=="Colombo-west"]<-"Colombo-West"
Election1994$Electorate[Election1994$Electorate=="Eheliyagada"]<-"Eheliyagoda"
Election1994$Electorate[Election1994$Electorate=="Galagedera"]<-"Galagedara"
Election1994$Electorate[Election1994$Electorate=="Hariapattuwa"]<-"Harispattuwa"
Election1994$Electorate[Election1994$Electorate=="Horawupotana"]<-"Horowapatana"
Election1994$Electorate[Election1994$Electorate=="Kalkudah"]<-"Kalkuda"
Election1994$Electorate[Election1994$Electorate=="Kalmuni"]<-"Kalmunai"
Election1994$Electorate[Election1994$Electorate=="Karndeniya"]<-"Karandeniya"
Election1994$Electorate[Election1994$Electorate=="Mahiyanganaya"]<-"Mahiyangane"
Election1994$Electorate[Election1994$Electorate=="Mihinthalaya"]<-"Mihintale"
Election1994$Electorate[Election1994$Electorate=="Moneragala"]<-"Monaragala"
Election1994$Electorate[Election1994$Electorate=="Postal Votes"]<-"Postal District Votes"
Election1994$Electorate[Election1994$Electorate=="Ramukkana"]<-"Rambukkana"
Election1994$Electorate[Election1994$Electorate=="Tangalla"]<-"Tangalle"
Election1994$Electorate[Election1994$Electorate=="Tissamaharamaya"]<-"Tissamaharama"
Election1994$Electorate[Election1994$Electorate=="Uva-paranagama"]<-"Uva-Paranagama"
Election1994$Electorate[Election1994$Electorate=="Uda-Dumbara"]<-"Udu-Dumbara"
Election1994$Electorate[Election1994$Electorate=="Vaddukoddai"]<-"Vaddukkoddai"

# 5. Spelling Check for year 1999
Election1999$Electorate[Election1999$Electorate=="Anuradhapura - East"]<-"Anuradhapura-East"
Election1999$Electorate[Election1999$Electorate=="Anuradhapura - West"]<-"Anuradhapura-West"
Election1999$Electorate[Election1999$Electorate=="Bentara - Elpitiya"]<-"Bentara-Elpitiya"
Election1999$Electorate[Election1999$Electorate=="Colombo - Central"]<-"Colombo-Central"
Election1999$Electorate[Election1999$Electorate=="Colombo - East"]<-"Colombo-East"
Election1999$Electorate[Election1999$Electorate=="Colombo - North"]<-"Colombo-North"
Election1999$Electorate[Election1999$Electorate=="Colombo - West"]<-"Colombo-West"
Election1999$Electorate[Election1999$Electorate=="Hali - Ela"]<-"Hali-Ela"
Election1999$Electorate[Election1999$Electorate=="Hanguranketa"]<-"Hanguranketha"
Election1999$Electorate[Election1999$Electorate=="Horowupotana"]<-"Horowapatana"
Election1999$Electorate[Election1999$Electorate=="Ja - Ela"]<-"Ja-Ela"
Election1999$Electorate[Election1999$Electorate=="Kalkudah"]<-"Kalkuda"
Election1999$Electorate[Election1999$Electorate=="Kankesanturai"]<-"Kankesanthurai"
Election1999$Electorate[Election1999$Electorate=="Moneragala"]<-"Monaragala"
Election1999$Electorate[Election1999$Electorate=="Nuwara -Eliya - Maskeliya"]<-"Nuwara-Eliya-Maskeliya"
Election1999$Electorate[Election1999$Electorate=="Patha - Dumbara"]<-"Patha-Dumbara"
Election1999$Electorate[Election1999$Electorate=="Padiruppu"]<-"Paddiruppu"
Election1999$Electorate[Election1999$Electorate=="Point Pedro"]<-"Point-Pedro"
Election1999$Electorate[Election1999$Electorate=="Postal Votes"]<-"Postal District Votes"
Election1999$Electorate[Election1999$Electorate=="Potuvil"]<-"Pottuvil"
Election1999$Electorate[Election1999$Electorate=="Sammnturai"]<-"Sammanthurai"
Election1999$Electorate[Election1999$Electorate=="Uda - Dumbara"]<-"Udu-Dumbara"
Election1999$Electorate[Election1999$Electorate=="Uva - Paranagama"]<-"Uva-Paranagama"

# 6. Spelling Check for year 2005
Election2005$Electorate[Election2005$Electorate=="Balapitya"]<-"Balapitiya"
Election2005$Electorate[Election2005$Electorate=="Displaced"]<-"Displaced District Votes"
Election2005$Electorate[Election2005$Electorate=="Hanguranketa"]<-"Hanguranketha"
Election2005$Electorate[Election2005$Electorate=="Horowupotana"]<-"Horowapatana"
Election2005$Electorate[Election2005$Electorate=="Kalkudah"]<-"Kalkuda"
Election2005$Electorate[Election2005$Electorate=="Kankesanturai"]<-"Kankesanthurai"
Election2005$Electorate[Election2005$Electorate=="Maskelliya"]<-"Nuwara-Eliya-Maskeliya"
Election2005$Electorate[Election2005$Electorate=="Moneragala"]<-"Monaragala"
Election2005$Electorate[Election2005$Electorate=="Mullativu"]<-"Mullaitivu"
Election2005$Electorate[Election2005$Electorate=="Padiruppu"]<-"Paddiruppu"
Election2005$Electorate[Election2005$Electorate=="Postal"]<-"Postal District Votes"
Election2005$Electorate[Election2005$Electorate=="Potuvil"]<-"Pottuvil"
Election2005$Electorate[Election2005$Electorate=="Sammanturai"]<-"Sammanthurai"
Election2005$Electorate[Election2005$Electorate=="Total"]<-"Final District Results"
Election2005$Electorate[Election2005$Electorate=="Uda-Dumbara"]<-"Udu-Dumbara"

# 7. Spelling Check for year 2010 
Election2010$Electorate[Election2010$Electorate=="Anuradapura-East"]<-"Anuradhapura-East"
Election2010$Electorate[Election2010$Electorate=="Anuradapura-West"]<-"Anuradhapura-West"
Election2010$Electorate[Election2010$Electorate=="Dabadeniya"]<-"Dambadeniya"
Election2010$Electorate[Election2010$Electorate=="Displace Votes"]<-"Displaced District Votes"
Election2010$Electorate[Election2010$Electorate=="Final District Result"]<-"Final District Results"
Election2010$Electorate[Election2010$Electorate=="Hanguranketa"]<-"Hanguranketha"
Election2010$Electorate[Election2010$Electorate=="Kankesanturai"]<-"Kankesanthurai"
Election2010$Electorate[Election2010$Electorate=="Medwachchiya"]<-"Medawachchiya"
Election2010$Electorate[Election2010$Electorate=="Medirigiya"]<-"Medirigiriya"
Election2010$Electorate[Election2010$Electorate=="Moneragala"]<-"Monaragala"
Election2010$Electorate[Election2010$Electorate=="Negambo"]<-"Negombo"
Election2010$Electorate[Election2010$Electorate=="Nuwara-Eliya Maskeliya"]<-"Nuwara-Eliya-Maskeliya"
Election2010$Electorate[Election2010$Electorate=="Padiruppu"]<-"Paddiruppu"
Election2010$Electorate[Election2010$Electorate=="Paduwasnuwara"]<-"Panduwasnuwara"
Election2010$Electorate[Election2010$Electorate=="Patha Dumbara"]<-"Patha-Dumbara"
Election2010$Electorate[Election2010$Electorate=="Point Pedero"]<-"Point-Pedro"
Election2010$Electorate[Election2010$Electorate=="Potuvil"]<-"Pottuvil"
Election2010$Electorate[Election2010$Electorate=="Puttalama"]<-"Puttalam"
Election2010$Electorate[Election2010$Electorate=="Rabukkana"]<-"Rambukkana"
Election2010$Electorate[Election2010$Electorate=="Sammanturai"]<-"Sammanthurai"

# 8. Spelling Check for year 2015
Election2015$Electorate[Election2015$Electorate=="Anuradapura-East"]<-"Anuradhapura-East"
Election2015$Electorate[Election2015$Electorate=="Anuradapura-West"]<-"Anuradhapura-West"
Election2015$Electorate[Election2015$Electorate=="Belitta"]<-"Beliatta"
Election2015$Electorate[Election2015$Electorate=="Biyagame"]<-"Biyagama"
Election2015$Electorate[Election2015$Electorate=="Dabadeniya"]<-"Dambadeniya"
Election2015$Electorate[Election2015$Electorate=="Dabulla"]<-"Dambulla"
Election2015$Electorate[Election2015$Electorate=="Final District Result"]<-"Final District Results"
Election2015$Electorate[Election2015$Electorate=="Hakmane"]<-"Hakmana"
Election2015$Electorate[Election2015$Electorate=="Hanguranketa"]<-"Hanguranketha"
Election2015$Electorate[Election2015$Electorate=="Kankesanturai"]<-"Kankesanthurai"
Election2015$Electorate[Election2015$Electorate=="Medwachchiya"]<-"Medawachchiya"
Election2015$Electorate[Election2015$Electorate=="Medirigiya"]<-"Medirigiriya"
Election2015$Electorate[Election2015$Electorate=="Moneragala"]<-"Monaragala"
Election2015$Electorate[Election2015$Electorate=="Negambo"]<-"Negombo"
Election2015$Electorate[Election2015$Electorate=="Nuwara - Eliya"]<-"Nuwara-Eliya-Maskeliya"
Election2015$Electorate[Election2015$Electorate=="Padiruppu"]<-"Paddiruppu"
Election2015$Electorate[Election2015$Electorate=="Paduwasnuwara"]<-"Panduwasnuwara"
Election2015$Electorate[Election2015$Electorate=="Patha Dumbara"]<-"Patha-Dumbara"
Election2015$Electorate[Election2015$Electorate=="Point Pedero"]<-"Point-Pedro"
Election2015$Electorate[Election2015$Electorate=="Potuvil"]<-"Pottuvil"
Election2015$Electorate[Election2015$Electorate=="Puttalama"]<-"Puttalam"
Election2015$Electorate[Election2015$Electorate=="Rabukkana"]<-"Rambukkana"
Election2015$Electorate[Election2015$Electorate=="Sammanturai"]<-"Sammanthurai"
```

## Comparing Column Names

1.  Label changing in Year 1982.
2.  Label changing in Year 1988.
3.  Label changing in Year 1994.
4.  Label changing in Year 1999.
5.  Label changing in Year 2005.
6.  Label changing in Year 2010.
7.  Label changing in Year 2015.

<!-- end list -->

``` r
#data.table(unique(Election1982$ColNames),
#           unique(Election1988$ColNames),
#           unique(Election1994$ColNames),
#           unique(Election1999$ColNames),
#           unique(Election2005$ColNames),
#           unique(Election2010$ColNames),
#           unique(Election2015$ColNames)
#           )

# 1. Lable changing in Year 1982
Election1982$ColNames[Election1982$ColNames=="No of Valid Votes"]<-"Total No of Valid Votes"

# 2. Lable changing in Year 1988
Election1988$ColNames[Election1988$ColNames=="Total No of Valied Votes"]<-"Total No of Valid Votes"

# 3. Lable changing in Year 1994
Election1994$ColNames[Election1994$ColNames=="No of valid votes"]<-"Total No of Valid Votes"
Election1994$ColNames[Election1994$ColNames=="No of Rejected votes"]<-"No of Rejected Votes"
Election1994$ColNames[Election1994$ColNames=="Total No. of votes polled"]<-"Total No of Votes Polled"

# 4. Lable changing in Year 1999
Election1999$ColNames[Election1999$ColNames=="SLMK"]<-"Abdul Rasool"
Election1999$ColNames[Election1999$ColNames=="PFF"]<-"Alwis Weerakkody Premawardhana"
Election1999$ColNames[Election1999$ColNames=="DUNF"]<-"Ariyawansha Dissanayaka"
Election1999$ColNames[Election1999$ColNames=="JVP"]<-"M.D. Nandana Gunathilaka"
Election1999$ColNames[Election1999$ColNames=="PLSF"]<-"Kamal Karunadasa"
Election1999$ColNames[Election1999$ColNames=="PA"]<-"Chandrika Bandaranaike Kumaratunga"
Election1999$ColNames[Election1999$ColNames=="IND1"]<-"Tennyson Edirisuriya"
Election1999$ColNames[Election1999$ColNames=="IND2"]<-"W.V.M. Ranjith"
Election1999$ColNames[Election1999$ColNames=="UNP"]<-"Ranil Wickramasinghe"
Election1999$ColNames[Election1999$ColNames=="LP"]<-"Rajiva Wijesinha"
Election1999$ColNames[Election1999$ColNames=="LDA"]<-"Vasudeva Nanayakkara"
Election1999$ColNames[Election1999$ColNames=="IND3"]<-"Hudson Samarasinghe"
Election1999$ColNames[Election1999$ColNames=="SMBP"]<-"Harishchandra Wijayatunga"
Election1999$ColNames[Election1999$ColNames=="Valid Votes"]<-"Total No of Valid Votes"
Election1999$ColNames[Election1999$ColNames=="Rejected Votes"]<-"No of Rejected Votes"
Election1999$ColNames[Election1999$ColNames=="Total Polled"]<-"Total No of Votes Polled"
Election1999$ColNames[Election1999$ColNames=="Registered Electors"]<-"No of Registered Electors"

# 5. Lable changing in Year 2005
Election2005$ColNames[Election2005$ColNames=="Total Valid"]<-"Total No of Valid Votes"
Election2005$ColNames[Election2005$ColNames=="Total Rejected"]<-"No of Rejected Votes"
Election2005$ColNames[Election2005$ColNames=="Total Polled"]<-"Total No of Votes Polled"
Election2005$ColNames[Election2005$ColNames=="Total Registered"]<-"No of Registered Electors"

# 6. Lable changing in Year 2010
Election2010$ColNames[Election2010$ColNames=="Valid Votes"]<-"Total No of Valid Votes"
Election2010$ColNames[Election2010$ColNames=="Rejected Votes"]<-"No of Rejected Votes"
Election2010$ColNames[Election2010$ColNames=="Total Polled"]<-"Total No of Votes Polled"
Election2010$ColNames[Election2010$ColNames=="Regis Electors"]<-"No of Registered Electors"

# 7. Lable changing in Year 2015
Election2015$ColNames[Election2015$ColNames=="Valid Votes"]<-"Total No of Valid Votes"
Election2015$ColNames[Election2015$ColNames=="Rejected Votes"]<-"No of Rejected Votes"
Election2015$ColNames[Election2015$ColNames=="Total Polled"]<-"Total No of Votes Polled"
Election2015$ColNames[Election2015$ColNames=="Regis.Electors"]<-"No of Registered Electors"
Election2015$ColNames[Election2015$ColNames=="Mahinda Rajapaksa"]<-"Mahinda Rajapaksha"
```

After the above tasks are done all seven data-frames have columns with
similar format and labels. Yet this is not enough and now the focus is
shifted towards the individual cell values, which means Votes and
Percentages. Not all years share the same format.

In order to resolve the issues the markdown document
OneusefulDataframe.Rmd is used to explain the process thoroughly with
multiple steps. Which will lead to producing a final one data-frame with
less missing values. To be more clear there are some percentage values
not calculated in year 2005.

*THANK YOU*
