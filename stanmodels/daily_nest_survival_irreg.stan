data {
  int<lower=0> Nnests;                // number of nests
  int<lower=0> lastlive[Nnests];      // day of last observation (alive)
  int<lower=0> lastcheck[Nnests];       // day of observed death or, if alive, last day of study 
  int<lower=0> first[Nnests];         // day of first observation (alive or dead)
  int<lower=0> maxage;                // maximum of last
  real cover[Nnests];                 // a covariate of the nest
  real age[maxage];                   // a covariate of the date
  int<lower=0> gap[Nnests];           // obsdead - lastlive
}

parameters {
  vector[3] b;                          // coef of linear pred for S
}

model {
  real S[Nnests, maxage-1];             // survival probability
                
  for(i in 1:Nnests){  
    for(t in first[i]:(lastcheck[i]-1)){ 
      S[i,t] = inv_logit(b[1] + b[2]*cover[i] + b[3]*age[t]); 
    }
  }

  // priors
  b[1]~normal(0,1.5);
  b[2]~normal(0,3);
  b[3]~normal(0,3);  

  // likelihood
  for (i in 1:Nnests) {
    for(t in (first[i]+1):lastlive[i]){
      1~bernoulli(S[i,t-1]);
    }
    if(gap[i]==1){
      target += log(1-S[i,lastlive[i]]);  // 
    }
    if(gap[i]==2){
      target += log((1-S[i,lastlive[i]]) + S[i,lastlive[i]]*(1-S[i,lastlive[i]+1]));  // 
    }
    if(gap[i]==3){
      target += log((1-S[i,lastlive[i]]) + S[i,lastlive[i]]*(1-S[i,lastlive[i]+1]) +
                    prod(S[i,lastlive[i]:(lastlive[i]+1)])*(1-S[i,lastlive[i]+2]));  // 
    }
    if(gap[i]==4){
      target += log((1-S[i,lastlive[i]]) + S[i,lastlive[i]]*(1-S[i,lastlive[i]+1]) +
                    prod(S[i,lastlive[i]:(lastlive[i]+1)])*(1-S[i,lastlive[i]+2]) +
                    prod(S[i,lastlive[i]:(lastlive[i]+2)])*(1-S[i,lastlive[i]+3]));  // 
    }

  }
}
