Final Data-Frame
================

# Importing the individual CSV files

7 data frames which were extracted from 7 pdf files are now imported
here, so that one complete data-frame of Presidential election data can
be produced.

Further it is possible give suggestions on how the next presidential
election data can be stored, processed and released in a more useful way
than previous situations.

``` r
# import the data frames
Election1982<-read.csv("Election1982.csv")
Election1988<-read.csv("Election1988.csv")
Election1994<-read.csv("Election1994.csv")
Election1999<-read.csv("Election1999.csv")
Election2005<-read.csv("Election2005.csv")
Election2010<-read.csv("Election2010.csv")
Election2015<-read.csv("Election2015.csv")
```

# Producing one final CSV file

Using rbind function we can produce one final complete data frame which
will include all the results for 7 presidential elections in Sri Lanka
from 1982 to 2015.

``` r
# combine the 7 data frames
Final<-rbind.data.frame(Election1982,Election1988,Election1994,
                        Election1999,Election2005,Election2010,
                        Election2015)
# export the data-frame
write.csv(Final,"Final.csv",row.names = FALSE)
```

# Summary Statistics for Final Data

With the help of summarytools package we can find the descriptive
statistics for the final data.

``` r
# Complete summary
summarytools::dfSummary(Final)
```

    ## Data Frame Summary  
    ## Final  
    ## Dimensions: 22530 x 6  
    ## Duplicates: 0  
    ## 
    ## -----------------------------------------------------------------------------------------------------------------------------------
    ## No   Variable      Stats / Values                   Freqs (% of Valid)     Graph                               Valid      Missing  
    ## ---- ------------- -------------------------------- ---------------------- ----------------------------------- ---------- ---------
    ## 1    Year          Mean (sd) : 2003.3 (10.3)        1982 : 2018 ( 9.0%)    I                                   22530      0        
    ##      [integer]     min < med < max:                 1988 : 1406 ( 6.2%)    I                                   (100%)     (0%)     
    ##                    1982 < 2005 < 2015               1994 : 2040 ( 9.0%)    I                                                       
    ##                    IQR (CV) : 11 (0)                1999 : 3446 (15.3%)    III                                                     
    ##                                                     2005 : 3494 (15.5%)    III                                                     
    ##                                                     2010 : 5434 (24.1%)    IIII                                                    
    ##                                                     2015 : 4692 (20.8%)    IIII                                                    
    ## 
    ## 2    District      1. Anuradhapura                    986 ( 4.4%)                                              22530      0        
    ##      [factor]      2. Badulla                        1206 ( 5.4%)          I                                   (100%)     (0%)     
    ##                    3. Batticaloa                      538 ( 2.4%)                                                                  
    ##                    4. Colombo                        1866 ( 8.3%)          I                                                       
    ##                    5. Digamadulla                     682 ( 3.0%)                                                                  
    ##                    6. Galle                          1316 ( 5.8%)          I                                                       
    ##                    7. Gampaha                        1646 ( 7.3%)          I                                                       
    ##                    8. Hambantota                      656 ( 2.9%)                                                                  
    ##                    9. Jaffna                         1468 ( 6.5%)          I                                                       
    ##                    10. Kalutara                      1096 ( 4.9%)                                                                  
    ##                    [ 13 others ]                    11070 (49.1%)          IIIIIIIII                                               
    ## 
    ## 3    Electorate    1. Agalawatta                      110 ( 0.5%)                                              22530      0        
    ##      [factor]      2. Akmeemana                       110 ( 0.5%)                                              (100%)     (0%)     
    ##                    3. Akuressa                        110 ( 0.5%)                                                                  
    ##                    4. Ambalangoda                     110 ( 0.5%)                                                                  
    ##                    5. Ampara                          110 ( 0.5%)                                                                  
    ##                    6. Anamaduwa                       110 ( 0.5%)                                                                  
    ##                    7. Anuradhapura-East               110 ( 0.5%)                                                                  
    ##                    8. Anuradhapura-West               110 ( 0.5%)                                                                  
    ##                    9. Aranayake                       110 ( 0.5%)                                                                  
    ##                    10. Attanagalla                    110 ( 0.5%)                                                                  
    ##                    [ 153 others ]                   21430 (95.1%)          IIIIIIIIIIIIIIIIIII                                     
    ## 
    ## 4    ColNames      1. Dr. Colvin R. De Silva          204 ( 0.9%)                                              22530      0        
    ##      [factor]      2. Mr. Rohana Wijeweera            204 ( 0.9%)                                              (100%)     (0%)     
    ##                    3. Mr. Vasudeva Nanayakkara        204 ( 0.9%)                                                                  
    ##                    4. Mr.G.G. Ponnambalam             204 ( 0.9%)                                                                  
    ##                    5. Mr.H.S.R.B.K. Kobbekaduwa       204 ( 0.9%)                                                                  
    ##                    6. Mr.J.R. Jayawardene             204 ( 0.9%)                                                                  
    ##                    7. No of Registered Electors      1345 ( 6.0%)          I                                                       
    ##                    8. No of Rejected Votes           1436 ( 6.4%)          I                                                       
    ##                    9. Total No of Valid Votes        1436 ( 6.4%)          I                                                       
    ##                    10. Total No of Votes Polled      1436 ( 6.4%)          I                                                       
    ##                    [ 67 others ]                    15653 (69.5%)          IIIIIIIIIIIII                                           
    ## 
    ## 5    Votes         Mean (sd) : 23490.9 (82699.3)    8410 distinct values   :                                   22530      0        
    ##      [integer]     min < med < max:                                        :                                   (100%)     (0%)     
    ##                    0 < 163 < 1637537                                       :                                                       
    ##                    IQR (CV) : 17996.8 (3.5)                                :                                                       
    ##                                                                            :                                                       
    ## 
    ## 6    Percentage    Mean (sd) : 18.1 (31.8)          3820 distinct values   :                                   21094      1436     
    ##      [numeric]     min < med < max:                                        :                                   (93.63%)   (6.37%)  
    ##                    0 < 0.2 < 100                                           :                                                       
    ##                    IQR (CV) : 32.5 (1.8)                                   :                                                       
    ##                                                                            :       .         .                                     
    ## -----------------------------------------------------------------------------------------------------------------------------------

``` r
# Numerical Summary
summarytools::descr(Final[-1])
```

    ## Descriptive Statistics  
    ## Final  
    ## N: 22530  
    ## 
    ##                     Percentage        Votes
    ## ----------------- ------------ ------------
    ##              Mean        18.10     23490.88
    ##           Std.Dev        31.83     82699.26
    ##               Min         0.00         0.00
    ##                Q1         0.05        33.00
    ##            Median         0.21       163.00
    ##                Q3        32.52     18038.00
    ##               Max       100.00   1637537.00
    ##               MAD         0.28       232.77
    ##               IQR        32.47     17996.75
    ##                CV         1.76         3.52
    ##          Skewness         1.52         8.65
    ##       SE.Skewness         0.02         0.02
    ##          Kurtosis         0.80        99.75
    ##           N.Valid     21094.00     22530.00
    ##         Pct.Valid        93.63       100.00

*THANK YOU*
