#' Main function to predict cord blood lead levels from weekly child dentine lead levels (17 weeks around birth).
#'
#' The data set should be specified in wide format, with each column representing 1 of 17 weekly dentine lead levels in \bold{log2} scale. \cr
#' \itemize{
#' \item The columns for measurements corresponding to 8 weeks up to 1 week before birth should be labelled \bold{b208.log_8} to \bold{Pb208.log_1}.
#' \item The column for birth week should be labelled \bold{Pb208.log0}.
#' \item The columns corresponding to 1 week up to 8 weeks after birth should be labelled \bold{Pb208.log1} to \bold{Pb208.log8}.
#' }
#'
#' @param pb_data \code{data.frame} containing weekly \bold{log2}-transformed child dentine lead measurements (17 weeks around birth in wide format).
#' @param covars \code{data.frame} of (optional) covariates that can be included in the model. These can only be: \bold{infant_sex} (binary), \bold{mother_age} (continuous), \bold{second_hand_smoke} (binary), \bold{SES_medium} (binary), and \bold{SES_high} (binary).
#'
#' @return This function returns a numeric \code{vector} containing predictions of cord blood lead concentrations in \bold{log2} scale.
#'
#' @author Hachem Saddiki
#'
#' @import xgboost
#'
#' @export
pred_17wk_cbpb <- function(pb_data, covars=NULL){

  # assert column names match correct order
  if(!all.equal(colnames(pb_data), c(paste0('Pb208.log_',8:1),
                                     paste0('Pb208.log',0:8)))){
    print('Column names of `pb_data` do not match the correct order and/or format. Please check help function `?pred_17wk`.')
    return(NULL)
  }

  # check for missing lead measurements and impute if any
  if(anyNA(pb_data)){
    pb_data <- impute_pb_traj(pb_data)
  }

  # assert covariates match correct order
  if(!is.null(covars)){
    if(!all.equal(colnames(covars), c('infant_sex','mother_age',
                                      'second_hand_smoke',
                                      'SES_medium', 'SES_high'))){
      print('Column names of `covars` do not match the correct order and/or format. Please check help function `?pred_17wk`.')
      return(NULL)
    } else{
      # load xgboost model with
      mod_path <- system.file("extdata","xgb_17wk_covmod.model", package="leadpred")
      xgbmod <- xgboost::xgb.load(mod_path)

      # predict on new data
      xgmat_new <- xgb.DMatrix(data = as.matrix(cbind(pb_data, covars)))
      predictions <- predict(xgbmod, xgmat_new)
    }
  } else{
    # no covariates specified, load xgboost model trained without covariates
    mod_path <- system.file("extdata","xgb_17wk_nocovmod.model", package="leadpred")
    xgbmod <- xgboost::xgb.load(mod_path)

    # predict on new data
    xgmat_new <- xgb.DMatrix(data = as.matrix(pb_data))
    predictions <- predict(xgbmod, xgmat_new)
  }
  return(predictions)
}


