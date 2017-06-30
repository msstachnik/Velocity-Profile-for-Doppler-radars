## Velocity profile exampe
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")

vp = VP_sample(10, 90, 10, 5)
vp$Vx_ref
vp$Vy_ref
plot(rad2deg(vp$az_sample),vp$rr_sample)
formula = rr_sample ~ cos(az_sample) + sin(az_sample) + 0;
# Ordinary Least squered solution
model = stats::lm(formula, vp)
model

# Velocity profile ordinary solution
model_ols = ols(vp);
model_ols

# Ortogonal nonliner regresion

model_onls = orth_nonlin_ls(vp);
model_onls

model_odr = odr(vp);
model_odr

