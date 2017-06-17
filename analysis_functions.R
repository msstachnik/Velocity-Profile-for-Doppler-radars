ggplot_rms_by_ref_and_group = function (df, deviation_n, reference_n, group_by, plot_labels, ylabel)
{
  # Generic function for analysis of data set with couple references (at lest 2)
  # The RMS is calculated for defined variable with reference of defined reference 
  # and for couple signals levels defined by group
  
  # Double nested by to have rms with 2 references
  by_list_rms = by(df, list2factor(df[[group_by]]), function(df){
    x_rms = by(df, list2factor(df[[reference_n]]), function(df){
      {x = rms(df[[deviation_n]]); x}
    })
    x_rms
  })
  
  # Create list of data frames
  list_df_rms = lapply(by_list_rms, function(by_list_rms){
    df = data.frame(reference = as.numeric(names(by_list_rms)), deviation = as.numeric(by_list_rms));
    df
  })
  
  # Cummulate data
  rms_df = plyr::ldply(list_df_rms, .id = "group_by")

  # Plot
  library(ggplot2)
  p = ggplot(rms_df, aes(x = reference, y = deviation, group = group_by, 
                       colour = group_by)) +  
    geom_line() + 
    scale_x_continuous(breaks = base::round(base::unique(rms_df$reference), 1)) +
    scale_y_log10(breaks = base::round(emdbook::lseq(1e-2, 1e2, 13), 2)) + 
    labs(x = plot_labels$xlabel, y = ylabel, title = plot_labels$title, 
         color = plot_labels$legend)
  
  print(p)
}

ggplot_rms_by_ref_and_group_4_plots = function(df, reference_n, group_by, plot_labels)
{
  # Reduced version of function to plot all 4 deviations types
  ggplot_rms_by_ref_and_group(df, "mag_dev", reference_n, group_by,
                              plot_labels, "Magnitude RMSE [m/s]")
  
  ggplot_rms_by_ref_and_group(df, "Vx_dev", reference_n, group_by,
                              plot_labels, "Vx RMSE [m/s]")
  
  ggplot_rms_by_ref_and_group(df, "Vy_dev", reference_n, group_by,
                              plot_labels, "Vy RMSE [m/s]")
  
  ggplot_rms_by_ref_and_group(df, "heading_dev_deg", reference_n, group_by,
                              plot_labels, "Heading RMSE [deg]")
}