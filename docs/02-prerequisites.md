
# Prerequisites and Vocabulary {#prerequisites}


## SOFTWARE
In most chapters of this book we work with the statistical software R (R Core Team, 2014). R is a very powerful tool for statistics and graphics in general. However, it is limited with regard to Bayesian methods applied to more complex models. In Part II of the book (Chapters 12e15), we therefore use Open BUGS (www.openbugs.net; Spiegelhalter et al., 2007) and Stan (Stan Development Team, 2014), using specific interfaces to operate them from within R. OpenBUGS and Stan are introduced in Chapter 12. Here, we briefly introduce R.

### What Is R?
R is a software environment for statistics and graphics that is free in two ways: free to download and free source code (www.r-project.org). The first version of R was written by Robert Gentleman and Ross Ihaka of the University of Auckland (note that both names begin with “R”). Since 1997, R has been governed by a core group of R contributors (www.r-project.org/contributors. html). R is a descendant of the commercial S language and environment that was developed at Bell Laboratories by John Chambers and colleagues. Most code written for S runs in R, too. It is an asset of R that, along with statistical analyses, well-designed publication-quality graphics can be pro- duced. R runs on all operating systems (UNIX, Linux, Mac, Windows).

R is different from many statistical software packages that work with menus. R is a programming language or, in fact, a programming environment. This means that we need to write down our commands in the form of R code. While this may need a bit of effort in the beginning, we will soon be able to reap the first fruits. Writing code enforces us to know what we are doing and why we are doing it, and enables us to learn about statistics and the R language rapidly. And because we save the R code of our analyses, they are easily reproduced, comprehensible for colleagues (especially if the code is furnished with comments), or easily adapted and extended to a similar new analysis. Due to its flexibility, R also allows us to write our own functions and to make them available for other users by sharing R code or, even better, by compiling them in an R package. R packages are extensions of the slim basic R distribution, which is supplied with only about eight packages, and typically contain R functions and sometimes also data sets. A steadily increasing number of packages are available from the network of CRAN mirror sites (currently over 5000), accessible at www.r-project.org.

Compared to other dynamic, high-level programming languages such as Python (www.python.org) or Julia (Bezanson et al., 2012; www.julialang.org), R will need more time for complex computations on large data sets. However, the aim of R is to provide an intuitive, “easy to use” programming language for data analyses for those who are not computer specialists (Chambers, 2008), thereby trading off computing power and sometimes also precision of the code. For example, R is quite flexible regarding the use of spaces in the code, which is convenient for the user. In contrast, Python and Julia require a stricter coding, which makes the code more precise but also more difficult to learn. Thus, we consider R as the ideal language for many statistical problems faced by ecologists and many other scientists.

### Working with R
If you are completely new to R, we recommend that you take an introductory course or work through an introductory book or document (see recommen- dations in the Further Reading section at the end of this chapter). R is orga- nized around functions, that is, defined commands that typically require inputs (arguments) and return an output. In what follows, we will explain some important R functions used in this book, without providing a full introduction to R. Moreover, the list of functions explained in this chapter is only a selection and we will come across many other functions in this book. That said, what follows should suffice to give you a jumpstart.

We can easily install additional packages by using the function `install.packages` and load packages by using the function `library`.

Each R function has documentation describing what the function does and how it is used. If the package containing a function is loaded in the current R session, we can open the documentation using `?`. Typing `?mean` into the R console will open the documentation for the function mean (arithmetic mean). If we are looking for a specific function, we can use the function `help.search` to search for functions within all installed packages. Typing `help. search("linear model")`, will open a list of functions dealing with linear models (together with the package containing them). For example, `stats::lm` suggests the function lm from the package stats. Shorter, but equivalent to `help.search("linear model")` is `??"linear model"`. Alternatively, R’s online documentation can also be accessed with `help.start()`. Functions/packages that are not installed yet can be found using the specific search menu on www.r-project.org. Once familiar with using the R help and searching the internet efficiently for R-related topics, we can independently broaden our knowledge about R.

Note that whenever we show R code in this book, the code is printed in `this font`. Comments, which are preceded by a hash sign, #, and are therefore not executed by R, are printed in gray R output is printed in blue font.


## IMPORTANT STATISTICAL TERMS AND HOW TO HANDLE THEM IN R

### Data Sets, Variables, and Observations
Data are always collected on a sample of objects (e.g., animals, plants, or plots). An observation refers to the smallest observational or experimental unit. In fact, this can also be a smaller unit, such as the wing of a bird, a leaf of a plant, or a subplot. Data are collected with regard to certain characteristics (e.g., age, sex, size, weight, level of blood parameters), all of which are called variables. A collection of data, a so-called “data set,” can consist of one or many variables. The term *variable* illustrates that these characteristics vary between the observations.

Variables can be classified in several ways, for instance, by the scale of measurement. We distinguish between nominal, ordinal, and numeric variables (see \@ref(tab:scales)). Nominal and ordinal variables can be summarized as cate- gorical variables. Numeric variables can be further classified as discrete or continuous. Moreover, note that categorical variables are often called factors and numeric variables are often called covariates.

Table: (\#tab:scales) Scales of Measurement 

Scale   | Examples                 | Properties      | Typical coding in R | 
:-------|:------------------------:|:---------------:|:-------------------:|
Nominal | Sex, genotype, habitat   | Identity (values have a unique meaning) | `factor()` |
Ordinal | Altitudinal zones (e.g., foothill, montane, subalpine, alpine zone) | Identity and magnitude (values have an ordered relationship, some values are larger and some are smaller) | `ordered()` |
Numeric | Discrete: counts; continuous: body weight, wing length, speed | Identity, magnitude, and equal intervals (units along the scale are equal to each other) and possibly a minimum value of zero (ratios are interpretable) | `intgeger()`; numeric() |

Now let us look at ways to store and handle data in R. A simple, but probably the most important, data structure is a vector. It is a collection of ordered elements of the same type. We can use the function c to combine these elements, which are automatically coerced to a common type. The type of elements determines the type of the vector. Vectors can (among other things) be used to represent variables. Here are some examples:


```r
v1 <- c(1,4,2,8)
v2 <- c("bird","bat","frog","bear")
v3 <- c(1,4,"bird","bat")
```

R is an object-oriented language and vectors are specific types of objects. The class of objects can be obtained by the function class. A vector of numbers (e.g., v1) is a numeric vector (corresponding to a numeric variable); a vector of words (v2) is a character vector (corresponding to a categorical variable). If we mix numbers and words (v3), we will get a character vector.


```r
class(v1)
```

```
## [1] "numeric"
```

```r
class(v2)
```

```
## [1] "character"
```

```r
class(v3)
```

```
## [1] "character"
```

The function `rev can be used to reverse the order of elements.


```r
rev(v1)
```

```
## [1] 8 2 4 1
```

Numeric vectors can be used in arithmetic expressions, using the usual arithmetic operators `+`, `-`, `*`, and `/`, including `ˆ` for raising to a power. The operations are performed element by element. In addition, all of the common arithmetic functions are available (e.g., `log` and `sqrt` for the logarithm and the square root). To generate a sequence of numbers, R offers several possibilities. A simple one is the colon operator: `1:30` will produce the sequence 1, 2, 3, ..., 30. The function seq is more general: `seq(5, 100, by = 5)` will produce the sequence 5, 10, 15, ..., 100.

R also knows logical vectors, which can have the values TRUE or FALSE. We can generate them using conditions defined by the logical operators `<`, `<=`, `>`, `>=` (less than, less than or equal to, greater than, greater than or equal to), `==` (exact equality), and `!= (inequality)`. The vector will contain TRUE where the condition is met and FALSE if not. We can further use `&` (inter- section, logical "and""), `|` (union, logical "or"), and `!` (negation, logical "not") to combine logical expressions. When logical vectors are used in arithmetic expressions, they are coerced to numeric with FALSE becoming 0 and TRUE becoming 1.

Categorical variables should be coded as factors, using the function `factor` or `as.factor`. Thereby, the levels of the factor can be coded with characters or with numbers (but the former is often more informative). Ordered categorical variables can be coded as ordered factors by using `factor(..., ordered = TRUE)` or the function `ordered`. Other types of vectors include "Date" for date and time variables and "complex"" for complex numbers (not used in this book).

Instead of storing variables as individual vectors, we can combine them into a data frame, using the function `data.frame. The function produces an object of the class "data.frame", which is the most fundamental data structure used for statistical modeling in R. Different types of variables are allowed within a single data frame. Note that most data sets provided in the package blmeco, which accompanies this book, are data frames.

Data are often entered and stored in spreadsheet files, such as those produced by Excel or LibreOffice. To work with such data in R, we need to read them into R. This can be done by the function read.table (and its descendants), which reads in data having various file formats (e.g., comma- or tab-delimited text) and generates a data frame object. It is very important to consider the specific structure of a data frame and to use the same layout in the original spreadsheet: a data frame is a data table with observations in rows and variables in columns. The first row contains the header, which contains the names of the variables. This format is standard practice and should be compatible with all other statistical soft- ware packages, too.

Now we combine the vectors v1, v2, and v3 created earlier to a data frame called "dat"" and print the result by typing the name of the data frame:


```r
dat <- data.frame(v1, v2, v3)
dat
```

```
##   v1   v2   v3
## 1  1 bird    1
## 2  4  bat    4
## 3  2 frog bird
## 4  8 bear  bat
```

```r
dat <- data.frame(number = v1, animal = v2, mix = v3)
dat
```

```
##   number animal  mix
## 1      1   bird    1
## 2      4    bat    4
## 3      2   frog bird
## 4      8   bear  bat
```


By default, the names of the vectors are taken as variable names in dat, but we can also give them new names. A useful function to quickly generate a data frame in some situations (e.g., if we have several categorical variables that we want to combine in a full factorial manner) is `expand.grid. We supply a number of vectors (variables) and expand.grid creates a data frame with a row for every combination of elements of the supplied vectors, the first variables varying fastest. For example:


```r
dat2 <- expand.grid(number = v1, animal = v2)
dat2
```

```
##    number animal
## 1       1   bird
## 2       4   bird
## 3       2   bird
## 4       8   bird
## 5       1    bat
## 6       4    bat
## 7       2    bat
## 8       8    bat
## 9       1   frog
## 10      4   frog
## 11      2   frog
## 12      8   frog
## 13      1   bear
## 14      4   bear
## 15      2   bear
## 16      8   bear
```

Using square brackets allows for selecting parts of a vector or data frame, for example,

```r
v1[v1 > 3]
```

```
## [1] 4 8
```

```r
dat2[dat2$animal == "bat",]
```

```
##   number animal
## 5      1    bat
## 6      4    bat
## 7      2    bat
## 8      8    bat
```

Because `dat2 has two dimensions (rows and columns), we need to provide a selection for each dimension, separated by a comma. Because we want all values along the second dimension (all columns), we do not provide anything after the comma (thereby selecting "all there is").

Now let us have a closer look at the data set "cortbowl" from the package blmeco to better understand the structure of data frame objects and to un- derstand the connection between scale of measurement and the coding of variables in R. We first need to load the package blmeco and then the data set. The function `head is convenient to look at the first six observations of the data frame.



```r
library(blmeco)                            # load the package
data(cortbowl)                             # load the data set
head(cortbowl)                             # show first six observations
```

```
##   Brood   Ring Implant Age   days totCort
## 1   301 898331       P  49     20   5.761
## 2   301 898332       P  29      2   8.418
## 3   301 898332       P  47     20   8.047
## 4   301 898333       C  25      2  25.744
## 5   302 898185       P  57     20   8.041
## 6   302 898188       C  28 before   6.338
```

The data frame cortbowl contains data on 151 nestlings of barn owls *Tyto alba* (identifiable by the variable Ring) of varying age from 54 broods. Each nestling either received a corticosterone implant or a placebo implant (variable Implant with levels C and P). Corticosterone levels (variable totCort) were determined from blood samples taken just before implantation, or 2 or 20 days after implantation (variable days). Each observation (row) refers to one nestling measured on a particular day. Because multiple measurements were taken per nestling and multiple nestlings may belong to the same brood, cortbowl is an example of a hierarchical data set (see \@ref(lmm)). The function `str shows the structure of the data frame (of objects in general).



```r
str(cortbowl)                              # show the structure of the data.frame
```

```
## 'data.frame':	287 obs. of  6 variables:
##  $ Brood  : Factor w/ 54 levels "231","232","233",..: 7 7 7 7 8 8 9 9 10 10 ...
##  $ Ring   : Factor w/ 151 levels "898054","898055",..: 44 45 45 46 31 32 9 9 18 19 ...
##  $ Implant: Factor w/ 2 levels "C","P": 2 2 2 1 2 1 1 1 2 1 ...
##  $ Age    : int  49 29 47 25 57 28 35 53 35 31 ...
##  $ days   : Factor w/ 3 levels "2","20","before": 2 1 2 1 2 3 1 2 1 1 ...
##  $ totCort: num  5.76 8.42 8.05 25.74 8.04 ...
```

`str` returns the number of observations (287 in our example) and variables (6), the names and the coding of variables. Note that not all nestlings could be measured on each day, so the data set only contains 287 rows (instead of 151 nestlings   3 days 1⁄4 453). Brood, Ring, and Implant are nominal categorical variables, although numbers are used to name the levels of Brood and Ring. While character vectors such as Implant are by default transformed to factors by the functions `data.frame` and `read.table`, numeric vectors are kept numeric. Thus, if a categorical variable is coded with numbers (as are Brood and Ring), it must be explicitly transformed to a factor using the functions `factor` or `as.factor. Coding as factor ensures that, when used for modeling, these variables are recognized as nominal. However, using words rather than numbers to code factors is good practice to avoid erroneously treating a factor as a numeric variable. The variable days is also coded as factor (with levels “before”, “2”, and “20”). Age is coded as an integer with only whole years recorded, although age is clearly continuous rather than discrete in nature. Counts would be a more typical case of a discrete variable (see Chapter 8). The variable totCort is a continuous numeric variable. Special types of categorical variables are binary variables, with only two categories (e.g., implant and sex, with variables coded as no/yes or 0/1).

We often have to choose whether we treat a variable as a factor or as numeric: for example, we may want to use the variable days as a nominal variable if we are mainly interested in differences (e.g., in totCort) between the day before the implantation, day 2, and day 20 after implantation. If we had measured totCort on more than three days, it may be more interesting to use the variable days as numeric (replacing “before” by day 1), to be able to look at the temporal course of totCort.

### Distributions and Summary Statistics

The values of a variable typically vary. This means they exhibit a certain distribution. Histograms provide a graphical tool to display the shape of distributions. Summary statistics inform us about the distribution of observed values in a sample and allow communication of a lot of information in a few numbers. A statistic is a sample property, that is, it can be calculated from the observations in the sample. In contrast, a parameter is a property of the population from which the sample was taken. As parameters are usually unknown (unless we simulate data from a known distribution), we use sta- tistics to estimate them. Table 2-2 gives an overview of some statistics, given a sample x of size n, ${x_1, x_2, x_3, ., x_n}$, ordered with $x_1$ being the smallest and $x_n$ being the largest value, including the corresponding R function (note that the ordering of x is only important for the median).

There are different measures of location of a distribution, that is, the value around which most values scatter, and measures of dispersion that describe the spread of the distribution. The most important measure of location is the arithmetic mean (or average). It describes the “center” of symmetric distri- butions (such as the normal distribution). However, it has the disadvantage of being sensitive to extreme values. The median is an alternative measure of location that is generally more appropriate in the case of asymmetric distri- butions; it is not sensitive to extreme values. The median is the central value of the ordered sample (the formula is given in Table 2-2). If n is even, it is the arithmetic mean of the two most central values.

> ADD TABLE 2.2

The spread of a distribution can be measured by the variance or the standard deviation. The variance of a sample is the sum of the squared deviations from the sample mean over all observations, divided by (n   1). The variance is hard to interpret, as it is usually quite a large number (due to squaring). The standard deviation (SD), which is the square root of the variance, is easier. It is approximately the average deviation of an observation from the sample mean. In the case of a normal distribution, about two thirds of the data are expected within one standard deviation around the mean.

Quantiles inform us about both location and spread of a distribution. The p-quantile is the value x with the property that a proportion p of all values are less than or equal to x. The median is the 50% quantile. The 25% quantile and the 75% quantile are also called the lower and upper quartiles, respectively. The range between the 25% and the 75% quartile is called the interquartile range. This range includes 50% of the distribution and is also used as a measure of dispersion. The R function quantile extracts sample quantiles. The median, the quartiles, and the interquartile range can be graphically displayed using box-and-whisker plots (boxplots for short).

When we use statistical models, we need to make reasonable assump- tions about the distribution of the variable we aim to explain (outcome or response variable). Statistical models, of which a variety is dealt with in this book, are based on certain parametric distributions. “Parametric” means that these distributions are fully described by a few parameters. The most important parametric distribution used for statistical modeling is the normal distribution, also known as the Gaussian distribution. The Gaussian distribution is introduced more technically in Chapter 5. Qualitatively, it describes, at least approximately, the distribution of observations of any (continuous) variable that tends to cluster around the mean. The impor- tance of the normal distribution is a consequence of the central limit theorem. Without going into detail about this, the practical implications are as follows:

- The sample mean of any sample of random variables (also if these are themselves not normally distributed), tends to have a normal distribution. The larger the sample size, the better the approximation.

- The binomial distribution and the Poisson (Chapter 8) distribution can be approximated by the normal distribution under some circumstances.

- Any variable that is the result of a combination of a large number of small effects (such as phenotypic characteristics that are determined by many genes) tends to show a bell-shaped distribution. This justifies the common use of the normal distribution to describe such data.

- For the same reason, the normal distribution can be used to describe error variation (residual variance) in linear models. In practice, the error is often the sum of many unobserved processes.

If we have a sample of n observations that are normally distributed with
mean m and standard deviation s, then it is known that the arithmetic mean x
 of the sample is normally distributed around m with standard deviation pffiffi
SDx 1⁄4 s= n. In practice, however, we do not know s, but estimate it by the
 sample standard deviation s. Thus, the standard deviation of the sample mean
is estimated by the “standard error of the mean” (SEM), which is calculated as
pffiffi
SEM 1⁄4 s= n. While the standard deviation s ð1⁄4 bsÞ describes the variability
of individual observations (Table 2-2), SEM describes the uncertainty about pffiffi
the sample mean as an estimate for m. Due to the division by n, SEM is smaller for large samples and larger for small samples.

We may wonder about the division by (n   1) in the formula for the sample variance in Table 2-2. This is due to the infamous “degrees of freedom” issue. A quick explanation why we divide by (n   1) instead of n is that we need x, an estimate of the sample mean, to calculate the variance. Using this estimate costs us one degree of freedom, so we divide by n   1. To see why, let us assume we know that the sum of three numbers is 42. Can we tell what the three numbers are? The answer is no because we can freely choose the first and the second number. But the third number is fixed as soon as we know the first and the second: it is 42   (first number þ second number). So the degrees of freedom are 3   1 1⁄4 2 in this case, and this also applies if we know the average of the three numbers instead of their sum. Another explanation is that, because x is estimated from the sample, it is exactly in the middle of the data whereas the true population mean would be a bit off. Thus, the sum of the squared differences, Pni1⁄41 ðx   xi Þ2 is a little bit smaller than what it should be (the sum of squared differences is smallest when taken with regard to the sample mean), and dividing by (n   1) instead of n corrects for this. In general, whenever k parameters that are estimated from the data are used in a formula to estimate a new parameter, the degrees of freedom for this estimation are n   k (n being the sample size).

### More on R Objects
Most R functions are applied to one or several objects and produce one or several new objects. For example, the functions `data.frame` and `read.table` produce a data frame. Other data structures are offered by the object classes "array" and "list". 

An array is an *n*-dimensional vector. Unlike the different columns of a data frame, all elements of an array need to be of the same type. The object class “matrix” is a special case of an array, one with two dimensions. The function `sim, which we introduce in Chapter 3, returns parts of its results in the form of an array. A very useful function to do calculations based on an array (or a matrix) is `apply. We simulate a data set to illustrate this: two sites were visited over five years by each of three observers who counted the number of breeding pairs of storks. We simulate the number of pairs by using the function `rpois` to get random numbers from a Poisson distribution (Chapter 8). We can create a three-dimensional array containing the numbers of stork pairs using site, year, and observer as dimensions.


```r
Sites <- c("Site1", "Site2")
Years <- 2010:2014
Observers <- c("Ben","Sue","Emma")
set.seed(0470)
pairs <- rpois(n = 2*5*3, lambda = 10)
birds <- array(data = pairs, dim = c(2, 5, 3), dimnames = list(site = Sites, year = Years, observer = Observers))
birds
```

```
## , , observer = Ben
## 
##        year
## site    2010 2011 2012 2013 2014
##   Site1   11   11   12    9   11
##   Site2   10   10   14   15    7
## 
## , , observer = Sue
## 
##        year
## site    2010 2011 2012 2013 2014
##   Site1   14    5    9   12    5
##   Site2   16    8    9    8   10
## 
## , , observer = Emma
## 
##        year
## site    2010 2011 2012 2013 2014
##   Site1   12   19    8    8    7
##   Site2   10   13    9    8   11
```

Using `apply`, we can easily calculate the sum of pairs per observer (across all sites and years) by choosing MARGIN 1⁄4 3 (for observer) or the mean number of pairs per site and year (averaged over all observers) by choosing MARGIN 1⁄4 c(1,2) for site and year:


```r
apply(birds, MARGIN = 3, FUN = sum)
```

```
##  Ben  Sue Emma 
##  110   96  105
```

```r
apply(birds, MARGIN = c(1,2), FUN = mean)
```

```
##        year
## site        2010     2011      2012      2013     2014
##   Site1 12.33333 11.66667  9.666667  9.666667 7.666667
##   Site2 12.00000 10.33333 10.666667 10.333333 9.333333
```

Yet another and rather flexible class of object are lists. A list is a more general form of vector that can contain various elements of different types; often these are themselves lists or vectors. Lists are often used to return the results of a computation. For example, the summary of a linear model pro- duced by lm is contained in a list.

### R Functions for Graphics
R offers a variety of possibilities to produce publication-quality graphics (see recommendations in the Further Reading section at the end of this chapter). In this book we stick to the most basic graphical function plot to create graphics, to which more elements can easily be added. The `plot` function is a generic function. This means that the action performed depends on the class of arguments given to the function. We can add lines, points, segments, or text to an existing plot by using the functions `lines` or `abline`, `points`, `segments`, and `text`, respectively.

Let’s look at some simple examples using the data set cortbowl:


```r
# to divide the graphics panel in two columns and to set the margin widths
par(mfrow = c(1,2), mar = c(4,5,0.5,0), las=1) 
plot(totCort ~ Implant, data = cortbowl)
plot(totCort ~ Age, data = cortbowl[cortbowl$Implant == "P",])
points(totCort ~ Age, data = cortbowl[cortbowl$Implant == "C",], pch = 20)
```

<div class="figure">
<img src="02-prerequisites_files/figure-html/unnamed-chunk-12-1.png" alt="*Left:* Boxplot of blood corticosterone measurements (totCort) for corticosterone (C) and placebo (P) treated barn owl nestlings. Bold horizontal bar 1⁄4 median; box 1⁄4 interquartile range. The whiskers are drawn from the first or third quartile to the lowest or to the largest value within 1.5 times the interquartile range, respectively. Circles are observations beyond the whiskers. *Right:* Blood corticosterone measurements (totCort) in relation to age. Open symbols 1⁄4 placebo-treated nestlings, closed symbols 1⁄4 corticosterone-treated nestlings." width="768" />
<p class="caption">(\#fig:unnamed-chunk-12)*Left:* Boxplot of blood corticosterone measurements (totCort) for corticosterone (C) and placebo (P) treated barn owl nestlings. Bold horizontal bar 1⁄4 median; box 1⁄4 interquartile range. The whiskers are drawn from the first or third quartile to the lowest or to the largest value within 1.5 times the interquartile range, respectively. Circles are observations beyond the whiskers. *Right:* Blood corticosterone measurements (totCort) in relation to age. Open symbols 1⁄4 placebo-treated nestlings, closed symbols 1⁄4 corticosterone-treated nestlings.</p>
</div>





```r
#---------------------------------------------------------------------------------------------
#2.1.7	Writing own R functions
#---------------------------------------------------------------------------------------------
# function to calculate the standard error of the mean 
sem <- function(x) sd(x)/sqrt(length(x))

# try for example
x <- c(10,7,5,9,13,2,20,5)
sem(x)
```

```
## [1] 1.994971
```

```r
# however, if we add a missing value to the data, the function produces a missing value too
x <- c(x, NA)
sem(x)
```

```
## [1] NA
```

```r
sd(x)
```

```
## [1] NA
```

```r
# improved version
sem <- function(x) sd(x, na.rm = TRUE)/sqrt(sum(!is.na(x)))
sem(x)
```

```
## [1] 1.994971
```





