# Analysis of diffrence between accuray of olns and ols solutions
rm(list = ls())
base::source("utilities.R")
base::source("analysis_functions.R")
load('fit_accumulated.RData')

# Remove 2-samples data
vp_out = base::subset(vp_out, n_samples != 2);

# Prepare data sets
x = split.data.frame(vp_out, vp_out$label)
diff_f = function(x, data_name)
{
  y = base::abs(x[[2]][[data_name]]) - base::abs(x[[1]][[data_name]])
}

d_M = diff_f(x, "mag_dev")
d_Vx = diff_f(x, "Vx_dev")
d_Vy = diff_f(x, "Vy_dev")
d_h = diff_f(x, "heading_dev_deg")

diff_df = data.frame(d_M, d_Vx, d_Vy, d_h)

# Data sets seperation definition
separation_vy = c(-Inf, -5, -1, -0.01, 0.01, 1, 5, Inf)
separation_vx = c(-Inf, -1, -0.1, -0.005, 0.005, 0.1, 1, Inf)
labels = c("Very High minus", "High minus", "Low minus", "None", "Low plus", "High plus", "Very High plus")

diff_df$d_M_l = cut(diff_df$d_M, breaks = separation, labels = labels);
diff_df$d_Vx_l = cut(diff_df$d_Vx, breaks = separation_vx, labels = labels);
diff_df$d_Vy_l = cut(diff_df$d_Vy, breaks = separation_vy, labels = labels);
diff_df$d_h_l = cut(diff_df$d_h, breaks = separation, labels = labels);

diff_df_vxy = diff_df[c("d_Vx_l","d_Vy_l")]
diff_df_mh = diff_df[c("d_M_l","d_h_l")]

t_vxy = table(diff_df_vxy)
t_mh = table(diff_df_mh)