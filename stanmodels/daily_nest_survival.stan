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

