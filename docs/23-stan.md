
# MCMC using Stan {#stan}

## Background
Markov chain Monte Carlo (MCMC) simulation techniques were developed in the mid-1950s by physicists (Metropolis et al., 1953). Later, statisticians discovered MCMC (Hastings, 1970; Geman & Geman, 1984; Tanner & Wong, 1987; Gelfand et al., 1990; Gelfand & Smith, 1990). MCMC methods make it possible to obtain posterior distributions for parameters and latent variables (unobserved variables) of complex models. In parallel, personal computer capacities increased in the 1990s and user-friendly software such as the different programs based on the programming language BUGS (Spiegelhalter et al., 2003) came out. These developments boosted the use of Bayesian data analyses, particularly in genetics and ecology.


## Install `rstan`
In this book we use the program [Stan](http://mc-stan.org) to draw random samples from the joint posterior distribution of the model parameters given a model, the data, prior distributions, and initial values. To do so, it uses the “no-U-turn sampler,” which is a type of Hamiltonian Monte Carlo simulation [@Hoffman2014; @Betancourt2013_b], and optimization-based point estimation. These algorithms are more efficient than the ones implemented in BUGS programs and they can handle larger data sets. Stan works particularly well for hierar- chical models [@Betancourt2013]. Stan runs on Windows, Mac, and Linux and can be used via the R interface `rstan`. Stan is automatically installed when the R package `rstan` is installed. For [installing rstan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started), it is advised to follow closely the system-specific instructions. 

## Writing a Stan model {#firststanmod}
The statistical model is written in the Stan language and saved in a text file. The Stan language is rather strict, forcing the user to write unambiguous models. Stan is very well documented and the [Stan Documentation](http://mc-stan.org/users/documentation/index.html) contains a comprehensive Language Manual, a Wiki documentation and various tutorials. 

We here provide a normal regression with one predictor variable as a worked example. The entire Stan model is as following (saved as `linreg.stan`)


```stan
data {
  int<lower=0> n;
  vector[n] y;
  vector[n] x;
}

parameters {
  vector[2] beta;
  real<lower=0> sigma;
}

model {
  //priors
  beta ~ normal(0,5);
  sigma ~ cauchy(0,5);
  // likelihood
  y ~ normal(beta[1] + beta[2] * x, sigma);
}
```

A Stan model consists of different named blocks. These blocks are (from first to last): data, transformed data, parameters, trans- formed parameters, model, and generated quantities. The blocks must appear in this order. The model block is mandatory; all other blocks are optional. 

In the *data* block, the type, dimension, and name of every variable has to be declared. Optionally, the range of possible values can be specified. For example, `vector[N] y;` means that y is a vector (type real) of length N, and `int<lower=0> N;` means that N is an integer with nonnegative values (the bounds, here 0, are included). Note that the restriction to a possible range of values is not strictly necessary but this will help specifying the correct model and it will improve speed. We also see that each line needs to be closed by a column sign. In the parameters block, all model parameters have to be defined. The coefficients of the linear predictor constitute a vector of length 2, `vector[2] beta;`. Alternatively, `real beta[2];` could be used. The sigma parameter is a one-number parameter that has to be positive, therefore `real<lower=0> sigma;`.

The *model* block contains the model specification. Stan functions can handle vectors and we do not have to loop over all observations as typical for BUGS . Here, we use a [Cauchy distribution](#cauchydistri) as a prior distribution for sigma. This distribution can have negative values, but because we defined the lower limit of sigma to be 0 in the parameters block, the prior distribution actually used in the model is a truncated Cauchy distribution (truncated at zero). In Chapter \@ref(choosepriors) we explain how to choose prior distributions.

Further characteristics of the Stan language that are good to know include: The variance parameter for the normal distribution is specified as the standard deviation (like in R but different from BUGS, where the precision is used). If no prior is specified, Stan uses a uniform prior over the range of possible values as specified in the parameter block. Variable names must not contain periods, for example, `x.z` would not be allowed, but `x_z` is allowed. To comment out a line, use double forward-slashes `//`. 


## Run Stan from R
We fit the model to simulated data. Stan needs a vector containing the names of the data objects. In our case, `x`, `y,` and `N` are objects that exist in the R console.

The function `stan()` starts Stan and returns an object containing MCMCs for every model parameter. We have to specify the name of the file that contains the model specification, the data, the number of chains, and the number of iterations per chain we would like to have. The first half of the iterations of each chain is declared as the warm-up. During the warm-up, Stan is not simulating a Markov chain, because in every step the algorithm is adapted. After the warm-up the algorithm is fixed and Stan simulates Markov chains.


```r
library(rstan)

# Simulate fake data 
n <- 50                                      # sample size
sigma <- 5                                   # standard deviation of the residuals
b0 <- 2                                      # intercept
b1 <- 0.7                                    # slope

x <- runif(n, 10, 30)                        # random numbers of the covariate
simresid <- rnorm(n, 0, sd=sigma)            # residuals

y <- b0 + b1*x + simresid                    # calculate y, i.e. the data

# Bundle data into a list 
datax <- list(n=length(y), y=y, x=x)

# Run STAN
fit <- stan(file = "stanmodels/linreg.stan", data=datax, verbose = FALSE)
```

```
## 
## SAMPLING FOR MODEL 'linreg' NOW (CHAIN 1).
## Chain 1: 
## Chain 1: Gradient evaluation took 2e-05 seconds
## Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 0.2 seconds.
## Chain 1: Adjust your expectations accordingly!
## Chain 1: 
## Chain 1: 
## Chain 1: Iteration:    1 / 2000 [  0%]  (Warmup)
## Chain 1: Iteration:  200 / 2000 [ 10%]  (Warmup)
## Chain 1: Iteration:  400 / 2000 [ 20%]  (Warmup)
## Chain 1: Iteration:  600 / 2000 [ 30%]  (Warmup)
## Chain 1: Iteration:  800 / 2000 [ 40%]  (Warmup)
## Chain 1: Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Chain 1: Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Chain 1: Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Chain 1: Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Chain 1: Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Chain 1: Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Chain 1: Iteration: 2000 / 2000 [100%]  (Sampling)
## Chain 1: 
## Chain 1:  Elapsed Time: 0.074881 seconds (Warm-up)
## Chain 1:                0.06265 seconds (Sampling)
## Chain 1:                0.137531 seconds (Total)
## Chain 1: 
## 
## SAMPLING FOR MODEL 'linreg' NOW (CHAIN 2).
## Chain 2: 
## Chain 2: Gradient evaluation took 7e-06 seconds
## Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 0.07 seconds.
## Chain 2: Adjust your expectations accordingly!
## Chain 2: 
## Chain 2: 
## Chain 2: Iteration:    1 / 2000 [  0%]  (Warmup)
## Chain 2: Iteration:  200 / 2000 [ 10%]  (Warmup)
## Chain 2: Iteration:  400 / 2000 [ 20%]  (Warmup)
## Chain 2: Iteration:  600 / 2000 [ 30%]  (Warmup)
## Chain 2: Iteration:  800 / 2000 [ 40%]  (Warmup)
## Chain 2: Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Chain 2: Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Chain 2: Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Chain 2: Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Chain 2: Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Chain 2: Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Chain 2: Iteration: 2000 / 2000 [100%]  (Sampling)
## Chain 2: 
## Chain 2:  Elapsed Time: 0.075796 seconds (Warm-up)
## Chain 2:                0.066709 seconds (Sampling)
## Chain 2:                0.142505 seconds (Total)
## Chain 2: 
## 
## SAMPLING FOR MODEL 'linreg' NOW (CHAIN 3).
## Chain 3: 
## Chain 3: Gradient evaluation took 7e-06 seconds
## Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 0.07 seconds.
## Chain 3: Adjust your expectations accordingly!
## Chain 3: 
## Chain 3: 
## Chain 3: Iteration:    1 / 2000 [  0%]  (Warmup)
## Chain 3: Iteration:  200 / 2000 [ 10%]  (Warmup)
## Chain 3: Iteration:  400 / 2000 [ 20%]  (Warmup)
## Chain 3: Iteration:  600 / 2000 [ 30%]  (Warmup)
## Chain 3: Iteration:  800 / 2000 [ 40%]  (Warmup)
## Chain 3: Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Chain 3: Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Chain 3: Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Chain 3: Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Chain 3: Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Chain 3: Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Chain 3: Iteration: 2000 / 2000 [100%]  (Sampling)
## Chain 3: 
## Chain 3:  Elapsed Time: 0.070117 seconds (Warm-up)
## Chain 3:                0.059636 seconds (Sampling)
## Chain 3:                0.129753 seconds (Total)
## Chain 3: 
## 
## SAMPLING FOR MODEL 'linreg' NOW (CHAIN 4).
## Chain 4: 
## Chain 4: Gradient evaluation took 7e-06 seconds
## Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 0.07 seconds.
## Chain 4: Adjust your expectations accordingly!
## Chain 4: 
## Chain 4: 
## Chain 4: Iteration:    1 / 2000 [  0%]  (Warmup)
## Chain 4: Iteration:  200 / 2000 [ 10%]  (Warmup)
## Chain 4: Iteration:  400 / 2000 [ 20%]  (Warmup)
## Chain 4: Iteration:  600 / 2000 [ 30%]  (Warmup)
## Chain 4: Iteration:  800 / 2000 [ 40%]  (Warmup)
## Chain 4: Iteration: 1000 / 2000 [ 50%]  (Warmup)
## Chain 4: Iteration: 1001 / 2000 [ 50%]  (Sampling)
## Chain 4: Iteration: 1200 / 2000 [ 60%]  (Sampling)
## Chain 4: Iteration: 1400 / 2000 [ 70%]  (Sampling)
## Chain 4: Iteration: 1600 / 2000 [ 80%]  (Sampling)
## Chain 4: Iteration: 1800 / 2000 [ 90%]  (Sampling)
## Chain 4: Iteration: 2000 / 2000 [100%]  (Sampling)
## Chain 4: 
## Chain 4:  Elapsed Time: 0.080744 seconds (Warm-up)
## Chain 4:                0.060983 seconds (Sampling)
## Chain 4:                0.141727 seconds (Total)
## Chain 4:
```


## Further reading {-}
- [Stan-Homepage](http://mc-stan.org): It contains the documentation for Stand a a lot of tutorials.





