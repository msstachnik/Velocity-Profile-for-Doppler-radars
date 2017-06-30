# Ordinary Least Squeared Regresion of Velocity Profile
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")
base::source("fit_wrappers.R")
load('vp_list.RData')

# Run ODR for whole dataset
vp_out = fit_wrapper(vp_list, odr, "odr");

save(vp_out, file = "odr_ls_fit.RData")

# Run ODR for whole dataset without jacobian
odr_without_jacobian = function(vp)
{
  vp_out = odr(vp, use_jac = FALSE)
}

vp_out = fit_wrapper(vp_list, odr_without_jacobian, "odr no jac");

save(vp_out, file = "odr_without_jac_ls_fit.RData")