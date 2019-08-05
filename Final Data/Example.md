Example
================

# General Votes

## No of Registered Electors and Total No of Polled Votes Over the Years

``` r
Final %>%
  subset(ColNames=="No of Registered Electors" & Electorate=="Final District Results" | 
         ColNames=="Total No of Votes Polled" & Electorate=="Final District Results") %>%
  group_by(Year,ColNames) %>%
  summarise(Votes=sum(Votes)/100000) %>%
ggplot(.,aes(Year,Votes,color=ColNames,label=Votes))+
       ylab("Votes (in 100,000)")+
       geom_point()+geom_line()+
       geom_text(vjust=-1,size=3)+
       scale_x_continuous(breaks = years)+
       theme(legend.position = "bottom")
```

![](Example_files/figure-gfm/Reg%20Electors%20and%20Polled%20Votes-1.png)<!-- -->

## No of Registered Electors and Total No of Polled Votes Over the years by district

``` r
Final %>%
   subset(ColNames=="No of Registered Electors" & Electorate=="Final District Results" | 
          ColNames=="Total No of Votes Polled" & Electorate=="Final District Results") %>%
ggplot(.,aes(District,Votes/10000,fill=ColNames))+
       ylab("Votes (in 10,000)")+
       geom_bar(stat = "identity",position = "dodge")+
       transition_states(factor(Year),state_length = 2)+ 
       theme(legend.position = "bottom",
             axis.text.x = element_text(angle=90,vjust=-0.1))+
       ggtitle("Year :{closest_state}")
```

![](Example_files/figure-gfm/Reg%20Electors%20and%20Polled%20Votes%20district-1.gif)<!-- -->

## No of Rejected Votes Over the Years

``` r
Final %>%
  subset(ColNames=="No of Rejected Votes" & Electorate=="Final District Results") %>%
  group_by(Year,ColNames) %>%
  summarise(Votes=sum(Votes)/100000) %>%
ggplot(.,aes(Year,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1)+
       ylab("Votes (in 100,000)")+
       scale_x_continuous(breaks = years)
```

![](Example_files/figure-gfm/Rejected%20Votes-1.png)<!-- -->

## No of Rejected Votes Over the Years by district

``` r
Final %>%
  subset(ColNames=="No of Rejected Votes" & Electorate=="Final District Results") %>%
ggplot(.,aes(District,Votes/10000,label=Votes/10000))+
       geom_col()+geom_text(vjust=1,size=2)+
       ylab("Votes (in 10,000)")+
       transition_states(factor(Year),state_length = 2)+ 
       theme(legend.position = "bottom",
             axis.text.x = element_text(angle=90,vjust=-0.1))+
       ggtitle("Year :{closest_state}")
```

![](Example_files/figure-gfm/Rejected%20Votes%20by%20district-1.gif)<!-- -->

# Postal Votes

## Postal Votes Polled Over the Years

``` r
Final %>%
  subset(ColNames=="Total No of Votes Polled" & Electorate=="Postal District Votes") %>%
  group_by(Year,ColNames) %>%
  summarise(Votes=sum(Votes)/100000) %>%
ggplot(.,aes(Year,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1)+
       ylab("Votes (in 100,000)")+
       scale_x_continuous(breaks = years)
```

![](Example_files/figure-gfm/Postal%20Votes%20Polled-1.png)<!-- -->

## Postal Votes Polled Over the Years by district

``` r
Final %>%
  subset(ColNames=="Total No of Votes Polled" & Electorate=="Postal District Votes") %>%
ggplot(.,aes(District,Votes/10000,label=Votes/10000))+
       geom_col()+geom_text(vjust=1,size=2)+
       ylab("Votes (in 10,000)")+
       transition_states(factor(Year),state_length = 2)+ 
       theme(legend.position = "bottom",
             axis.text.x = element_text(angle=90,vjust=-0.1))+
       ggtitle("Year :{closest_state}")
```

![](Example_files/figure-gfm/Postal%20Votes%20Polled%20by%20district-1.gif)<!-- -->

## Postal Votes Registered Over the Years

``` r
Final %>%
  subset(ColNames=="No of Registered Electors" & Electorate=="Postal District Votes") %>%
  group_by(Year,ColNames) %>%
  summarise(Votes=sum(Votes)/100000) %>%
ggplot(.,aes(Year,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1)+
       ylab("Votes (in 100,000)")+
       scale_x_continuous(breaks = years)
```

![](Example_files/figure-gfm/Postal%20Votes%20Registered-1.png)<!-- -->

## Postal Votes Registered Over the Years by district

``` r
Final %>%
  subset(ColNames=="No of Registered Electors" & Electorate=="Postal District Votes") %>%
ggplot(.,aes(District,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1,size=2)+
       ylab("Votes")+
       transition_states(factor(Year),state_length = 2)+ 
       theme(legend.position = "bottom",
             axis.text.x = element_text(angle=90,vjust=-0.1))+
       ggtitle("Year :{closest_state}")
```

![](Example_files/figure-gfm/Postal%20Votes%20Registered%20by%20district-1.gif)<!-- -->

## Postal Votes Rejected Over the Years

``` r
Final %>%
  subset(ColNames=="No of Rejected Votes" & Electorate=="Postal District Votes") %>%
  group_by(Year,ColNames) %>%
  summarise(Votes=sum(Votes)/1000) %>%
ggplot(.,aes(Year,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1)+
       ylab("Votes (in 1000)")+
       scale_x_continuous(breaks = years)
```

![](Example_files/figure-gfm/Postal%20Votes%20Rejected-1.png)<!-- -->

## Postal Votes Rejected Over the Years by district

``` r
Final %>%
  subset(ColNames=="No of Rejected Votes" & Electorate=="Postal District Votes") %>%
ggplot(.,aes(District,Votes,label=Votes))+
       geom_col()+geom_text(vjust=1)+
       ylab("Votes")+
       transition_states(factor(Year),state_length = 2)+ 
       theme(legend.position = "bottom",
             axis.text.x = element_text(angle=90,vjust=-0.1))+
       ggtitle("Year :{closest_state}")
```

![](Example_files/figure-gfm/Postal%20Votes%20Rejected%20by%20district-1.gif)<!-- -->

*THANK YOU*
