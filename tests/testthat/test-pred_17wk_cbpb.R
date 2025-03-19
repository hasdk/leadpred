## Test prediction function on simulated 17week dentine data with covariates

# generate simulated 17week dentine data with covariates
N=200 # sample size
simdat <- gen_simdata(N=N, covars = TRUE, seed=598)

# predict cord blood levels from simulated data with covariates
preds_cov <- pred_17wk_cbpb(pb_data=simdat[,1:17], covars = simdat[,18:22])

# predict cord blood levels from simulated data without covariates
preds_nocov <- pred_17wk_cbpb(pb_data=simdat[,1:17])

# inject NAs and predict with missing dentine lead data
simdat[1:(floor(N/2)),1:10] <- NA
preds_imp <- pred_17wk_cbpb(pb_data=simdat[,1:17])

# check for finite predictions across samples
test_that("Finite predictions computed across samples.", {
  expect_equal(c(sum(is.finite(preds_cov)),
                 sum(is.finite(preds_cov)),
                 sum(is.finite(preds_cov))), c(N,N,N))
})
