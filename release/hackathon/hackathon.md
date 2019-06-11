DSCI 531: Hackathon
================

Due Tuesday, Nov 6 at 18:00 (although you should be able to finish in lecture)

``` r
suppressPackageStartupMessages(library(tidyverse))
```

Objective
=========

In this course, we've looked at four layers of data vis:

1.  Drawing conclusions from visualizations
    -   Guiding question: what can we see in this graph that we can't see by looking at a table of the raw data?
2.  Using tools to create a graph
    -   `ggplot2` and other niche R packages; also `matplotlib`, `pandas`, and `seaborn` in Python.
3.  Components of a graph: the grammar of graphics, and theme elements.
4.  Effective graph choice

In this "half lab" assignment, you create a graph in a team of 2-3 that touches on all of these components, by choosing one of five analysis scenarios. Your submission will include the following parts:

1.  A graph.
2.  A figure caption.
3.  A description of your design choice.

The following section outlines the evaluation of this assignment. The scenarios follow.

Evaluation
==========

Tidy Submission (worth 5%)
--------------------------

rubric={mechanics:5}

To get the marks for tidy submission:

-   **INDICATE WHO YOUR HACKATHON TEAM MEMBERS ARE**! (Both names and github.ubc.ca usernames)
-   This document only contains instructions. Where you put your work is up to you, but it's important for you to make it obvious where your work can be found!
-   Use either jupyter notebook or R Markdown.
-   Use either R or Python.
-   Be sure to follow the [general lab instructions](https://ubc-mds.github.io/resources_pages/general_lab_instructions/).
-   Do not include any code that installs packages (this is not good practice anyway).

Writing (worth 5%)
------------------

rubric={writing:5}

To get these marks, you must use proper English, spelling, and grammar in your submission.

Publication Quality (worth 10%)
-------------------------------

rubric={vis:10}

To get these marks, your graph must be publication quality.

Design choice (worth 35%)
-------------------------

rubric={reasoning:40}

To get these marks, briefly describe the decisions you made in designing this graph to be effective. Don't write a lot. Only focus on the big picture things here. Point form is fine.

Code accuracy and quality (worth 30%)
-------------------------------------

rubric={accuracy:15, quality:15}

To get these marks, your code must work (`accuracy` rubric) and must be high quality (`quality` rubric: readable and reasonably efficient).

Figure caption (worth 15%)
--------------------------

To get these marks, you should accompany your graph with a figure caption that:

1.  Orients the reader to the graph (like a graph title would).
    -   Example: "Relationship between GDP per capita and life expectancy"
2.  Fills readers in with critical information that the graph could not convey. This might not be applicable, but it probably will be.
    -   Example: "taken every 5 years between 1952 and 2007"
3.  Draws a conclusion from the graph.
    -   Example: "countries with higher GDP per capita tend to have a higher life expectancy."

Scenarios
=========

Scenario A
----------

Every day, you run a model that predicts tomorrow's river discharge of the Bow River at Banff. On some days, the model produces an invalid forecast (this makes sense in the context of probabilistic forecasts, something you'll learn in DSCI 562). You suspect that invalid forecasts (called `error` in the data) are more likely to happen when the actual discharge that materializes the next day (called `outcome` in the data) is larger. Your task is to produce a visual to explore this, while still giving the viewer a sense of the overall chance of an invalid forecast.

``` r
(sA <- read_csv("data/sA-error_prop.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   outcome = col_double(),
    ##   error = col_logical()
    ## )

    ## # A tibble: 546 x 2
    ##    outcome error
    ##      <dbl> <lgl>
    ##  1    9.96 FALSE
    ##  2    9.98 FALSE
    ##  3   10.3  FALSE
    ##  4   10.3  FALSE
    ##  5   10.3  FALSE
    ##  6   10.4  FALSE
    ##  7   10.5  FALSE
    ##  8   10.5  FALSE
    ##  9   10.6  FALSE
    ## 10   10.6  FALSE
    ## # ... with 536 more rows

Scenario B
----------

Suppose you have snowmelt (in millimeters) and river discharge (in m^3/s) data that are recorded daily, although some days have missing data. You'd like to show your audience *when* you have data on record, for both variables.

The data are given in two forms for your data wrangling convenience:

-   In `sBa`, each row corresponds to an available observation of data type `Type` on date `date`.
-   In `sBb`, each row corresponds to an (inclusive) range of dates where data are available.

``` r
(sBa <- read_csv("data/sB-time_intervals-pointwise.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   date = col_date(format = ""),
    ##   Type = col_character()
    ## )

    ## # A tibble: 23,070 x 2
    ##    date       Type     
    ##    <date>     <chr>    
    ##  1 1980-01-01 Discharge
    ##  2 1980-01-02 Discharge
    ##  3 1980-01-03 Discharge
    ##  4 1980-01-04 Discharge
    ##  5 1980-01-05 Discharge
    ##  6 1980-01-06 Discharge
    ##  7 1980-01-07 Discharge
    ##  8 1980-01-08 Discharge
    ##  9 1980-01-09 Discharge
    ## 10 1980-01-10 Discharge
    ## # ... with 23,060 more rows

``` r
(sBb <- read_csv("data/sB-time_intervals-range.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   beginning = col_date(format = ""),
    ##   ending = col_date(format = ""),
    ##   Type = col_character()
    ## )

    ## # A tibble: 89 x 3
    ##    beginning  ending     Type     
    ##    <date>     <date>     <chr>    
    ##  1 1980-01-01 2014-12-31 Discharge
    ##  2 1984-01-05 1984-02-15 Snowmelt 
    ##  3 1984-02-28 1984-03-19 Snowmelt 
    ##  4 1984-03-22 1984-06-15 Snowmelt 
    ##  5 1984-06-17 1984-09-30 Snowmelt 
    ##  6 1984-10-03 1984-10-10 Snowmelt 
    ##  7 1984-10-13 1984-11-02 Snowmelt 
    ##  8 1984-11-06 1984-11-21 Snowmelt 
    ##  9 1984-11-24 1984-11-29 Snowmelt 
    ## 10 1985-01-03 1985-01-31 Snowmelt 
    ## # ... with 79 more rows

Scenario C
----------

Suppose you're writing a report to justify a prediction model you've built, which predicts river discharge (in m^3/s) using snowmelt (in millimeters). Part of your investigation involves trying out different (increasing) weight functions on snowmelt (you'll learn more about weight functions later in the program, but their meaning is not important here). You want to convince your readers that your choice of weight functions do a fairly good job spanning the choices of sensible weight functions.

In other words, the weight functions should increase from 0 to 1 at different rates and at different positions, and this increase should happen in the range of sensible snowmelt values (snowmelt data are recorded in `sC-weight_justif.csv`).

You've chosen nine weight functions. They're stored in the list `wfun` below. (If you're interested, they are logistic functions with all combinations of three choices of the location parameter `x0`, and three choices of the rate parameter `r`. This information does not help you jusify your prediction model in this imaginary report.)

``` r
(sC <- read_csv("data/sC-weight_justif.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   snowmelt = col_double()
    ## )

    ## # A tibble: 658 x 1
    ##    snowmelt
    ##       <dbl>
    ##  1    3.01 
    ##  2   11.3  
    ##  3   13.4  
    ##  4   11.4  
    ##  5    1.72 
    ##  6    5.36 
    ##  7    4.21 
    ##  8    0.223
    ##  9    0.719
    ## 10    4.86 
    ## # ... with 648 more rows

``` r
## Define weight functions
logistic <- function(x0, r) function(x) 1 / (1 + exp(-r*(x-x0)))
wfun <- crossing(
    x0 = c(0.0, 7.5, 15.0),
    r  = c(0.05, 0.20, 0.70)
) %>% 
    mutate(f = map2(x0, r, logistic)) %>% 
    `[[`("f")
```

Scenario D
----------

You have daily snowmelt data (in millimeters) at a particular location near Canmore, Alberta. You notice that the distribution of snowmelt on a given day changes across the year, so you've estimated the distribution for every day of the year.

Someone's given you many years worth of new data. Make a graph to show whether the new data "agrees" with your distribution estimates -- that is, whether or not the data could have plausibly been drawn from the distributions you estimated. It would also be useful to show that your distribution estimates match up with the original data, too.

About the data:

-   `sD-dist_melt.csv` has the snowmelt data, new and original.
-   `sD-dist_melt.Rdata` (too large to gift: find in students repo, or click [here](https://github.ubc.ca/MDS-2018-19/DSCI_531_viz-1_students/raw/master/release/hackathon/data/sD-dist_melt.Rdata)) loads a list with variable name `dist_melt` containing the distributions. Density estimates are not available, but the cdf and quantile functions are, and are stored as list elements 1 and 2, respectively.
    -   cdf arguments:
        -   `x`: vectorized. The variable of the distribution.
        -   `d`: day of the year; integer acceptable from 1 to 366.
    -   quantile function arguments:
        -   `p`: vectorized. Probabilities to find quantiles of.
        -   `d`: day of the year; integer acceptable from 1 to 366.

``` r
(sF <- read_csv("data/sD-dist_melt.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   data = col_character(),
    ##   date = col_date(format = ""),
    ##   snowmelt = col_double()
    ## )

    ## # A tibble: 3,185 x 3
    ##    data     date       snowmelt
    ##    <chr>    <date>        <dbl>
    ##  1 original 1980-04-19   NA    
    ##  2 original 1982-04-20   NA    
    ##  3 original 1983-04-20   NA    
    ##  4 original 1984-04-19   -2.33 
    ##  5 original 1986-04-20   -0.984
    ##  6 original 1987-04-20   -3.45 
    ##  7 original 1988-04-19   -0.772
    ##  8 original 1990-04-20   12.3  
    ##  9 original 1991-04-20    2.53 
    ## 10 original 1993-04-20   -2.15 
    ## # ... with 3,175 more rows

``` r
load("data/sD-dist_melt.Rdata")
str(dist_melt)
```

    ## List of 2
    ##  $ cdf:function (x, d)  
    ##   ..- attr(*, "srcref")= 'srcref' int [1:8] 27 16 43 9 16 9 27 43
    ##   .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x7ffce8b852b8> 
    ##  $ qf :function (p, d)  
    ##   ..- attr(*, "srcref")= 'srcref' int [1:8] 52 11 60 5 11 5 52 60
    ##   .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x7ffce8b852b8>
