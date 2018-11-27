
# Data analysis step by step {#analyses_steps}

In this chapter we provide a checklist with some guidance for data analysis. However, do not expect tthe list to be complete and for different studies, a different order of the steps may make more sense. We usually repeat steps \@ref(step2) to \@ref(step7) until we find one or a set of models that fit the data well and that are realistic enough to be useful for the intended purpose. Data analysis is always a lot of work and, often, the following steps have to be repeated many times until we find a useful and robust model. 

There is a danger with this: we may find interesting results that answer different questions than we asked originally.We can report such findings, but we should state that they appeared (more or less by chance) during the data exploration and model fitting phase, and we have to be aware that the estimates may be biased because the study was not optimally designed with respect to these findings. It is important to always keep the original aim of the study in mind. Do not adjust the study question according to the data. We also recommend reporting what the model started with at the first iteration and describing the strategy and reasoning behind the model development process.

## Plausibility of Data {#step1}
Prepare the data and check graphically, or via summary statistics, whether all the data are plausible. Prepare the data so that errors (typos, etc.) are minimal, for example, by double-checking the entries. See chapter \@ref(datamanip) for useful R-code that can be used for data preparation and to make plausibility controls.

## Relationships {#step2}
Think about the direct and indirect relationships among the variables of the study. We normally start a data analysis by drawing a sketch of the model including all explanatory variables and interactions that may be biologically meaningful.We will most likely repeat this step after having looked at the model fit. To make the data analysis transparent we should report every model that was considered. A short note about why a specific model was considered and why it was discarded helps make the modeling process reproducible.

## Error Distribution  {#step3}
What is the nature of the variable of interest (outcome, dependent variable)? Chapter \@ref(distributions) give an overview of the distributions that are most relevant for ecologists.

## Preparation of Explanatory Variables  {#step4}
1. Look at the distribution (histogram) of every explanatory variable: Linear models do not assume that the explanatory variables have any specific distribution. Thus there is no need to check for a normal distribution! However, very skewed distributions result in unequal weighting of the observations in the model. In extreme cases, the slope of a regression line is defined by one or a few observations only. We also need to check whether the variance is large enough, and to think about the shape of the expected effect. The following four questions may help with this step:
l Is the variance (of the explanatory variable) big enough so that an effect of the variable can be measured?
l Is the distribution skewed? If an explanatory variable is highly skewed, it may make sense to transform the variable.
l Does it show a bimodal distribution? Consider making the variable binary.
l Is it expected that a change of 1 at lower values for x has the same biological effect as a change of 1 at higher values of x? If not, a trans- formation (e.g., log) could linearize the relationship between x and y.

2. Centering: Centering (x_centered 1⁄4 x   mean(x)) is a transformation that produces a variable with a mean of 0. With centered predictors, the intercept and main effects in the linear model are better interpretable (they are measured at the center of the data instead of at the covariate value 1⁄4 0 which may be far off; Section 4.2.6); the model fitting algorithm converges faster and better.

3. Scaling: To make the estimate of the effect sizes comparable between var- iables, the variables can be scaled, that is, x_scaled 1⁄4 x/sd(x). The unit of the scaled variable is then 1 standard deviation. Gelman and Hill (2007, p. 55 f) propose to scale the variables by two times the standard deviation (x_scaled 1⁄4 x/(2*sd(x))) to make effect sizes comparable between numeric and binary variables. Scaling can be important for model convergence, especially when polynomials are included. Consider the use of orthogonal polynomials (Section 4.2.9).

4. Collinearity:
l Look at the correlation among the explanatory variables (pairs plot or
correlation matrix).
l If the explanatory variables are correlated, go back to step 2 and see
Section 4.2.7 for more details about collinearity.

5. Are interactions and polynomial terms needed in the model? If not already
done in step 2, think about the relationship between each explanatory variable and the dependent variable.
l Is it linear or do polynomial terms have to be included in the model? If
the relationship cannot be described appropriately by polynomial terms,
think of a nonlinear model or a generalized additive model (GAM).
l May the effect of one explanatory variable depend on the value of
another explanatory variable (interaction)?

## Data Structure  {#step5}
After having taken into account all of the (fixed effect) terms from step 4: are the observations independent or grouped/structured?

## Fit the Model  {#step6}
Fit the model as described in Chapters 4, 7, 8, 9, or 14.

## Check Model {#step7}
We assess model fit by graphical analyses of the residuals (Chapter 6), by predictive model checking (Section 10.1), or by sensitivity analysis (Chapter 15). The following is a nonexhaustive list of aspects that can be looked at in a residual analysis and posterior predictive model checking. 

For non-Gaussian models it is often easier to assess model fit using pos- terior predictive checks (Chapter 10) rather than residual analyses. Posterior predictive checks usually show clearly in which aspect the model failed so we can go back to step 2 of the analysis. Recognizing in what aspect a model does not fit the data based on residual plots improves with experience. Therefore, the following table lists some patterns that can appear in residual plots together with what these patterns possibly indicate. We also indicate what could be done in the specific cases.

## Model Uncertainty  {#step8}
If, while working through steps 1 to 7, possibly repeatedly, we came up with one or more models that fit the data reasonably well, we then turn to the methods presented in Chapter 11 to draw inference from more than one model. If we have only one model, we proceed to step 9.

## Draw Conclusions  {#step9}
Simulate values from the joint posterior distribution of the model parameters (sim, BUGS, Stan). Use these samples to present parameter uncertainty, to obtain posterior distributions for predictions, probabilities of specific hypotheses, and derived quantities.

## Further reading {-}
- [R for Data Science by Garrett Grolemund and Hadley Wickham](http://r4ds.had.co.nz): Introduces the tidyverse framwork. It explains how to get data into R, get it into the most useful structure, transform it, visualise it and model it.



