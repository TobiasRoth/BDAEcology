
# Data preparation {#datamanip}

## Basic operations
Alle Packete laden `library(tidyverse)` oder nur `library(tidyverse)`.



```r
dat <- iris %>% 
  as.tibble() %>% 
  filter(Sepal.Length > 5) %>% 
  group_by(Species) %>% 
  summarise(n = n(),
            mittel = mean(Petal.Length))
```


## Conection to existing sql-DB
Die in diesem Kapitel präsentierten Datenabfragen nutzen das R-Packet `dplyr`. Damit der R-Code funktioniert muss eine Kopie der SQLite Datenbank lokal verfügbar sein (DropBox-Zugang von Ro beziehen). Als Grundlage muss also erst das R-Packet geladen werden und den Link zu den Datebbanken hergestellt werden.


```r
# Connection to data base
db <- src_sqlite(path = "~/Documents/Dropbox/DB_BDM.db", create = FALSE)
rd <- src_sqlite(path = "~/Documents/Dropbox/DB_CHRD.db", create = FALSE)
```

### Abfragen zur Artenvielfalt 
Im Folgenden soll die mittlere Artenvielfalt für Z9 Plfanzen im LANAG für die Periode 2013 bis 2017 im Wald berechnet werden.


```r
# Auswahl der gültigen Aufnahmen in der entprechenden Periode
ausw <- inner_join(
  tbl(db, "STICHPROBE_Z9") %>% 
    filter(LANAG_aktuell == "ja") %>% 
    dplyr::select(aID_STAO),
  tbl(db, "KD_Z9") %>% 
    filter(yearP >= 2013 & yearP <= 2017 & !is.na(yearPl) & HN == "Wald") %>% 
    dplyr::select(aID_KD, aID_STAO)
)
  
# Artenvielfalt für jede Aufnahme anhängen
dat <- left_join(
  ausw,
  tbl(db, "PL") %>% filter(Z7 == 0) %>% group_by(aID_KD) %>% summarise(AZ = n()) 
) %>% data.frame

# AZ von gültigen Aufnahmen ohne Arten auf 0 setzen
dat <- replace_na(dat, list(AZ = 0))

# Mittelwert berechnen
mean(dat$AZ)
```

Der folgende Code plottet die mittlere Artenvielfalt der BDM Z7 Pflanzen (ohne Verdichtung) gegen die Meereshöhe.


```r
ausw <- inner_join(
  tbl(db, "STICHPROBE_Z7") %>% 
    filter(BDM_aktuell == "ja" & BDM_Verdichtung == "nein") %>% 
    dplyr::select(aID_STAO),
  tbl(db, "KD_Z7") %>% 
    filter(yearP >= 2013 & yearP <= 2017 & !is.na(yearPl) & 
             Aufnahmetyp == "Normalaufnahme_Z7") %>% 
    dplyr::select(aID_KD, aID_STAO)
)
  
# Artenvielfalt für jede Aufnahme berechnen
dat <- left_join(
  ausw,
  tbl(db, "PL") %>% filter(Z7 == 1) %>% group_by(aID_KD) %>% summarise(AZ = n()) 
) 

# Meereshöhe anhängen
dat <- left_join(dat, tbl(db, "RAUMDATEN_Z7") %>% select(aID_STAO, Hoehe))
dat <- replace_na(dat %>% data.frame, list(AZ = 0))


# Plot results
ggplot(dat, aes(x = Hoehe, y = AZ)) +
    geom_point(shape = 16) +
    geom_smooth() 
```

## Further reading
- [R for Data Science by Garrett Grolemund and Hadley Wickham](http://r4ds.had.co.nz): Introduces the tidyverse framwork. It explains how to get data into R, get it into the most useful structure, transform it, visualise it and model it.



