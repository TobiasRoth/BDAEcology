data{
  int<lower=0> ncol;
  int<lower=0> nrow;
  int<lower=0> y[nrow, ncol];
}

parameters{
  simplex[ncol] p; // a vector of length nrow of simplex 
                           //with ncol+1 numbers that sum to one
}


model {

    // Likelihood 
    for (i in 1:nrow){
      y[i] ~ multinomial(p);  // no need for N, stan make sum automatically
      // could we write y~multinomial(p) instead of the loop?
      } 
}   
