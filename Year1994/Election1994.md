Election1994
================

# Structure of Document

# Process of Extraction

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
ElecFinal1994[,sum(Votes),by="ColNames"]
```

    ##                            ColNames V1
    ## 1: Mrs. Vajira Srimathi Dissanayake NA

*THANK YOU*
