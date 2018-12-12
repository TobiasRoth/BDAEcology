

# Prerequisits: Basic statistical terms {#basics}

This chapter introduces some important terms useful for doing data analyses.
It also introduces the essentials of the classical frequentist tests such as t- and Chisquare test. We will not use them later but we think it is important to know how to interpret the results in order to be able to understand 100 years of scientific literature. For each classical test, we provide a suggestion how to do it in a Bayesian way and we discuss some differences between the Bayesian and frequentist statistics. 


## Scale of measurement


Scale   | Examples          | Properties        | Coding in R | 
:-------|:------------------|:------------------|:--------------------|
Nominal | Sex, genotype, habitat  | Identity (values have a unique meaning) | `factor()` |
Ordinal | Elevational zones | Identity and magnitude (values have an ordered relationship) | `ordered()` |
Numeric | Discrete: counts;  continuous: body weight, wing length | Identity, magnitude, and equal intervals | `intgeger()` `numeric()` |



## Correlations

### Basics of variances, covariances and correlations
  
- variance $\hat{\sigma^2} = s^2 = \frac{1}{n-1}\sum_{i=1}^{n}(x_i-\bar{x})^2$  
The term $(n-1)$ is called the degrees of freedom.  
  
      
- standard deviation $\hat{\sigma} = s = \sqrt{s^2}$  
  
    
  
- covariance $q = \frac{1}{n-1}\sum_{i=1}^{n}((x_i-\bar{x})*(y_i-\bar{y}))$  


### Pearson correlation coefficient
  
standardized covariance

$$r=\frac{\sum_{i=1}^{n}(x_i-\bar{x})(y_i-\bar{y})}{\sqrt{\sum_{i=1}^{n}(x_i-\bar{x})^2\sum_{i=1}^{n}(y_i-\bar{y})^2}}$$



### Spearman correlation coefficient
rank correlation  
correlation between rank(x) and rank(y)  
  
  robust against outliers

### Kendall's tau
rank correlation  

I = number of pairs (i,k) for which $(x_i < x_k)$ & $(y_i > y_k)$ or viceversa  
$\tau = 1-\frac{4I}{(n(n-1))}$



## Principal components analyses PCA
rotation of the coordinate system

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-2-1.png" alt="Principal components are eigenvectors of the covariance or correlation matrix" width="768" />
<p class="caption">(\#fig:unnamed-chunk-2)Principal components are eigenvectors of the covariance or correlation matrix</p>
</div>



rotation of the coordinate system so that   

* first component explains most variance  
* second component explains most of the remaining variance and is perpendicular to the first one  
* third component explains most of the remaining variance and is perpendicular to the first two  
* ...  

$(x,y)$ becomes $(pc1, pc2)$  
where  
$pc1_i= b_{11} x_i + b_{12} y_i$  
$pc2_i = b_{21} x_i + b_{22} y_i$ with $b_{jk}$ being loadings


```r
pca <- princomp(cbind(x,y), cor=TRUE)
loadings(pca)
```

```
## 
## Loadings:
##   Comp.1 Comp.2
## x  0.707  0.707
## y  0.707 -0.707
## 
##                Comp.1 Comp.2
## SS loadings       1.0    1.0
## Proportion Var    0.5    0.5
## Cumulative Var    0.5    1.0
```
loadings of a component can be multiplied by -1


proportion of variance explained by each component  
number of components = number of variables

```r
summary(pca)
```

```
## Importance of components:
##                           Comp.1    Comp.2
## Standard deviation     1.2814424 0.5982520
## Proportion of Variance 0.8210473 0.1789527
## Cumulative Proportion  0.8210473 1.0000000
```
outlook: components with low variance are shrinked to a higher degree in Ridge regression


### Inferential statistics

> there is never a "yes-or-no" answer  
> there will always be uncertainty  
Amrhein (2017)[https://peerj.com/preprints/26857]

The decision whether an effect is important or not cannot not be done based on data alone. For a decision we should carefully consider the consequences of each decision, the aims we would like to achieve and the data. Consequences, needs and wishes of different stakeholders can be formally combined with the information in data by using methods of the decision theory. In most data analyses, particularly in basic research and when working on case studies, we normally do not consider consequences of decisions. In these cases, our job is extracting the information of data so that this information later can be used by other scientists, stakeholders and politicians to make decisions.

Therefore, statistics is describing pattern in data and quantifying the uncertainty of the described patterns that is due to the fact that the data is just a (small) random sample from the population we would like to know. 

Quantification of uncertainty is only possible if  
  
1. the mechanisms under study are known
2. the observations are a random sample from the population of interest

Solutions:  
to 1. working with models and reporting assumptions  
to 2. study design

> reported uncertainties always are too small!


Example: Number of stats courses before starting a PhD among all PhD students

```r
# simulate the virtual true population
set.seed(235325)   # set seed for random number generator

# simulate fake data of the whole population
statscourses <- rpois(300000, rgamma(300000, 2, 3))  

# draw a random sample from the population
n <- 12            # sample size
y <- sample(statscourses, 12, replace=FALSE)         
```


<img src="02-prerequisites_files/figure-html/unnamed-chunk-6-1.png" width="768" />



We observe the sample mean, what do we know about the population mean?  

Frequentist solution: How would the sample mean scatter, if we repeat the study many times?  

Bayesian solution: For any possible value, what is the probability that it is the true population mean?  

<img src="02-prerequisites_files/figure-html/unnamed-chunk-7-1.png" width="768" />


## Standard deviation and standard error  

<img src="02-prerequisites_files/figure-html/unnamed-chunk-8-1.png" width="768" />



frequentist SE = SD/sqrt(n)  
  
Bayesian SE = SD of posterior distribution


## Central limit theorem / law of large numbers
  
    
<img src="02-prerequisites_files/figure-html/unnamed-chunk-9-1.png" width="768" />



normal distribution = Gaussian distribution  
 
 $p(\theta) = \frac{1}{\sqrt{2\pi}\sigma}exp(-\frac{1}{2\sigma^2}(\theta -\mu)^2) = Normal(\mu, \sigma)$  
   
     
       
   $E(\theta) = \mu$, $var(\theta) = \sigma^2$, $mode(\theta) = \mu$


  
    
<img src="02-prerequisites_files/figure-html/unnamed-chunk-10-1.png" width="768" />




## Bayes theorem

  
  
$P(A|B) = \frac{P(B|A)P(A)}{P(B)}$  

car    | flowers        | wine           | **sum**               | 
:------|:---------------|:---------------|:------------------|
no | 5  | 3  | **8** |
yes   | 1  | 4  | **5** |
-------|----------------|----------------|-------------------|
**sum**    | **6**| **7**| **13** |

What is the probability that the person likes wine given it has no car?  
$P(A) =$ likes wine $= 0.54$  
$P(B) =$ no car $= 0.62$   

$P(B|A) =$ proportion car-free people among the wine liker $= 0.43$

Knowing whether a persons owns a car increases the knowledge of the birthday preference.


## Bayes theorem for continuous parameters

$p(\theta|y) = \frac{p(y|\theta)p(\theta)}{p(y)} = \frac{p(y|\theta)p(\theta)}{\int p(y|\theta)p(\theta) d\theta}$    


$p(\theta|y)$: posterior distribution

$p(y|\theta)$: likelihood, data model

$p(\theta)$: prior distribution

$p(y)$: scaling constant



## Single parameter model

$p(y|\theta) = Norm(\theta, \sigma)$, with $\sigma$ known 
  
  
$p(\theta) = Norm(\mu_0, \tau_0)$  

$p(\theta|y) = Norm(\mu_n, \tau_n)$, where
 $\mu_n= \frac{\frac{1}{\tau_0^2}\mu_0 + \frac{n}{\sigma^2}\bar{y}}{\frac{1}{\tau_0^2}+\frac{n}{\sigma^2}}$ and
 $\frac{1}{\tau_n^2} = \frac{1}{\tau_0^2} + \frac{n}{\sigma^2}$
  
    
  $\bar{y}$ is a sufficient statistics  
  $p(\theta) = Norm(\mu_0, \tau_0)$ is a conjugate prior for $p(y|\theta) = Norm(\theta, \sigma)$, with $\sigma$ known.



Posterior mean = weighted average between prior mean and $\bar{y}$ with weights
equal to the precisions ($\frac{1}{\tau_0^2}$ and $\frac{n}{\sigma^2}$)
<img src="02-prerequisites_files/figure-html/unnamed-chunk-12-1.png" width="5600" />



## A model with two parameters
$p(y|\theta, \sigma) = Norm(\theta, \sigma)$ 
  
\begin{center}
  \includegraphics[width=0.5\textwidth]{images/snowfinch2.jpg}
\end{center}


```r
# weight (g)
y <- c(47.5, 43, 43, 44, 48.5, 37.5, 41.5, 45.5)
n <- length(y)
```



$p(y|\theta, \sigma) = Norm(\theta, \sigma)$ 
  
    
$p(\theta, \sigma) = N-Inv-\chi^2(\mu_0, \sigma_0^2/\kappa_0; v_0, \sigma_0^2)$ conjugate prior

  
$p(\theta,\sigma|y) = \frac{p(y|\theta, \sigma)p(\theta, \sigma)}{p(y)} = N-Inv-\chi^2(\mu_n, \sigma_n^2/\kappa_n; v_n, \sigma_n^2)$, with  

  
$\mu_n= \frac{\kappa_0}{\kappa_0+n}\mu_0 + \frac{n}{\kappa_0+n}\bar{y}$  
  
  $\kappa_n = \kappa_0+n$  
  
  $v_n = v_0 +n$  
  
  $v_n\sigma_n^2=v_0\sigma_0^2+(n-1)s^2+\frac{\kappa_0n}{\kappa_0+n}(\bar{y}-\mu_0)^2$

  
 $\bar{y}$ and $s^2$ are sufficient statistics  

Joint, marginal and conditional posterior distributions
<img src="02-prerequisites_files/figure-html/unnamed-chunk-14-1.png" width="768" />



## t-distribution
marginal posterior distribution of a normal mean with unknown variance and conjugate prior distribution  

  
$p(\theta|v,\mu,\sigma) = \frac{\Gamma((v+1)/2)}{\Gamma(v/2)\sqrt{v\pi}\sigma}(1+\frac{1}{v}(\frac{\theta-\mu}{\sigma})^2)^{-(v+1)/2}$  


$v$ degrees of freedom  
$\mu$ location  
$\sigma$ scale



## Frequentist one-sample t-test
H0: the mean weight is equal to exactly 40g.  

$t = \frac{\bar{y}-\mu_0}{\frac{s}{\sqrt{n}}}$

```r
t.test(y, mu=40)
```

```
## 
## 	One Sample t-test
## 
## data:  y
## t = 3.0951, df = 7, p-value = 0.01744
## alternative hypothesis: true mean is not equal to 40
## 95 percent confidence interval:
##  40.89979 46.72521
## sample estimates:
## mean of x 
##   43.8125
```


## Nullhypothesis test
p-value: Probability of the data or more extreme data given the null hypothesis is true.

<img src="02-prerequisites_files/figure-html/unnamed-chunk-16-1.png" width="768" style="display: block; margin: auto;" />


## Confidence interval

```r
# lower limit of 95% CI
mean(y) + qt(0.025, df=7)*sd(y)/sqrt(n) 
# upper limit of 95% CI
mean(y) + qt(0.975, df=7)*sd(y)/sqrt(n) 
```


<img src="02-prerequisites_files/figure-html/unnamed-chunk-18-1.png" width="576" style="display: block; margin: auto;" />



## Posterior distribution
<img src="02-prerequisites_files/figure-html/unnamed-chunk-19-1.png" width="768" />


 Two different theories - one single result!


## Posterior probability
Probability $P(H:\mu<=40) =$ 0.01
<img src="02-prerequisites_files/figure-html/unnamed-chunk-20-1.png" width="768" style="display: block; margin: auto;" />

## Monte Carlo simulation (parametric bootstrap)  
  
Monte Carlo integration: numerical solution of $\int_{-1}^{1.5} F(x) dx$ 
<img src="02-prerequisites_files/figure-html/unnamed-chunk-21-1.png" width="768" />


sim is solving a mathematical problem by simulation
How sim is simulating to get the marginal distribution of $\mu$:

<img src="02-prerequisites_files/figure-html/unnamed-chunk-22-1.png" width="768" />


## 3 methods for getting the posterior distribution

* analytically
* approximation
* Monte Carlo simulation



## Grid approximation
  
$p(\theta|y) = \frac{p(y|\theta)p(\theta)}{p(y)}$ 
  
For example, one coin flip (Bernoulli model) 
  
data: y=0  (a tail)  
likelihood: $p(y|\theta)=\theta^y(1-\theta)^{(1-y)}$


<img src="02-prerequisites_files/figure-html/unnamed-chunk-23-1.png" width="768" />


## Monte Carlo simulations

* Markov chain Monte Carlo simulation (BUGS, Jags)
* Hamiltonian Monte Carlo (Stan)

<img src="02-prerequisites_files/figure-html/unnamed-chunk-24-1.png" width="768" />


## Comparison of the locations between two groups 
Boxplot:  
Median, 50% box, extremes observation within 1.5 times the interquartile range, outliers  

The uncertainties of the means do not show the uncertainty of the difference between the means!  

<img src="02-prerequisites_files/figure-html/unnamed-chunk-25-1.png" width="768" />

## Difference between two means


```r
mod <- lm(ell~birthday, data=dat)
mod
```

```
## 
## Call:
## lm(formula = ell ~ birthday, data = dat)
## 
## Coefficients:
##  (Intercept)  birthdaywine  
##      43.3333        0.6667
```

```r
bsim <- sim(mod, n.sim=nsim)
quantile(bsim@coef[,2], prob=c(0.025, 0.5, 0.975))
```

```
##       2.5%        50%      97.5% 
## -1.6524462  0.6698085  2.9975599
```


## Two-sample t-test

```r
t.test(ell~birthday, data=dat, var.equal=TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  ell by birthday
## t = -0.63369, df = 11, p-value = 0.5392
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.982185  1.648851
## sample estimates:
## mean in group flowers    mean in group wine 
##              43.33333              44.00000
```



## Wilxocon test

```r
wilcox.test(ell~birthday, data=dat)
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  ell by birthday
## W = 18, p-value = 0.7172
## alternative hypothesis: true location shift is not equal to 0
```


## Randomisation test

```r
diffH0 <- numeric(nsim)
for(i in 1:nsim){
  randbirthday <- sample(dat$birthday)
  rmod <- lm(ell~randbirthday, data=dat)
  diffH0[i] <- coef(rmod)[2]
}
mean(abs(diffH0)>abs(coef(mod)[2])) # p-value
```

```
## [1] 0.4898
```

<img src="02-prerequisites_files/figure-html/unnamed-chunk-30-1.png" width="768" />


* Produces the distribution of a test statistics given the null hypothesis.  
* assumption: all observations are independent  
* becomes unfeasible when data is structured



## Bootstrap

```r
diffboot <- numeric(nsim)
for(i in 1:nsim){
  nbirthday <- 1
  while(nbirthday==1){
    bootrows <- sample(1:nrow(dat), replace=TRUE)
    nbirthday <- length(unique(dat$birthday[bootrows]))
  }
  rmod <- lm(ell~birthday, data=dat[bootrows,])
  diffboot[i] <- coef(rmod)[2]
}
quantile(diffboot, prob=c(0.025, 0.975))
```

```
##      2.5%     97.5% 
## -1.214286  2.725327
```


* result is a confidence interval  
* assumption: all observations are independent!


```r
hist(diffboot); abline(v=coef(mod)[2], lwd=2, col="red")
```

<img src="02-prerequisites_files/figure-html/unnamed-chunk-32-1.png" width="768" />


## F-distribution
Ratios of sample variances drawn from populations with equal variances follow an F-distribution. The density function of the F-distribution is even more complicated than the one of the t-distribution! We do not copy it here. Further, we have not yet met any Bayesian example where the F-distribution is used (that does not mean that there is no). It is used in frequentist analyses in order to compare variances, and, within the ANOVA, to compare means between groups. If two variances only differ because of natural variance in the data (nullhypothesis) then $\frac{Var(X_1)}{Var(X_2)}\sim F_{df_1,df_2}$.

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-33-1.png" alt="Different density functions of the F statistics" width="768" />
<p class="caption">(\#fig:unnamed-chunk-33)Different density functions of the F statistics</p>
</div>



### Analysis of variance ANOVA
The aim of an ANOVA is to compare means of groups. In a frequentist analysis, this is done by comparing the between-group with the within-group variance. The result of a Bayesian analysis is the joint posterior distribution of the group means.

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-34-1.png" alt="Number of stats courses students have taken before starting a PhD in relation to their feeling about statistics." width="768" />
<p class="caption">(\#fig:unnamed-chunk-34)Number of stats courses students have taken before starting a PhD in relation to their feeling about statistics.</p>
</div>

In the frequentist ANOVA, the following three sum of squared distances (SS) are used to calculate the total, the between- and within-group variances:  
Total sum of squares =  SST = $\sum_1^n{(y_i-\bar{y})^2}$  
Within-group SS = SSW = $\sum_1^n{(y_i-\bar{y_g})^2}$: unexplained variance  
Between-group SS = SSB = $\sum_1^g{n_g(\bar{y_g}-\bar{y})^2}$: explained variance  

The between-group and within-group SS sum to the total sum of squares: SST=SSB+SSW. Attention: this equation is only true in any case for a simple one-way ANOVA (just one grouping factor). If the data are grouped according to more than one factor (such as in a two- or three-way ANOVA), then there is one single solution for the equation only when the data is completely balanced, i.e. when there are the same number of observations in all combinations of factor levels. For non-balanced data with more than one grouping factor, there are different ways of calculating the SSBs, and the result of the F-test described below depends on the order of the predictors in the model.   

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-35-1.png" alt="Visualisation of the total, between-group and within-group sum of squares. Points are observations; long horizontal line is the overall mean; short horizontal lines are group specific means." width="768" />
<p class="caption">(\#fig:unnamed-chunk-35)Visualisation of the total, between-group and within-group sum of squares. Points are observations; long horizontal line is the overall mean; short horizontal lines are group specific means.</p>
</div>


In order to make SSB and SSW comparable, we have to divide them by their degrees of freedoms. For the within-group SS, SSW, the degrees of freedom is the number of obervations minus the number of groups ($g$), because $g$ means have been estimated from the data. If the $g$ means are fixed and $n-g$ data points are known, then the last $g$ data points are defined, i.e., they cannot be chosen freely. For the between-group SS, SSB, the degrees of freedom is the number of groups  minus 1 (the minus 1 stands for the overall mean).   

* MSB = SSB/df_between, MSW = SSW/df_within  

It can be shown (by mathematicians) that, given the nullhypothesis, the mean of all groups are equal $m_1 = m_2 = m_3$, then the mean squared errors between groups (MSB) is expected to be equal to the mean squared errors within the groups (MSW). Therefore, the ration MSB/MSW is  expected to follow an F-distribution given the nullhypothesis is true.

* MSB/MSW ~ F(df_between, df_within)


The Bayesian analysis for comparing group means consists of calculating the posterior distribution for each group mean and then drawing inference from these posterior distributions. 
A Bayesian one-way ANOVA involves the following steps:  
1. Decide for a data model: We, here, assume that the measurements are normally distributed around the group means. In this example here, we transform the outcome variable in order to better meet the normal assumption. Note: the frequentist ANOVA makes exactly the same assumptions. We can write the data model: $y_i\sim Norm(\mu_i,\sigma)$ with $mu_i= \beta_0 + \beta_1I(group=2) +\beta_1I(group=3)$, where the $I()$-function is an indicator function taking on 1 if the expression is true and 0 otherwise. This model has 4 parameters: $\beta_0$,  $\beta_1$, $\beta_2$ and $\sigma$. 


```r
# fit a normal model with 3 different means
mod <- lm(log(nrcourses+1)~statsfeeling, data=dat)
```

2. Choose a prior distribution for each model parameter: In this example, we choose flat prior distributions for each parameter. By using these priors, the result should not remarkably be affected by the prior distributions but almost only reflect the information in the data. We choose so-called improper prior distributions. These are completely flat distributions that give all parameter values the same probability. Such distributions are called improper because the area under the curve is not summing to 1 and therefore, they cannot be considered to be proper probability distributions. However, they can still be used to solve the Bayesian theorem.  

3. Solve the Bayes theorem: The solution of the Bayes theorem for the above priors and model is implemented in the function sim of the package arm. 


```r
# calculate numerically the posterior distributions of the model 
# parameters using flat prior distributions
nsim <- 5000
set.seed(346346)
bsim <- sim(mod, n.sim=nsim)
```

4. Display the joint posterior distributions of the group means  



```r
# calculate group means from the model parameters
newdat <- data.frame(statsfeeling=levels(dat$statsfeeling))
X <- model.matrix(~statsfeeling, data=newdat)
fitmat <- matrix(ncol=nsim, nrow=nrow(newdat))
for(i in 1:nsim) fitmat[,i] <- X%*%bsim@coef[i,]
hist(fitmat[1,], freq=FALSE, breaks=seq(-2.5, 4.2, by=0.1), main=NA, xlab="Group mean of log(number of courses +1)", las=1, ylim=c(0, 2.2))
hist(fitmat[2,], freq=FALSE, breaks=seq(-2.5, 4.2, by=0.1), main=NA, xlab="", las=1, add=TRUE, col=rgb(0,0,1,0.5))
hist(fitmat[3,], freq=FALSE, breaks=seq(-2.5, 4.2, by=0.1), main=NA, xlab="", las=1, add=TRUE, col=rgb(1,0,0,0.5))
legend(2,2, fill=c("white",rgb(0,0,1,0.5), rgb(1,0,0,0.5)), legend=levels(dat$statsfeeling))
```

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-38-1.png" alt="Posterior distributions of the mean number of stats courses PhD students visited before starting the PhD grouped according to their feelings about statistics." width="768" />
<p class="caption">(\#fig:unnamed-chunk-38)Posterior distributions of the mean number of stats courses PhD students visited before starting the PhD grouped according to their feelings about statistics.</p>
</div>

Based on the posterior distributions of the group means, we can extract derived quantities depending on our interest and questions. Here, for example, we could extract the posterior probability of the hypothesis that students with a positive feeling about statistics have a better education in statistics than those with a neutral or negative feeling about statistics.  


```r
# P(mean(positive)>mean(neutral))
mean(fitmat[3,]>fitmat[2,])
```

```
## [1] 0.9004
```

```r
# P(mean(positive)>mean(negative))
mean(fitmat[3,]>fitmat[1,])
```

```
## [1] 0.953
```

## Chisquare test
The chisquare test is used for two frequentist purposes.  
1. Testing for correlations between two categorical variables.  
2. Comparison of two distributions (goodness of fit test)

When testing for correlations between two categorical variables, then the nullhypothesis is "there is no correlation". The data can be displayed in cross-tables. 

```r
# Example: correlation between birthday preference and car ownership
table(dat$birthday, dat$car)
```

```
##          
##           N Y
##   flowers 5 1
##   wine    3 4
```

Given the nullhypothesis is true, we expect that the distribution of the data in each column of the cross-table is similar to the distribution of the row-sums. And, the distribution of the data in each row should be similar to the distribution of the column-sums. The chisquare test statistics $\chi^2$ measures the deviation of the data from this expected distribution of the data in the cross-table. 

For calculating the chisquare test statistics $\chi^2$, we first have to obtain for each cell in the cross-table the expected value $E_{ij}$ = rowsum*colsum/total.

$\chi^2$ measures the difference between the observed $O_{ij}$ and expected $E_{ij}$ values as:  
$\chi^2=\sum_{i=1}^{m}\sum_{j=1}^{k}\frac{(O_{ij}-E_{ij})^2}{E_{ij}}$ where $m$ is the number of rows and $k$ is the number of columns. 
The $\chi^2$-distribution has 1 parameter, the degrees of freedom $v$ = $(m-1)(k-1)$.

<img src="02-prerequisites_files/figure-html/unnamed-chunk-41-1.png" width="672" />

R is calculating the $\chi^2$ value for specific cross-tables, and it is also giving the p-values, i.e., the probability of obtaining the observed or a higher $\chi^2$ value given the nullhypothesis is true by comparing the observed $\chi^2$ with the corresponding chisquare distribution.


```r
chisq.test(table(dat$birthday, dat$car))
```

```
## 
## 	Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  table(dat$birthday, dat$car)
## X-squared = 0.85312, df = 1, p-value = 0.3557
```

The warning (that is suppressed in the rmarkdown version, but that you will see if you run the code on your own computer) is given, because in our example some cells have counts less than 5. In such cases, the Fisher's exact test should be preferred. This test calculates the p-value analytically using probability theory, whereas the chisquare test relies on the assumption that the  $\chi^2$ value follows a chisquare distribution. The latter assumption holds better for larger sample sizes.


```r
fisher.test(table(dat$birthday, dat$car))
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  table(dat$birthday, dat$car)
## p-value = 0.2657
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##    0.3369761 391.2320030
## sample estimates:
## odds ratio 
##   5.699654
```

 

## Bayesian way of analysing correlations between categorical variables
For a Bayesian analysis of cross-table data, a data model has to be found. There are several possibilities that could be used:  

* a so-called log-linear model (Poisson model) for the counts in each cell of the cross-table.  
* a binomial or a multinomial model for obtaining estimates of the proportions of data in each cell

These models provide possibilities to explore the patterns in the data in more details than a chisquare test. 





```r
# log-linear model
mod <- glm(count~birthday+car + birthday:car, 
           data=datagg, family=poisson)
bsim <- sim(mod, n.sim=nsim)
round(t(apply(bsim@coef, 2, quantile, 
              prob=c(0.025, 0.5, 0.975))),2)
```

```
##                    2.5%   50% 97.5%
## (Intercept)        0.74  1.61  2.47
## birthdaywine      -1.91 -0.50  0.90
## carY              -3.71 -1.62  0.52
## birthdaywine:carY -0.67  1.88  4.40
```
The interaction parameter measures the strength of the correlation. To quantitatively understand what a parameter value of 1.90 means, we have to look at the interpretation of all parameter values. We do that here quickly without a thorough explanation, because we already explained the Poisson model in chapter 8 of [@KornerNievergelt2015].

The intercept 1.61 corresponds to the logarithm of the count in the cell "flowers" and "N" (number of students who prefer flowers as a birthday present and who do not have a car), i.e., $exp(\beta_0)$ = 5.00. The exponent of the second parameter corresponds to the multiplicative difference between the counts in the cells "flowers and N" and "wine and N", i.e., count in the cell "wine and N" = $exp(\beta_0)exp(\beta_1)$ = exp(1.61)exp(-0.51) = 3.00. The third parameter measures the multiplicative difference in the counts between the cells "flowers and N" and "flowers and Y", i.e., count in the cell "flowers and Y" = $exp(\beta_0)exp(\beta_2)$ = exp(1.61)exp(-1.61) = 1.00. Thus, the third parameter is the difference in the logarithm of the counts between the car owners and the car-free students for those who prefer flowers. The interaction parameter is the difference of this difference between the students who prefer wine and those who prefer flowers. This is difficult to intuitively understand. Here is another try to formulate it: The interaction parameter measures the difference in the logarithm of the counts in the cross-table between the row-differences between the columns. Maybe it becomes clear, when we extract the count in the cell "wine and Y" from the model parameters: $exp(\beta_0)exp(\beta_1)exp(\beta_2)exp(\beta_3)$ = exp(1.61)exp(-0.51)exp(-1.61)exp(1.90) = 4.00.  


Alternatively, we could estimate the proportions of flower and wine preferers within each group of car owners and car-free students using a binomial model. For an explanation of the binomial model, see chapter 8 of [@KornerNievergelt2015].


```r
# binomial model
tab <- table(dat$car,dat$birthday)
mod <- glm(tab~rownames(tab),  family=binomial)
bsim <- sim(mod, n.sim=nsim)
```

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-47-1.png" alt="Estimated proportion of students that prefer flowers over wine as a birthday present among the car-free students (N) and the car owners (Y). Given are the median of the posterior distribution (circle). The bar extends between the 2.5% and 97.5% quantiles of the posterior distribution." width="768" />
<p class="caption">(\#fig:unnamed-chunk-47)Estimated proportion of students that prefer flowers over wine as a birthday present among the car-free students (N) and the car owners (Y). Given are the median of the posterior distribution (circle). The bar extends between the 2.5% and 97.5% quantiles of the posterior distribution.</p>
</div>



## Summary
Bayesian data analysis = applying the Bayes theorem for summarising knowledge based on data, priors and the model assumptions.  

Frequentist statistics = quantifying uncertainty by hypothetical repetitions  

