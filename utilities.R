# Radian to degree
rad2deg = function(rad)
{
  deg = rad*180/base::pi;
  deg
} 

# Degree to radian
deg2rad = function(deg)
{
  rad = deg*base::pi/180;
  rad
}
kph2mps = function(kph)
{
  mps = kph/3.6;
  mps
}


# Velocity Profile to range rates (azimuth in radians)
vp2rr = function(Vx, Vy, azimuth)
{
  rr = base::cos(azimuth)*Vx +  base::sin(azimuth)*Vy;
  rr
}

# Single Velocity profile samples
VP_sample = function(mag, heading, az_spread, n_samples = 10, sigma_rr = 0.03, sigma_az = 0.5)
{
  Vx = mag * cos(deg2rad(heading));
  Vy = mag * sin(deg2rad(heading));
  # truth data
  az_truth_deg = base::seq(-az_spread/2, az_spread/2, length.out = n_samples);
  az_truth = deg2rad(az_truth_deg);
  rr_truth = vp2rr(Vx, Vy, az_truth)
  
  # sample data
  az_sample_deg = az_truth_deg + stats::rnorm(length(az_truth_deg), 0, sigma_az);
  az_sample = deg2rad(az_sample_deg);
  rr_sample = rr_truth + stats::rnorm(length(rr_truth), 0, sigma_rr);
  
  az_spread_sample = spread(az_sample_deg);

  VP = list(az_sample = az_sample, rr_sample = rr_sample,
            mag_ref = mag, heading_ref = heading, Vx_ref = Vx, Vy_ref = Vy, 
            n_samples = n_samples, az_spread_ref = az_spread, az_spread_sample = az_spread_sample,
            sigma_rr = sigma_rr, sigma_az = sigma_az);
  VP
}

hypot = function(x, y)
{
  d = base::sqrt(x^2 + y^2);
  d
}
angle_diff = function(ref_angle, meas_angle)
{
  a = ((ref_angle - meas_angle) + pi/2) %% pi - pi/2;
  a
}
VP_ref = function(vp_sample)
{
  vp_sample$az_sample = NULL;
  vp_sample$rr_sample = NULL;
  vp_sample$sigma_rr = NULL;
  vp_sample$sigma_az = NULL;
  vp_sample
}

list2df = function(list_in)
{
  df = base::data.frame(base::t(base::sapply(list_in, `[`)));
  df = base::data.frame(base::sapply(df, as.numeric));
  df
}

spread = function(x)
{
  s = base::max(x) - base::min(x);
  s
}
rms = function(x)
{
  x = as.numeric(x);
  y = sqrt(sum(x^2)/length(x));
  y
}

list2factor = function(x)
{
  y = as.factor(x);
  y
}

