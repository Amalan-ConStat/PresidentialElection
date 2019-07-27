Election1994
================

# Structure of Document

Data extraction begins from page 4 of the document. Each page from here
has a table representing each district. All tables follow the similar
format.

If we consider the columns, first column is for candidate names with
other counts, second column and its consecutive columns are for
electorates. Final two columns are Postal Votes and Final District
Results.

Each cell has two numeric values which are number of votes and
percentages, this is true except for the last row. First 6 rows are for
candidates names, followed by No of Valid Votes, No of Rejected Votes,
Total No of votes polled and finally No of Registered Electors.

![](Fig1.JPG)

# Process of Extraction

Each table has been extracted separately without any issues. Two inputs
are used, one is page number other is for special cases for several
districts.

``` r
# load the pdf file
SL_PE_1994<-pdf_text("PresidentialElections1994.pdf")

# source the function
source("Extract1994.R")

# creating initial dataset Election1994
Election1994<-NULL

# chossing specific pages which does not have
# electorate name issues and scrapping them
for (i in c(6,9,11,12,14:19,21,23,24,25)) 
{
  Election1994[[i]]<-Extract_table1994(i)
}

# choosing specific pages which does have 
# electorate name issues and scrapping them
Election1994[[1]]<-Extract_table1994(8,NE=TRUE)
Election1994[[2]]<-Extract_table1994(4,Col=TRUE)
Election1994[[3]]<-Extract_table1994(5,Gam=TRUE)
Election1994[[4]]<-Extract_table1994(7,Ma=TRUE)
Election1994[[5]]<-Extract_table1994(13,Ja=TRUE)
Election1994[[7]]<-Extract_table1994(20,An=TRUE)
Election1994[[8]]<-Extract_table1994(22,Ba=TRUE)
Election1994[[10]]<-Extract_table1994(10,Ga=TRUE)

# final data set
Election1994<-do.call("rbind",Election1994)
```

# Validating Data Extracted

## Checking for Number of Registered Electors.

![](Fig2.JPG)

No issues here.

``` r
# Extracting only Final District District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                     ColNames       V1
    ## 1: No of Registered Electors 10945065

``` r
# Extracting except Final District District Results of 
# Number of Registered Electors
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & Electorate!="Postal Votes"
                      & ColNames=="No of Registered Electors")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                     ColNames       V1
    ## 1: No of Registered Electors 10945065

## Checking for Total polled

![](Fig2.JPG)

No issues here.

``` r
# Extracting only Final District District Results of 
# Total polled
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Total No. of votes polled")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                     ColNames      V1
    ## 1: Total No. of votes polled 7713232

``` r
# Extracting except Final District District Results of 
# Total polled
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Total No. of votes polled")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                     ColNames      V1
    ## 1: Total No. of votes polled 7713232

## Checking for Rejected Votes

![](Fig3.JPG)

No issues here.

``` r
# Extracting only Final District District Results of 
# No of Rejected votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="No of Rejected votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                ColNames     V1
    ## 1: No of Rejected votes 151706

``` r
# Extracting except Final District District Results of 
# No of Rejected votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="No of Rejected votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                ColNames     V1
    ## 1: No of Rejected votes 151706

## Checking for Valid Votes

![](Fig3.JPG)

No issues here.

``` r
# Extracting only Final District District Results of 
# No of valid votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="No of valid votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##             ColNames      V1
    ## 1: No of valid votes 7561526

``` r
# Extracting except Final District District Results of 
# No of valid votes
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="No of valid votes")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##             ColNames      V1
    ## 1: No of valid votes 7561526

## Comparing final tally votes of Mrs. Chandrika Bandaranaike Kumarathunga

No issues here.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
# Mrs. Chandrika Bandaranaike Kumarathunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mrs. Chandrika Bandaranaike Kumarathunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                                    ColNames      V1
    ## 1: Mrs. Chandrika Bandaranaike Kumarathunga 4709205

``` r
# Extracting except Final District District Results of 
# Mrs. Chandrika Bandaranaike Kumarathunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mrs. Chandrika Bandaranaike Kumarathunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                                    ColNames      V1
    ## 1: Mrs. Chandrika Bandaranaike Kumarathunga 4709205

## Comparing final tally votes of Mrs. Vajira Srimathi Disaanayake

No issues here. It should be 2715283 but mistakenly printed as 2715285.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
# Mrs. Vajira Srimathi Dissanayake
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mrs. Vajira Srimathi Dissanayake")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                            ColNames      V1
    ## 1: Mrs. Vajira Srimathi Dissanayake 2715283

``` r
# Extracting except Final District District Results of 
# Mrs. Vajira Srimathi Dissanayake
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mrs. Vajira Srimathi Dissanayake")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                            ColNames      V1
    ## 1: Mrs. Vajira Srimathi Dissanayake 2715283

## Comparing final tally votes of Mr.Galappaththi Arachchige

No issues here.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
# Mr.Galappaththi Arachchige
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. Galappaththi Arachchige Nihal")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                             ColNames    V1
    ## 1: Mr. Galappaththi Arachchige Nihal 22749

``` r
# Extracting except Final District District Results of 
# Mr.Galappaththi Arachchige
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. Galappaththi Arachchige Nihal")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                             ColNames    V1
    ## 1: Mr. Galappaththi Arachchige Nihal 22749

## Comparing final tally votes of Mr. A.J. Ranashinge

No issues here.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
#  Mr. A.J. Ranashinge
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. A.J. Ranashinge")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##               ColNames    V1
    ## 1: Mr. A.J. Ranashinge 22752

``` r
# Extracting except Final District District Results of 
#  Mr. A.J. Ranashinge
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. A.J. Ranashinge")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##               ColNames    V1
    ## 1: Mr. A.J. Ranashinge 22752

## Comparing final tally votes of Dr. Harischandra Wijayatunga

No issues here.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
#  Mr. A.J. Ranashinge
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Dr. Harischandra Wijayatunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                        ColNames    V1
    ## 1: Dr. Harischandra Wijayatunga 32651

``` r
# Extracting except Final District District Results of 
#   Dr. Harischandra Wijayatunga
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Dr. Harischandra Wijayatunga")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                        ColNames    V1
    ## 1: Dr. Harischandra Wijayatunga 32651

## Comparing final tally votes of Mr. Hudson Samarasinghe

According to Electorates tally it should be 58888, but mistakenly
calculated as 58886. This occurs because of the Batticaloa District
Tally.

![](Fig4.JPG)

``` r
# Extracting only Final District District Results of 
# Mr. Hudson Samarasinghe 
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate=="Final District Results" 
                      & ColNames=="Mr. Hudson Samarasinghe")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                   ColNames    V1
    ## 1: Mr. Hudson Samarasinghe 58886

``` r
# Extracting except Final District District Results of 
# Mr. Hudson Samarasinghe 
# and then adding all the votes 
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results" 
                      & ColNames=="Mr. Hudson Samarasinghe")
# added votes will be cross checked with the pdf document
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                   ColNames    V1
    ## 1: Mr. Hudson Samarasinghe 58888

The real tally for Batticaloa district is 5030 but mis calculated as
5028. So the Final Count for Mr. Hudson Samarasinghe is 58888.

![](Fig41.JPG)

### Batticaloa district

``` r
ElecFinal1994<-subset(Election1994,Electorate!="Final District Results"
                      & District=="Batticaloa"
                      & ColNames=="Mr. Hudson Samarasinghe")
ElecFinal1994[,sum(Votes,na.rm = TRUE),by="ColNames"]
```

    ##                   ColNames   V1
    ## 1: Mr. Hudson Samarasinghe 5030

*THANK YOU*
