# Ordinary Least Squeared Regresion of Velocity Profile - Analysis 
rm(list = ls())
base::source("utilities.R")
base::source("analysis_functions.R")
load('orth_nonlin_ls_fit.RData')

# First analysis: accuracy for very low magnitude and very low azimuth spread in
# reference of heading for different number of samples

plot_labels = list(xlabel = "Reference Heading [deg]", 
                   title = "Analysis of Velocity Profile solution accuracy for very low magnitude and azimuth spread",
                   legend = "Reference\nnumber of\nsamples");
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (az_spread_ref_label == "very low") & mag_ref_label == "zero"),
                                    "heading_ref", "n_samples_label", plot_labels)

# Second analysis: accuracy for low magnitude and low azimuth spread in
# reference of heading for different number of samples
plot_labels$title = "Analysis of Velocity Profile solution accuracy for low magnitude and azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (az_spread_ref_label == "low") & mag_ref_label == "low"),
                                    "heading_ref", "n_samples_label", plot_labels)

# Third analysis: accuracy for medium magnitude and medium azimuth spread in
# reference of heading for different number of samples
plot_labels$title = "Analysis of Velocity Profile solution accuracy for medium magnitude and azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (az_spread_ref_label == "medium") & mag_ref_label == "medium"),
                                    "heading_ref", "n_samples_label", plot_labels)

# Fourth analysis: accuracy for medium magnitude and very low azimuth spread in
# reference of heading for different number of samples
plot_labels$title = "Analysis of Velocity Profile solution accuracy for medium magnitude and very low azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (az_spread_ref_label == "very low") & mag_ref_label == "medium"),
                                    "heading_ref", "n_samples_label", plot_labels)

# Fifth analysis: accuracy for medium magnitude and very low azimuth spread in
# reference of heading for different number of samples
plot_labels$title = "Analysis of Velocity Profile solution accuracy for medium magnitude and low azimuth spread";
ggplot_rms_by_ref_and_group_4_plots(base::subset(vp_out, (az_spread_ref_label == "low") & mag_ref_label == "medium"),
                                    "heading_ref", "n_samples_label", plot_labels)