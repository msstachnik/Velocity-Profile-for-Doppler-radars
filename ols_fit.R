# Ordinary Least Squeared Regresion of Velocity Profile
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")
base::source("fit_wrappers.R")
load('vp_list.RData')

# Run Ols for whole dataset
vp_out = fit_wrapper(vp_list, ols, "ols");

save(vp_out, file = "ols_fit.RData")
