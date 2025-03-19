#' Impute missing values of weekly child dentine lead measurement trajectories. The imputation method uses the `imputation()` method from the `longitudinalData` package.
#'
#' @param pb_data `data.frame` containing longitudinal measurements of weekly child dentine lead with missing values.
#' @param method Character describing the imputation method to be used (`default='copyMean'`). For other options, see `?longitudinalData::imputation`.
#'
#' @return This function returns a `data.frame` matching the input `pb_data` with missing values replaced with imputed ones.
#'
#' @author Hachem Saddiki
#'
#' @import longitudinalData
#'
#' @export
impute_pb_traj <- function(pb_data, method='copyMean'){

  imputed_data <- as.data.frame(longitudinalData::imputation(traj = as.matrix(pb_data),
                                                               method = "copyMean"))
  return(imputed_data)
}
