# Ordinary Least Squeared Regresion of Velocity Profile
rm(list = ls())
base::source("utilities.R")
base::source("ls_functions.R")
load('vp_list.RData')

# Run Ols for whole dataset
vp_out_l = base::sapply(vp_list, ols, simplify = FALSE);

# Get reduced data frame form vp_list
vp_ref = list2df(base::sapply(vp_list, VP_ref, simplify = FALSE));

# collect needed data to data frame
vp_out = list2df(vp_out_l);
vp_out$mag = hypot(as.numeric(vp_out$Vx), as.numeric(vp_out$Vy));
vp_out$heading = base::atan2(as.numeric(vp_out$Vy), as.numeric(vp_out$Vx));
vp_out$heading_deg = rad2deg(as.numeric(vp_out$heading));
vp_out = cbind(vp_out, vp_ref);

# Calculate errors / deviations
vp_out$Vx_dev = as.numeric(vp_out$Vx_ref) - as.numeric(vp_out$Vx);
vp_out$Vy_dev = as.numeric(vp_out$Vy_ref) - as.numeric(vp_out$Vy);
vp_out$mag_dev = as.numeric(vp_out$mag_ref) - as.numeric(vp_out$mag);
vp_out$heading_dev = angle_diff(deg2rad(as.numeric(vp_out$heading_ref)), as.numeric(vp_out$heading));
vp_out$heading_dev_deg = rad2deg(as.numeric(vp_out$heading_dev));

# Add labels
vp_out$n_samples_label = cut(vp_out$n_samples, breaks = c(-1, 2.5, 5, 15, 100), 
                           labels = c("two", "low", "medium", "high"));
vp_out$mag_ref_label = cut(vp_out$mag_ref, breaks = c(-1, 1, 5, 15, 100), 
                           labels = c("zero", "low", "medium", "high"));
vp_out$az_spread_ref_label = cut(vp_out$az_spread_ref, breaks = c(-1, 4, 10, 30, 200), 
                                      labels = c("very low", "low", "medium", "high"));

save(vp_out, file = "ols_fit.RData")

