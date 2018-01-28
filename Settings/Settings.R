#  This script will be run at the start of each chapter

rm(list = ls())

# Libraries
library(knitr)
library(tidyverse)
library(leaflet)
library(RColorBrewer)

# Knitr settings 
options(scipen = 6);
opts_chunk$set(echo = FALSE, hide = TRUE, cache = TRUE, warning = FALSE, message = FALSE,
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


# Leaflet Einstellungen
attri <- '&copy; <a href="http://openstreetmap.se">OpenStreetMap Sweden</a>'
hintergrundkarte <- "Hydda.Base"
lminZoom <- 7
lmaxZoom <- 10
lcenter <- c(9.3, 46.8)
lradius <- 800
lopacity <- 0.6

# Taxanamen
andere <- c("Porifera", "Cnidaria", "Bryozoa", "Dendrocoelidae", "Dugesiidae", "Planariidae",
            "Nemathelminthes", "Erpobdellidae", "Glossiphoniidae", "Hirudidae (Tachet)", 
            "Piscicolidae", "Oligochaeta")
mollusca <- c("Acroloxidae", "Ancylidae", "Bithyniidae", "Ferrissiidae", "Hydrobiidae",
              "Lymnaeidae", "Neritidae", "Physidae", "Planorbidae", "Valvatidae", "Viviparidae",
              "Corbiculidae", "Dreissenidae", "Sphaeriidae", "Unionidae")
anderearthro <- c("Hydracarina", "Branchiopoda", "Corophiidae", "Gammaridae", "Niphargidae", "Asellidae",
                  "Janiridae", "Mysidae", "Astacidae", "Cambaridae")
ephemeroptera <- c("Ameletidae", "Baetidae", "Caenidae", "Ephemerellidae", "Ephemeridae", 
                   "Heptageniidae", "Leptophlebiidae", "Oligoneuriidae", "Polymitarcyidae", 
                   "Potamanthidae", "Siphlonuridae")
odonata <- c("Aeshnidae", "Calopterygidae", "Coenagrionidae", "Cordulegasteridae", "Corduliidae",
             "Gomphidae", "Lestidae", "Libellulidae", "Platycnemididae")
plecoptera <- c("Capniidae", "Chloroperlidae", "Leuctridae", "Nemouridae", "Perlidae", "Perlodidae",
                "Taeniopterygidae")
heteroptera <- c("Aphelocheiridae", "Corixidae", "Gerridae", "Hebridae", "Hydrometridae", "Mesoveliidae",
                 "Naucoridae", "Nepidae", "Notonectidae", "Pleidae", "Veliidae", "Sialidae", 
                 "Osmylidae", "Sisyridae")
coleoptera <- c("Curculionidae", "Chrysomelidae", "Dryopidae", "Dytiscidae", "Elmidae", "Gyrinidae",
                "Haliplidae", "Helophoridae", "Hydraenidae", "Hydrochidae", "Hydrophilidae", 
                "Hydroscaphidae", "Hygrobiidae", "Noteridae", "Psephenidae (=Eubriidae)", "Scirtidae (=Helodidae)", 
                "Spercheidae")
hym <-  "Hymenoptera"
trichoptera <- c("Apataniidae", "Beraeidae", "Brachycentridae", "Ecnomidae", "Glossosomatidae", "Goeridae",
                 "Helicopsychidae", "Hydropsychidae", "Hydroptilidae", "Lepidostomatidae", "Leptoceridae",
                 "Limnephilidae", "Molannidae", "Odontoceridae", "Philopotamidae", "Phryganeidae",
                 "Polycentropodidae", "Psychomyiidae", "Ptilocolepidae", "Rhyacophilidae", "Sericostomatidae")
lepi <- "Lepidoptera"
diptera <- c("Anthomyiidae", "Athericidae", "Blephariceridae", "Ceratopogonidae", "Chaoboridae",
             "Chironomidae", "Culicidae", "Cylindrotomidae", "Dixidae", "Dolichopodidae", 
             "Empididae", "Ephydridae", "Limoniidae", "Psychodidae", "Ptychopteridae",
             "Rhagionidae", "Scatophagidae", "Sciomyzidae", "Simuliidae", "Stratiomyidae",
             "Syrphidae", "Tabanidae", "Thaumaleidae", "Tipulidae")

alletaxa <- c(andere, mollusca, anderearthro, ephemeroptera, odonata, plecoptera, heteroptera,
          coleoptera, hym, trichoptera, lepi, diptera)

