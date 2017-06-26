# Accumulation fit data

load('vp_list.RData')
v1 = vp_out;
load('orth_nonlin_ls_fit.RData')
v2 = vp_out;
vp_out = rbind.data.frame(v1, v2)

save(vp_out, file = "fit_accumulated.RData")