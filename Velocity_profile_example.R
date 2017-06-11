## Velocity profile exampe
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")

vp = VP_sample(10, 0, -2, 2, 10)
plot(vp$vp_sample$az_sample_deg,vp$vp_sample$rr_sample)

model = lm(vp$vp_sample$rr_sample ~ cos(vp$vp_sample$az_sample) + sin(vp$vp_sample$az_sample) + 0)
model
model_ols = ols(vp$vp_sample);
model_ols