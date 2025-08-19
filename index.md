--- 
title: "Bayesian Data Analysis in Ecology with R and Stan"
author: "Fränzi Korner-Nievergelt, Tobias Roth, Stefanie von Felten, Jerôme Guélat, Bettina Almasi, Louis Hunninck, Pius Korner-Nievergelt"
date: "2025-08-19"
site: bookdown::bookdown_site
documentclass: book
bibliography: [references/References_fk.bib, references/References_new.bib, references/References_svf.bib]
link-citations: yes
github-repo: TobiasRoth/BDAEcology
cover-image: images/cover.jpg
description: "This GitHub-book is collection of updates and additional material to the book Bayesian Data Analysis in Ecology Using Linear Models with R, BUGS, and STAN."
---

# Preface {-}

<img src="images/cover.jpg" width="655" style="display: block; margin: auto;" />

## Why this book? {-}
In 2015, we wrote a statistics book on Master/PhD-level Bayesian data analyses in ecology [@KornerNievergelt.2015] based on scripts we used for our statistics courses. You can order it [here](https://www.elsevier.com/books/bayesian-data-analysis-in-ecology-using-linear-models-with-r-bugs-and-stan/korner-nievergelt/978-0-12-801370-0). People seemed to like it [e.g. @Harju.2016]. Since then, two parallel processes happen. First, we learned more and we became more confident in what we do and what we don't do, and why we do what we do. Second, clever people continuously develop software that broaden the spectrum of ecological models that can be applied by ecologists working with R. Therefore, with this e-book, we substantially revised the text of the printed book, and we add new material.

## About this book {-}
As a prerequisite, you should be familiar with the basics of R, such as loading a package and reading in data, you should know how to apply a R function and that you can access a help file for each of them using "?<name of function>", e.g. `?c` for the help file of the function `c()`. If you are a complete novice, you find tutorials online. You should know that code is generally written into a script that is saved, and that code is executed in the console. We use [RStudio](https://posit.co/download/rstudio-desktop/) as an editor to work on our scripts and to execute code. Once you have this very basic familiarity with R, we try to take you from there into the world of linear modelling!

We understand this e-book as a dynamic project. Based on contributions from readers and based on further developments in R and its packages, we plan to continuously update the text. On the other hand, at any point in time, the published e-book should be coherent and contain all the essential steps needed to perform the analyses covered, such that it can be used for self-study or as a course script.

While we show the R-code behind most of the analyses, we sometimes choose not to show all the code in the html version of the book, e.g. for illustrations. But you can always consult the [public GitHub repository](https://github.com/TobiasRoth/BDAEcology) with the R Markdown files that were used to generate the book.

## How to contribute {-}
This e-book is open and free. Also, everybody with a [GitHub](https://github.com) account can make comments and suggestions for improvement. Readers can contribute in two ways. One way is to add an [issue](https://github.com/TobiasRoth/BDAEcology/issues). The second way is to contribute content directly through the edit button at the top of the page (i.e. a symbol showing a pencil in a square). That button is linked to the R Markdown source file of each page. You can correct typos or add new text and then submit a [GitHub pull request](https://help.github.com/articles/about-pull-requests/). We try to respond to you as quickly as possible. We are looking forward to your contribution!

## Acknowledgments {-}
We thank the amazing community of people behind the open source [R project](https://cran.r-project.org/). Among the packages we use most are arm [@Gelman.2022], rstanarm [@Goodrich.2023], rstan [mc-stan.org](https://mc-stan.org) and brms [@Burkner.2017]. We used the amazing [bookdown](https://bookdown.org/yihui/bookdown/) to write this book. 
We thank our students, collaborators, colleagues and contributors who introduced us to new techniques and software, reported updates and gave feedback on earlier versions of the book. Among many others, we thank Carole Niffenegger, Martin Küblbeck, Ruben Garcia, [... to be continued]



