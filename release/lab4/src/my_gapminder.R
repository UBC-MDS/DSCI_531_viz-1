## Script to write gapminder data of four countries to file.
library(gapminder)
library(tidyverse)
countries <- VECTOR_OF_COUNTRIES
gapminder %>% 
    filter(country %in% countries) %>% 
    write_csv("data/my_gapminder.csv")