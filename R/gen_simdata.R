#' Generate simulated data set matching the format of the data set used for training the cord blood lead prediction model
#'
#' @param N Integer specifying the number of simulated observations (`default=200`).
#' @param covars Boolean specifying wether covariates should be simulated as well (`default=TRUE`)
#' @param seed Integer specifying seed value for reproducibility.
#'
#' @return This function returns a `data.frame` containing simulated dentine lead levels and covariates (if applicable).
#'
#' @author Hachem Saddiki
#'
#' @import stats
#'
#' @export
gen_simdata <- function(N=200, covars=TRUE, seed=9987){

  # generate child dentine lead levels 17 weeks around birth
  pbs = matrix(stats::rnorm(n=N*17, mean=0, sd=3), nrow=N, ncol=17)
  colnames(pbs) <- c(paste0('Pb208.log_',8:1), paste0('Pb208.log',0:8))

  # generate covariate, if applicable
  if(covars){
    covs <- cbind(stats::rbinom(N,1,0.5),
                  stats::rnorm(N,28,3),
                  stats::rbinom(N,1,0.3),
                  stats::rbinom(N,1,0.4),
                  stats::rbinom(N,1,0.1))
    colnames(covs) <- c('infant_sex','mother_age','second_hand_smoke',
                        'SES_medium', 'SES_high')
    simdat <- as.data.frame(cbind(pbs,covs))
  } else{
    simdat <- as.data.frame(pbs)
  }

  # return data frame of simulated data set
  return(simdat)
}
