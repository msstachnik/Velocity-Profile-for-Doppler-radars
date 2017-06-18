## Velocity profile exampe
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")

vp = VP_sample(10, 30, 10, 10)
vp$Vx_ref
vp$Vy_ref
plot(rad2deg(vp$az_sample),vp$rr_sample)

# Ordinary Least squered solution
model = stats::lm(vp$rr_sample ~ cos(vp$az_sample) + sin(vp$az_sample) + 0)
model

# Velocity profile ordinary solution
model_ols = ols(vp);
model_ols
