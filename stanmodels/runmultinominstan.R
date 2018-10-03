# run multinomial model in stan


# fit model
library(blmeco)
library(birdring)
library(rstan)

p <- c(0.1, 0.3, 0.6)
N <- rep(40, 20)
y <- rmultinom(20, N, prob=p)

datax <- list(y=t(y), nrow=20, ncol=3, ncolp1= 4)


parameters <- c("p")
str(datax)
head(datax)

test.mod <- stan(file="MR mnl_2_ohneJahrohneSite.stan", data=datax, iter=1000, chains=2)
