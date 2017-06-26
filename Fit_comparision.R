# Comparision of performance of ols and onls : RMSs
rm(list = ls())
base::source("utilities.R")
base::source("analysis_functions.R")
load('fit_accumulated.RData')

plot_labels = list(xlabel = "Reference Heading [deg]", 
                   title = "Analysis of Velocity Profile solution accuracy for more than 2 samples",
                   legend = "Reference\nnumber of\nsamples");

ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (n_samples_label != "two")), 
                                                 "mag_ref", "label", plot_labels);

plot_labels$title = "Velocity Profile accuracy for very low magnitude, azimuth spread and low number of samples"; 
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, 
                      (az_spread_ref_label == "very low") & (mag_ref_label == "zero") & (n_samples_label == "low")),
                                    "heading_ref", "label", plot_labels)

plot_labels$title = "Velocity Profile accuracy for NOT low magnitude, azimuth spread and number of samples";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, 
                                                 (az_spread_ref_label != "very low") & (mag_ref_label != "zero") & (n_samples_label != "two")),
                                    "heading_ref", "label", plot_labels)

plot_labels$title = "Velocity Profile accuracy for low magnitude, azimuth spread and low number of samples";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, 
                      (az_spread_ref_label == "low") & (mag_ref_label == "low") & (n_samples_label == "low")),
                                    "heading_ref", "label", plot_labels)

plot_labels$title = "Velocity Profile accuracy for medium magnitude, azimuth spread and number of samples";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, 
                      (az_spread_ref_label == "medium") & (mag_ref_label == "medium") & (n_samples_label == "medium")),
                                    "heading_ref", "label", plot_labels)

