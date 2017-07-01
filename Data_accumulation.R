# Accumulation fit data

load('ols_fit.RData')
v1 = vp_out;
load('orth_nonlin_ls_fit.RData')
v2 = vp_out;
load('odr_ls_fit.RData')
v3 = vp_out;
load('odr_without_jac_ls_fit.RData')
v4 = vp_out;
vp_out = plyr::rbind.fill(v1, v2, v3, v4)


save(vp_out, file = "fit_accumulated.RData")