# R/leadpred
R package implementing methods for predicting cord blood lead levels from child dentine lead measures. The current version contains one core function:
  1. `pred_17wk_cbpb()`: generates cord blood lead predictions from a pre-trained XGBoost model that takes as input 17-week child dentine lead levels data around birth, in addition to (optional) covariates: infant sex, maternal age, exposure to sexond hand smoking, and socio-economic status. The package also provides methods for imputing missing values of dentine lead measures.

# Installation 
Install the most recent version of `leadpred` from GitHub via the `remotes` package:
<code>
library(remotes)
remotes::install_github('hasdk/leadpred')
</code>

