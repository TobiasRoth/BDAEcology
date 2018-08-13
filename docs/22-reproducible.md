
# Reproducible Research {#reproducible}

## Introduction

## Add citations
Mit dem Packet `knitcitations` können Referenzen relativ einfach gesucht und in das `.bib` File eingefügt werden. Erst muss das Packet geladen und der lokale Speicher gelöscht werden. Das Format pandoc scheint auch nötig zu sein.


```r
library(knitcitations)
cleanbib()
cite_options(citation_format = "pandoc")
```

Danach kann man einfach nach einer Referenz mit Stichworten, Autoren oder DOI-Nummer. Zum Beispiel sucht der Befehl `citep("Roth, Plattner Amrhein")` die entsprechende Referenz und fügt diese ein [@Roth_2014]. Der folgende Befehl schreibt alle Referenzen aus der Zwischenablage in das `.bib` File.


```r
write.bibtex(file="References.bib", append = TRUE)
```

Am einfachsten folgende Hilfsfunktion benutzen um aus der Konsole eine Referenz ins `.bib` File zu schreiben.


```r
ref <- function(x) {
  library(knitcitations)
  cleanbib()
  print(citep(x))
  write.bibtex(file="References.bib", append = TRUE)
}
```

## Further reading

- [Rmarkdown](https://bookdown.org/yihui/rmarkdown/): The first official book authored by the core R Markdown developers that provides a comprehensive and accurate reference to the R Markdown ecosystem. With R Markdown, you can easily create reproducible data analysis reports, presentations, dashboards, interactive applications, books, dissertations, websites, and journal articles, while enjoying the simplicity of Markdown and the great power of R and other languages. 

- [Bookdown by Yihui Xie](https://bookdown.org/yihui/bookdown/): A guide to authoring books with R Markdown, including how to generate figures and tables, and insert cross-references, citations, HTML widgets, and Shiny apps in R Markdown. The book can be exported to HTML, PDF, and e-books (e.g. EPUB). The book style is customizable. You can easily write and preview the book in RStudio IDE or other editors, and host the book wherever you want (e.g. bookdown.org). Our book is written using bookdown. 
