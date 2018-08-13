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
