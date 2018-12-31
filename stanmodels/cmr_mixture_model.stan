data {
  int<lower=2> nocc;                    // number of capture events
  int<lower=0> nindi;                   // number of individuals with identified sex
  int<lower=0> nindni;                  // number of individuals with non-identified sex
  int<lower=0,upper=2> yi[nindi,nocc];         // CH[i,k]: individual i captured at k
  int<lower=0,upper=nocc-1> firsti[nindi];      // year of first capture
  int<lower=0,upper=2> yni[nindni,nocc];       // CH[i,k]: individual i captured at k
  int<lower=0,upper=nocc-1> firstni[nindni];    // year of first capture
  int<lower=1, upper=2> sex[nindi];
  int<lower=1, upper=2> juvi[nindi, nocc];
  int<lower=1, upper=2> juvni[nindni, nocc];
  int<lower=1> year[nocc];
  real x[nocc-1];                     // a covariate 
}

transformed data {
  int<lower=0,upper=nocc+1> lasti[nindi];       // last[i]:  ind i last capture
  int<lower=0,upper=nocc+1> lastni[nindni];       // last[i]:  ind i last capture
  lasti = rep_array(0,nindi); 
  lastni = rep_array(0,nindni);
  for (i in 1:nindi) {
    for (k in firsti[i]:nocc) {
      if (yi[i,k] == 1) {
        if (k > lasti[i])  lasti[i] = k;
      }
    }
  }
  for (ii in 1:nindni) {
    for (kk in firstni[ii]:nocc) {
      if (yni[ii,kk] == 1) {
        if (kk > lastni[ii])  lastni[ii] = kk;
      }
    }
  }

}


parameters {
  real<lower=0, upper=1> theta[nindni];            // probability of being male for non-identified individuals
  real<lower=0, upper=1> b0[2,nocc-1];             // intercept of p
  real a0[2,2];                  // intercept for phi 
  real a1[2,2];                  // coefficient for phi   
}

transformed parameters {
  real<lower=0,upper=1>p_male[nindni,nocc];         // capture probability
  real<lower=0,upper=1>p_female[nindni,nocc];       // capture probability
  real<lower=0,upper=1>p[nindi,nocc];               // capture probability

  real<lower=0,upper=1>phi_male[nindni,nocc-1];   // survival probability
  real<lower=0,upper=1>chi_male[nindni,nocc+1];   // probability that an individual 
                                                  // is never recaptured after its
                                                  // last capture
  real<lower=0,upper=1>phi_female[nindni,nocc-1]; // survival probability
  real<lower=0,upper=1>chi_female[nindni,nocc+1]; // probability that an individual 
                                                  // is never recaptured after its
                                                   // last capture
  real<lower=0,upper=1>phi[nindi,nocc-1];   // survival probability
  real<lower=0,upper=1>chi[nindi,nocc+1];   // probability that an individual 
                                           // is never recaptured after its
                                           // last capture

  {
    int k; 
    int kk; 
    for(ii in 1:nindi){
      if (firsti[ii]>1) {
        for (z in 1:(firsti[ii]-1)){
          phi[ii,z] = 1;
        }
      }
      for(tt in firsti[ii]:(nocc-1)) {
        // linear predictor for phi:
        phi[ii,tt] = inv_logit(a0[sex[ii], juvi[ii,tt]] + a1[sex[ii], juvi[ii,tt]]*x[tt]); 

      }
    }

    for(ii in 1:nindni){
      if (firstni[ii]>1) {
        for (z in 1:(firstni[ii]-1)){
          phi_female[ii,z] = 1;
          phi_male[ii,z] = 1;
        }
      }
      for(tt in firstni[ii]:(nocc-1)) {
        // linear predictor for phi:
        phi_male[ii,tt] = inv_logit(a0[1, juvni[ii,tt]] + a1[1, juvni[ii,tt]]*x[tt]); 
        phi_female[ii,tt] = inv_logit(a0[2, juvni[ii,tt]]+ a1[2, juvni[ii,tt]]*x[tt]);

      }
    }
    
    for(i in 1:nindi) {
      // linear predictor for p for identified individuals
      for(w in 1:firsti[i]){
        p[i,w] = 1;
      }
      for(kkk in (firsti[i]+1):nocc)
        p[i,kkk] = b0[sex[i],year[kkk-1]];  
      chi[i,nocc+1] = 1.0;              
      k = nocc;
      while (k > firsti[i]) {
        chi[i,k] = (1 - phi[i,k-1]) + phi[i,k-1] * (1 - p[i,k]) * chi[i,k+1]; 
        k = k - 1;
      }
      if (firsti[i]>1) {
        for (u in 1:(firsti[i]-1)){
          chi[i,u] = 0;
        }
      }
      chi[i,firsti[i]] = (1 - p[i,firsti[i]]) * chi[i,firsti[i]+1];
    }// close definition of transformed parameters for identified individuals

    for(i in 1:nindni) {
      // linear predictor for p for non-identified individuals
      for(w in 1:firstni[i]){
        p_male[i,w] = 1;
        p_female[i,w] = 1;
      }
      for(kkkk in (firstni[i]+1):nocc){
        p_male[i,kkkk] = b0[1,year[kkkk-1]];  
        p_female[i,kkkk] = b0[2,year[kkkk-1]];
      }
      chi_male[i,nocc+1] = 1.0; 
      chi_female[i,nocc+1] = 1.0; 
      k = nocc;
      while (k > firstni[i]) {
        chi_male[i,k] = (1 - phi_male[i,k-1]) + phi_male[i,k-1] * (1 - p_male[i,k]) * chi_male[i,k+1]; 
        chi_female[i,k] = (1 - phi_female[i,k-1]) + phi_female[i,k-1] * (1 - p_female[i,k]) * chi_female[i,k+1]; 
        k = k - 1;
      }
      if (firstni[i]>1) {
        for (u in 1:(firstni[i]-1)){
          chi_male[i,u] = 0;
          chi_female[i,u] = 0;
        }
      }
      chi_male[i,firstni[i]] = (1 - p_male[i,firstni[i]]) * chi_male[i,firstni[i]+1];
      chi_female[i,firstni[i]] = (1 - p_female[i,firstni[i]]) * chi_female[i,firstni[i]+1];
    } // close definition of transformed parameters for non-identified individuals

    
  }  // close block of transformed parameters exclusive parameter declarations
}    // close transformed parameters

model {
  // priors
  theta ~ beta(1, 1);
  for (g in 1:(nocc-1)){
    b0[1,g]~beta(1,1);
    b0[2,g]~beta(1,1);
  }
  a0[1,1]~normal(0,1.5);
  a0[1,2]~normal(0,1.5);
  a1[1,1]~normal(0,3);
  a1[1,2]~normal(0,3);

  a0[2,1]~normal(0,1.5);
  a0[2,2]~normal(a0[1,2],0.01); // for juveniles, we assume that the effect of the covariate is independet of sex
  a1[2,1]~normal(0,3);
  a1[2,2]~normal(a1[1,2],0.01);

  // likelihood for identified individuals
  for (i in 1:nindi) {
    if (lasti[i]>0) {
      for (k in firsti[i]:lasti[i]) {
        if(k>1) target+= (log(phi[i, k-1])); 
        if (yi[i,k] == 1) target+=(log(p[i,k]));   
        else target+=(log1m(p[i,k]));  
      }
    }  
    target+=(log(chi[i,lasti[i]+1]));
  }
  
  // likelihood for non-identified individuals
  for (i in 1:nindni) {
    real log_like_male = 0;
    real log_like_female = 0;

    if (lastni[i]>0) {
      for (k in firstni[i]:lastni[i]) {
        if(k>1){
          log_like_male += (log(phi_male[i, k-1]));
          log_like_female += (log(phi_female[i, k-1]));
        }
        if (yni[i,k] == 1){ 
          log_like_male+=(log(p_male[i,k]));
          log_like_female+=(log(p_female[i,k]));
        }
        else{
          log_like_male+=(log1m(p_male[i,k])); 
          log_like_female+=(log1m(p_female[i,k])); 
        }

      }
    }  
    log_like_male += (log(chi_male[i,lastni[i]+1]));
    log_like_female += (log(chi_female[i,lastni[i]+1]));
    
    target += log_mix(theta[i], log_like_male, log_like_female);
  }

}

