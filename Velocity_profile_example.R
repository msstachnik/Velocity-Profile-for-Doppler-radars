## Velocity profile exampe
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")

vp = VP_sample(10, 0, 3, 5)
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
# Definitions:
init_coefs = list(Vx = model_ols$Vx, Vy = model_ols$Vy)
formula_onls = rr_sample ~ Vx * cos(az_sample) + Vy * sin(az_sample) + 0;

model_onls = onls::onls(formula_onls, vp, start = init_coefs)
model_onls

