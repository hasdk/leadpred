# R/leadpred
R package implementing methods for predicting cord blood lead levels from child dentine lead measures. The package also provides methods for imputing missing values of dentine lead measures. Details about the data set and the XGBoost model used for training and validation can be found in the reference paper. 
The current version of the package contains one core function:
  - `pred_17wk_cbpb()`: generates cord blood lead predictions from a pre-trained XGBoost model that takes as input 17-week child dentine lead levels data around birth, in addition to (optional) covariates: infant sex, maternal age, exposure to second hand smoking, and socio-economic status. 

# Installation 
Install the most recent version of `leadpred` from GitHub via the `remotes` package.
<code>
library(remotes)
remotes::install_github('hasdk/leadpred')
</code>

# Example from Simulated Data

- Generate `n=200` simulated child dentine lead levels for 17 weeks (8 weeks before birth to 8 weeks after birth), in addition to simulated covariates.
  
`simdat = leadpred::gen_simdata(N=200, covars=TRUE)`

- Predict cord blood lead levels from simulated data with covariates.
  
`preds_cov = leadpred::pred_17wk_cbpb(pb_data=simdat[,1:17], covars=simdat[,18:22])`

- Predict cord blood lead levels from simulated data without covariates.
  
`preds_nocov = leadpred::pred_17wk_cbpb(pb_data=simdat[,1:17])`

- Predict cord blood lead levels from simulated data with missing values for child dentine lead levels (imputation is automatically performed using the 'copy mean' method as described in the reference paper).
  
`simdat[1:(floor(nrow(simdat)/2)),1:10] <- NA`

`preds_imp = leadpred::pred_17wk_cbpb(pb_data=simdat[,1:17])`

# References
Mainetti M, Saddiki H, India-aldana S, Tellez-Rojo MM, Wright RO, Arora M, Colicino E. "Dentine-derived lead exposure biomarker at birth: an estimation of cord blood concentrations through micro-spatial weekly child dentine lead measures". 
