#  This script will be run at the start of each chapter

rm(list = ls())

# Libraries
library(knitr)
library(blmeco)
library(tidyverse)
library(Rmisc)

# Knitr settings 
options(scipen = 6);
opts_chunk$set(echo = TRUE, hide = TRUE, cache = FALSE, warning = FALSE, message = FALSE,
               fig.asp = .45, fig.width = 8)

# Darstellung von R-Berechnungen innerhalb von Text
inline_hook <- function(x) {
  if (is.numeric(x)) {
    x <- format(x, nsmall = 2, digits = 2)
  }
  x
}
knit_hooks$set(inline = inline_hook)
