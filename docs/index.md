
--- 
title: "Bayesian Data Analysis in Ecology Using Linear Models with R, BUGS, and Stan"
author: "Fränzi Korner-Nievergelt, Tobias Roth, Stefanie von Felten, Jérôme Guéla, Bettina Almasi and Pius Korner-Nievergelt"
date: "2018-01-28"
site: bookdown::bookdown_site
documentclass: book
bibliography: [References.bib]
link-citations: yes
github-repo: TobiasRoth/BDAEcology
cover-image: images/cover.jpg
description: "Bayesian Data Analysis in Ecology Using Linear Models with R, BUGS, and STAN introduces Bayesian software, using R for the simple modes, and flexible Bayesian software (BUGS and Stan) for the more complicated ones. Guiding the ready from easy toward more complex (real) data analyses ina step-by-step manner, the book presents problems and solutions—including all R codes—that are most often applicable to other data and questions, making it an invaluable resource for analyzing a variety of data types."
---

# Preface {-}

<a href="https://www.elsevier.com/books/bayesian-data-analysis-in-ecology-using-linear-models-with-r-bugs-and-stan/korner-nievergelt/978-0-12-801370-0" target="_blank"><img src="images/cover.jpg" width="448" style="display: block; margin: auto;" /></a>



## Acknowledgments {-}
The basis of this book is a course script written for statistics classes at the International Max Planck Research School for Organismal Biology (IMPRS)dsee www.orn.mpg.de/2453/Short_portrait. We, therefore, sincerely thank all the IMPRS students who have used the script and worked with us. The text grew as a result of questions and problems that appeared during the application of linear models to the various Ph.D. projects of the IMPRS stu- dents. Their enthusiasm in analyzing data and discussion of their problems motivated us to write this book, with the hope that it will be of help to future students. We especially thank Daniel Piechowski and Margrit Hieber-Ruiz for hiring us to give the courses at the IMPRS.

The main part of the book was written by FK and PK during time spent at the Colorado Cooperative Fish and Wildlife Research Unit and the Department of Fish, Wildlife, and Conservation Biology at Colorado State University in the spring of 2014. Here, we were kindly hosted and experienced a motivating time. William Kendall made this possible, for which we are very grateful. Gabriele Engeler and Joyce Pratt managed the administrational challenges of tenure there and made us feel at home. Allison Level kindly introduced us to the CSU library system, which we used extensively while writing this book. We enjoyed a very inspiring environment and cordially thank all the Fish, Wildlife, and Conservation Biology staff and students who we met during our stay.
The companies and institutions at which the authors were employed during the work on the book always positively supported the project, even when it produced delays in other projects. We are grateful to all our colleagues at the Swiss Ornithological Institute (www.vogelwarte.ch), oikostat GmbH (www.oikostat.ch), Hintermann & Weber AG (www.hintermannweber.ch), the University of Basel, and the Clinical Trial Unit at the University of Basel (www.scto.ch/en/CTU-Network/CTU-Basel.html).

We are very grateful to the R Development Core Team (http://www. r-project.org/contributors.html) for providing and maintaining this wonderful software and network tool. We appreciate the flexibility and understandability of the language R and the possibilitiy to easily exchange code. Similarly, we would like to thank the developers of BUGS (http://www.openbugs.net/w/ BugsDev) and Stan (http://mc-stan.org/team.html) for making all their extremely useful software freely available. Coding BUGS or Stan has helped us in many cases to think more clearly about the biological processes that have generated our data.

Example data were kindly provided by the Ulmet-Kommission (www.bnv. ch), the Landschaft und Gewa ̈sser of Kanton Aargau, the Swiss Ornithological Institute (www.vogelwarte.ch), Valentin Amrhein, Anja Bock, Christoph Bu ̈hler, Karl-Heinz Clever, Thomas Gottschalk, Martin Gru ̈ebler, Gu ̈nther Herbert, Thomas Hoffmeister, Rainer Holler, Beat Naef-Daenzer, Werner Peter, Luc Schifferli, Udo Seum, Maris Strazds, and Jean-Luc Zollinger.

For comments on the manuscript we thank Martin Bulla, Kim Meichtry- Stier and Marco Perrig. We also thank Roey Angel, Karin Boos, Paul Conn, and two anonymous reviewers for many valuable suggestions regarding the book’s structure and details in the text. Holger Schielzeth gave valuable comments and input for Chapter 10, and David Anderson and Michael Schaub commented on Chapter 11. Bob Carpenter figured out essential parts of the Stan code for the CormackeJollyeSeber model. Michael Betancourt and Bob Carpenter commented on the introduction to MCMC and the Stan examples. Valentin Amrhein and Barbara Helm provided input for Chapter 17. All these people greatly improved the quality of the book, made the text more accessible, and helped reduce the error rate.

Finally, we are extremely thankful for the tremendous work that Kate Huyvaert did proofreading our English.
