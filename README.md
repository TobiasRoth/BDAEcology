# Bayesian Data Analysis in Ecology with R and Stan

This repository mainly contains the files to produce the online book  "Data Analysis in Ecology with R and Stan". 

## Content
1. **Top level of the repository**

   The top level of the repository mainly contains the files that are used by [bookdown](https://bookdown.org/yihui/bookdown/) to build the online book. These mainly include the `.yml` files for different settings of the book and the `.Rmd` files that contain the content of the book with one such file for each chapter of the book.

2. **admin-Folder**

   Contains administrative notes.

3. **docs-Folder**

   This folder contains all the files that are used to produced the page that ist published under https://tobiasroth.github.io/BDAEcology.  Note that if the book is locally built using  [bookdown](https://bookdown.org/yihui/bookdown/) the resulting files for the html version are saved in the folder `docs_local` .  Whenever we added new content that we are happy with, we manually copy the content of `docs_local` to `docs` and thus publish the new content. As a consequence,  https://tobiasroth.github.io/BDAEcology may correspond alder versions of the `.Rmd` files at the top level of the repository.

4. **images**

   Contains pictures that are used in the book. Note that this folder does not include the figures produced by the `.Rmd` files.

5. **RData-Folder**

   This folder contains some of the data that we use in the book. The data files are storred as `.RData` files that can be directly loaded into R using the funtion `load()`. By convention the name of the file is also the name of the R-object that will be loaded. E.g. using `load("RData/elevation.RData")` will load a tibble named elevation. Note, that most of the data-files that we use in the book are instead available from the R-package [`blmeco`](https://github.com/fraenzi/blmeco). 

6. **references-Folder**

   Contains the `.bib` files that contain the data-base of references that we partly used in the book. The file `References_fk.bib` is the export of the data-base maintained by Fränzi. This file should not be changed.  Additional references or references that you like to improve you should add to `References_new.bib`.

7. **settings-Folder**

8. **stanmodels-Folder**

   Contains the stan model description for all the models used in the book.


## How to contribute

In order to contribute you need to [join GitHub](https://github.com/join). 

You can contribute in several ways:

- To make a general comment or add a wish for new content you can add an [issue](https://github.com/TobiasRoth/BDAEcology/issues). 
- The second way is to contribute content directly through the edit button at the top of the page (i.e. a symbol showing a pencil in a square). That button is linked to the rmarkdown source file of each page. You can correct typos or add new text and then submit a [GitHub pull request](https://help.github.com/articles/about-pull-requests/). 

- You can download the entire repository to your local computer, improve the text or R code, run the code to test and as soon you are happy with the improvement submit the entire change as a pull request. 

We try to respond to you as quickly as possible. We are looking forward to your contribution!

## Contributors

Thank a lot to the [people that contributed to this book](https://github.com/TobiasRoth/BDAEcology/graphs/contributors). We also like to acknowledge the following people that used other means than GitHub to contribute to this book:

- Ruben Garcia

## Dependencies

- The main data files we use as examples in the book are contained in the R-Package `blmeco` available from cran or from https://github.com/fraenzi/blmeco. 