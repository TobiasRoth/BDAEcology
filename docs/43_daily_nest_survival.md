
# Daily nest survival {#dailynestsurv}

## Background

Analyses of nest survival is important for understanding the mechanisms of population dynamics. The life-span of a nest could be used as a measure of nest survival. However, this measure very often is biased towards nests that survived longer because these nests are detected by the ornithologists with higher probability [@Mayfield1975]. Therefore, instead of estimating overall nest survival it is better to estimate daily nest survival conditional on survival to the previous day. 


## Models for estimating daily nest survival
Using a simple logistic regression with an indicator for whether a nest is alive or not at day $t$ is not appropriate for estimating nest survival because its result is directly dependent on the time point when the nest has been detected. This time point is not biologically relevant. The conditional logistic regression `clogit` from the `survival` package could be used to describe correlations of the mortality with environmental variables but it does not provide an estimate for the daily survival probability. 
A natural model that allows estimating daily nest survival is the known-fate survival model. It is a Markov model that models the state of a nest $i$ at day $t$ (whether it is alive, $y_{it}=1$ or not $y_{it}=0$) as a Bernoulli variable dependent on the state of the nest the day before.  
$$ y_{it} \sim Bernoulli(y_{it-1}S_{it})$$
The daily nest survival $S_{it}$ can be linearly related to predictor variables that are measured on the nest or on the day level.

$$logit(S_{it}) = \textbf{X} \beta$$
It is also possible to add random effects if needed.


## The Stan model {#dailynestsurvstan}
The following Stan model code is saved as `daily_nest_survival.stan`.


```stan
data {
  int<lower=0> Nnests;                  // number of nests
  int<lower=0> last[Nnests];            // day of last observation (alive or dead)
  int<lower=0> first[Nnests];           // day of first observation (alive or dead)
  int<lower=0> maxage;                  // maximum of last
  int<lower=0> y[Nnests, maxage];       // indicator of alive nests
  real cover[Nnests];                 // a covariate of the nest
  real age[maxage];                   // a covariate of the date
}

parameters {
  vector[4] b;                          // coef of linear pred for S
}

model {
  real S[Nnests, maxage-1];             // survival probability
                
  for(i in 1:Nnests){  
    for(t in first[i]:(last[i]-1)){ 
      S[i,t] = inv_logit(b[1] + b[2]*cover[i] + b[3]*age[t] + b[4]*pow(age[t], 2)); 
    }
  }

  // priors
  b[1]~normal(0,5);
  b[2]~normal(0,3);
  b[3]~normal(0,3);  
  b[4]~normal(0,3);

  // likelihood
  for (i in 1:Nnests) {
    for(t in (first[i]+1):last[i]){
      y[i,t]~bernoulli(y[i,t-1]*S[i,t-1]);
    }
  }
}

```



## Prepare data and run Stan

Read data DESCRIPTION OF ORIGIN INCL REFERENCE MISSING


```r
load("RData/nest_surv_data.rda")
str(datax)
```

```
## List of 7
##  $ y     : int [1:157, 1:38] 1 NA 1 NA 1 NA NA 1 1 1 ...
##  $ Nnests: int 157
##  $ last  : int [1:157] 26 30 32 27 31 30 31 31 33 31 ...
##  $ first : int [1:157] 1 14 1 3 1 24 18 1 1 1 ...
##  $ cover : num [1:157] -0.944 -0.226 0.133 0.133 -0.226 ...
##  $ age   : num [1:38] -1.66 -1.57 -1.48 -1.39 -1.3 ...
##  $ maxage: int 38
```

```r
datax$y[is.na(datax$y)] <- 0  # Stan does not allow for NA's in the outcome
```


```r
# Run STAN
library(rstan)

mod <- stan(file = "stanmodels/daily_nest_survival.stan", data=datax, 
            chains=5, iter=2500, control=list(adapt_delta=0.9), verbose = FALSE)
```

```
## In file included from C:/Users/fk/Documents/R/win-library/3.5/BH/include/boost/config.hpp:39:0,
##                  from C:/Users/fk/Documents/R/win-library/3.5/BH/include/boost/math/tools/config.hpp:13,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/stan/math/rev/core/var.hpp:7,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/stan/math/rev/core/gevv_vvv_vari.hpp:5,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/stan/math/rev/core.hpp:12,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/stan/math/rev/mat.hpp:4,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/stan/math.hpp:4,
##                  from C:/Users/fk/Documents/R/win-library/3.5/StanHeaders/include/src/stan/model/model_header.hpp:4,
##                  from filedc281745c.cpp:8:
## C:/Users/fk/Documents/R/win-library/3.5/BH/include/boost/config/compiler/gcc.hpp:186:0: warning: "BOOST_NO_CXX11_RVALUE_REFERENCES" redefined
##  #  define BOOST_NO_CXX11_RVALUE_REFERENCES
##  ^
## <command-line>:0:0: note: this is the location of the previous definition
## cc1plus.exe: warning: unrecognized command line option "-Wno-ignored-attributes"
## 
## SAMPLING FOR MODEL 'daily_nest_survival' NOW (CHAIN 1).
## 
## Gradient evaluation took 0 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2500 [  0%]  (Warmup)
## Iteration:  250 / 2500 [ 10%]  (Warmup)
## Iteration:  500 / 2500 [ 20%]  (Warmup)
## Iteration:  750 / 2500 [ 30%]  (Warmup)
## Iteration: 1000 / 2500 [ 40%]  (Warmup)
## Iteration: 1250 / 2500 [ 50%]  (Warmup)
## Iteration: 1251 / 2500 [ 50%]  (Sampling)
## Iteration: 1500 / 2500 [ 60%]  (Sampling)
## Iteration: 1750 / 2500 [ 70%]  (Sampling)
## Iteration: 2000 / 2500 [ 80%]  (Sampling)
## Iteration: 2250 / 2500 [ 90%]  (Sampling)
## Iteration: 2500 / 2500 [100%]  (Sampling)
## 
##  Elapsed Time: 7.441 seconds (Warm-up)
##                7.933 seconds (Sampling)
##                15.374 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'daily_nest_survival' NOW (CHAIN 2).
## 
## Gradient evaluation took 0 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2500 [  0%]  (Warmup)
## Iteration:  250 / 2500 [ 10%]  (Warmup)
## Iteration:  500 / 2500 [ 20%]  (Warmup)
## Iteration:  750 / 2500 [ 30%]  (Warmup)
## Iteration: 1000 / 2500 [ 40%]  (Warmup)
## Iteration: 1250 / 2500 [ 50%]  (Warmup)
## Iteration: 1251 / 2500 [ 50%]  (Sampling)
## Iteration: 1500 / 2500 [ 60%]  (Sampling)
## Iteration: 1750 / 2500 [ 70%]  (Sampling)
## Iteration: 2000 / 2500 [ 80%]  (Sampling)
## Iteration: 2250 / 2500 [ 90%]  (Sampling)
## Iteration: 2500 / 2500 [100%]  (Sampling)
## 
##  Elapsed Time: 7.172 seconds (Warm-up)
##                7.558 seconds (Sampling)
##                14.73 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'daily_nest_survival' NOW (CHAIN 3).
## 
## Gradient evaluation took 0 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2500 [  0%]  (Warmup)
## Iteration:  250 / 2500 [ 10%]  (Warmup)
## Iteration:  500 / 2500 [ 20%]  (Warmup)
## Iteration:  750 / 2500 [ 30%]  (Warmup)
## Iteration: 1000 / 2500 [ 40%]  (Warmup)
## Iteration: 1250 / 2500 [ 50%]  (Warmup)
## Iteration: 1251 / 2500 [ 50%]  (Sampling)
## Iteration: 1500 / 2500 [ 60%]  (Sampling)
## Iteration: 1750 / 2500 [ 70%]  (Sampling)
## Iteration: 2000 / 2500 [ 80%]  (Sampling)
## Iteration: 2250 / 2500 [ 90%]  (Sampling)
## Iteration: 2500 / 2500 [100%]  (Sampling)
## 
##  Elapsed Time: 6.991 seconds (Warm-up)
##                8.303 seconds (Sampling)
##                15.294 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'daily_nest_survival' NOW (CHAIN 4).
## 
## Gradient evaluation took 0.016 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 160 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2500 [  0%]  (Warmup)
## Iteration:  250 / 2500 [ 10%]  (Warmup)
## Iteration:  500 / 2500 [ 20%]  (Warmup)
## Iteration:  750 / 2500 [ 30%]  (Warmup)
## Iteration: 1000 / 2500 [ 40%]  (Warmup)
## Iteration: 1250 / 2500 [ 50%]  (Warmup)
## Iteration: 1251 / 2500 [ 50%]  (Sampling)
## Iteration: 1500 / 2500 [ 60%]  (Sampling)
## Iteration: 1750 / 2500 [ 70%]  (Sampling)
## Iteration: 2000 / 2500 [ 80%]  (Sampling)
## Iteration: 2250 / 2500 [ 90%]  (Sampling)
## Iteration: 2500 / 2500 [100%]  (Sampling)
## 
##  Elapsed Time: 7.237 seconds (Warm-up)
##                7.497 seconds (Sampling)
##                14.734 seconds (Total)
## 
## 
## SAMPLING FOR MODEL 'daily_nest_survival' NOW (CHAIN 5).
## 
## Gradient evaluation took 0 seconds
## 1000 transitions using 10 leapfrog steps per transition would take 0 seconds.
## Adjust your expectations accordingly!
## 
## 
## Iteration:    1 / 2500 [  0%]  (Warmup)
## Iteration:  250 / 2500 [ 10%]  (Warmup)
## Iteration:  500 / 2500 [ 20%]  (Warmup)
## Iteration:  750 / 2500 [ 30%]  (Warmup)
## Iteration: 1000 / 2500 [ 40%]  (Warmup)
## Iteration: 1250 / 2500 [ 50%]  (Warmup)
## Iteration: 1251 / 2500 [ 50%]  (Sampling)
## Iteration: 1500 / 2500 [ 60%]  (Sampling)
## Iteration: 1750 / 2500 [ 70%]  (Sampling)
## Iteration: 2000 / 2500 [ 80%]  (Sampling)
## Iteration: 2250 / 2500 [ 90%]  (Sampling)
## Iteration: 2500 / 2500 [100%]  (Sampling)
## 
##  Elapsed Time: 7.642 seconds (Warm-up)
##                7.129 seconds (Sampling)
##                14.771 seconds (Total)
```


## Check convergence

We love exploring the performance of the Markov chains by using the function `launch_shinystan` from the package `shinystan`. 

## Look at results
It looks like cover does not affect daily nest survival, but daily nest survival decreases with the age of the nestlings.


```r
print(mod)
```

```
## Inference for Stan model: daily_nest_survival.
## 5 chains, each with iter=2500; warmup=1250; thin=1; 
## post-warmup draws per chain=1250, total post-warmup draws=6250.
## 
##         mean se_mean   sd    2.5%     25%     50%     75%   97.5% n_eff
## b[1]    3.88    0.00 0.19    3.53    3.75    3.87    4.00    4.26  3630
## b[2]    0.00    0.00 0.13   -0.24   -0.09    0.00    0.08    0.26  5627
## b[3]   -0.90    0.00 0.19   -1.26   -1.03   -0.90   -0.77   -0.53  4301
## b[4]   -0.18    0.00 0.24   -0.64   -0.34   -0.19   -0.03    0.29  3556
## lp__ -306.91    0.03 1.46 -310.67 -307.61 -306.57 -305.85 -305.10  2620
##      Rhat
## b[1]    1
## b[2]    1
## b[3]    1
## b[4]    1
## lp__    1
## 
## Samples were drawn using NUTS(diag_e) at Tue Jan 01 13:43:07 2019.
## For each parameter, n_eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor on split chains (at 
## convergence, Rhat=1).
```



```r
# effect plot
bsim <- as.data.frame(mod)
nsim <- nrow(bsim)

newdat <- data.frame(age=seq(1, datax$maxage, length=100))
newdat$age.z <- (newdat$age-mean(1:datax$maxage))/sd((1:datax$maxage))
Xmat <- model.matrix(~age.z+I(age.z^2), data=newdat)
fitmat <- matrix(ncol=nsim, nrow=nrow(newdat))
for(i in 1:nsim) fitmat[,i] <- plogis(Xmat%*%as.numeric(bsim[i,c(1,3,4)]))
newdat$fit <- apply(fitmat, 1, median)
newdat$lwr <- apply(fitmat, 1, quantile, prob=0.025)
newdat$upr <- apply(fitmat, 1, quantile, prob=0.975)

plot(newdat$age, newdat$fit, ylim=c(0.8,1), type="l",
     las=1, ylab="Daily nest survival", xlab="Age [d]")
lines(newdat$age, newdat$lwr, lty=3)
lines(newdat$age, newdat$upr, lty=3)
```

<div class="figure">
<img src="43_daily_nest_survival_files/figure-html/effplots-1.png" alt="Estimated daily nest survival probability in relation to nest age. Dotted lines are 95% uncertainty intervals of the regression line." width="768" />
<p class="caption">(\#fig:effplots)Estimated daily nest survival probability in relation to nest age. Dotted lines are 95% uncertainty intervals of the regression line.</p>
</div>



## Further reading {-}
ADD EXAMPLE STUDIES!!





