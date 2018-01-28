#  This script will be run at the start of each chapter

rm(list = ls())

# Libraries
library(knitr)
library(tidyverse)
library(RColorBrewer)

# Knitr settings 
options(scipen = 6);
opts_chunk$set(echo = TRUE, hide = TRUE, cache = TRUE, warning = FALSE, message = FALSE,
               fig.asp = .45, fig.width = 8)

# Darstellung von R-Berechnungen innerhalb von Text
inline_hook <- function(x) {
  if (is.numeric(x)) {
    x <- format(x, nsmall = 2, digits = 2)
  }
  x
}
knit_hooks$set(inline = inline_hook)

# Gestaltung der plots in ggplot
theme_set(theme_classic())

# Hilfsfunktion um mehrere ggplots pro Panel zu machen
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots == 1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
