ggplot_by_mag_ref_az_spread = function (df, col_name, plot_labels, ylabel)
{
  x_rms = by(df, list2factor(df$az_spread_ref), function(df){
    x_rms = by(df, list2factor(df$mag_ref), function(df){
      {x = rms(df[[col_name]]); x}
    })
    x_rms
  })
  
  # Create list of data frames
  x_rms_df = lapply(x_rms, function(x_rms){
    df = data.frame(mag_ref = as.numeric(names(x_rms)), y = as.numeric(x_rms));
    df
  })
  
  # cummulate data
  x_rms_df = plyr::ldply(x_rms_df, .id = "az_spread_ref")

  library(ggplot2)
  p = ggplot(x_rms_df, aes(x = mag_ref, y = y, group = az_spread_ref, 
                       colour = az_spread_ref));
  
  p +  geom_line() + 
    scale_x_continuous(breaks = base::round(base::unique(x_rms_df$mag_ref), 1)) +
    scale_y_log10(breaks = base::round(emdbook::lseq(1e-2, 1e2, 13), 2)) + 
    labs(x = plot_labels$xlabel, y = ylabel, title = plot_labels$title, 
         color ="Reference\nazimuth spread\n[deg]")
}
