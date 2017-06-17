# Ordinary Least Squeared Regresion of Velocity Profile - Analysis 
rm(list = ls())
base::source("utilities.R")
base::source("analysis_functions.R")
load('ols_fit.RData')

## Analysis of 2 samples 
two_samples = base::subset(vp_out, n_samples == 2);

# Deviation in function of reference magnitude for different azimuth spreads
plot_labels_two_samples = list(xlabel = "Reference magnitude [m/s]", 
                               title = "Analysis of Velocity Profile solution accuracy for 2 samples",
                               legend = "Reference\nazimuth spread\n[deg]");

ggplot_rms_by_ref_and_group_4_plots(two_samples, "mag_ref", "az_spread_ref_label", plot_labels_two_samples)


# Deviation in function of reference heading for different magnitudes for 
# different levels of azimuth spread
plot_labels_two_samples_az = list(xlabel = "Reference Heading [deg]", 
                                    title = "Analysis of Velocity Profile solution accuracy for 2 samples and very low azimuth spread",
                                    legend = "Reference\nmagnitude\n[m/s]");
ggplot_rms_by_ref_and_group_4_plots(base::subset(two_samples, (az_spread_ref_label == "very low")),
                                    "heading_ref", "mag_ref_label", plot_labels_two_samples_az)

plot_labels_two_samples_az$title = "Analysis of Velocity Profile solution accuracy for 2 samples and low azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(two_samples, (az_spread_ref_label == "low")),
                                    "heading_ref", "mag_ref_label", plot_labels_two_samples_az)

plot_labels_two_samples_az$title = "Analysis of Velocity Profile solution accuracy for 2 samples and medium azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(two_samples, (az_spread_ref_label == "medium")),
                                    "heading_ref", "mag_ref_label", plot_labels_two_samples_az)

plot_labels_two_samples_az$title = "Analysis of Velocity Profile solution accuracy for 2 samples and high azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(two_samples, (az_spread_ref_label == "high")),
                                    "heading_ref", "mag_ref_label", plot_labels_two_samples_az)