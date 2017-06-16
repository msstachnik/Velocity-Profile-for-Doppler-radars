# Ordinary Least Squeared Regresion of Velocity Profile - Analysis 
rm(list = ls())
base::source("utilities.R")
load('ols_fit.RData')

## Analysis of 2 samples 
two_samples = base::subset(vp_out, n_samples == 2);

plot_labels_two_samples = list(xlabel = "Reference magnitude [m/s]", title = "Analysis of Velocity Profile solution for 2 samples");

ggplot_by_mag_ref_az_spread(two_samples, "mag_dev", plot_labels_two_samples, "Magnitude RMSE [m/s]")
ggplot_by_mag_ref_az_spread(two_samples, "Vx_dev", plot_labels_two_samples, "Vx RMSE [m/s]")
ggplot_by_mag_ref_az_spread(two_samples, "Vy_dev", plot_labels_two_samples, "Vy RMSE [m/s]")
ggplot_by_mag_ref_az_spread(two_samples, "heading_dev_deg", plot_labels_two_samples, "Heading RMSE [deg]")
