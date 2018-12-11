data {
  int<lower=0> Nnests;                  // number of nests
  int<lower=0> last[Nnests];            // day of last observation (alive or dead)
  int<lower=0> maxage;                  // maximum of last
  int<lower=0> y[Nnests, maxage];       // indicator of alive nests
  real x[Nnests];                       // a covariate
}

parameters {
  vector[2] b;                          // coef of linear pred for S
}

model {
  real S[Nnests, maxage-1];             // survival probability
                
  for(i in 1:Nnests){  
    for(t in 1:(last[i]-1)){ 
      S[i,t] = inv_logit(b[1] + b[2]*x[i]); 
    }
  }

  // priors
  b[1]~normal(0,5);
  b[2]~normal(0,5);

  // likelihood
  for (i in 1:Nnests) {
    for(t in 2:last[i]){
      y[i,t]~bernoulli(y[i,t-1]*S[i,t-1]);
    }
  }
}
