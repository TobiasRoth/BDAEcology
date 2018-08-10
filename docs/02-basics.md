
# Introduction to statistical thinking and working with R {#basics}

## Notations
It is unavoidable that different authors use different notations for the same thing, or that the same notation is used for different things. We try to use, whenever possible, notations that is commonly used at the [International Statistical Ecology Congress ISEC](https://http://www.isec2018.org/home). Resulting from an earlier ISEC, @Thomson.2009d give guidelines on what letter should be used for which parameter in order to achieve a standard notation at least among people working with classical mark-recapture models. However, the alphabet has fewer letters compared to the number of ecological parameters. Therefore, the same letter cannot stand for the same parameter across all papers, books and chapters. Here, we try to use the same letter for the same parameter within the same chapter. 

> hier kommt eine Bemerkung

## Data handling
Alle Packete laden `library(tidyverse)` oder nur `library(tidyverse)`.



```r
dat <- iris %>% 
  as.tibble() %>% 
  filter(Sepal.Length > 5) %>% 
  group_by(Species) %>% 
  summarise(n = n(),
            mittel = mean(Petal.Length))
```

