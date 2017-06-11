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

# Velocity Profile to range rates (azimuth in radians)
vp2rr = function(Vx, Vy, azimuth)
{
  rr = base::cos(azimuth)*Vx +  base::sin(azimuth)*Vy;
  rr
}

# Single Velocity profile samples
VP_sample = function(Vx, Vy, min_az, max_ax, n_samples = 10, sigma_rr = 0.03, sigma_az = 0.5)
{
  # truth data
  az_truth_deg = stats::runif(n_samples, min_az, max_ax);
  az_truth = deg2rad(az_truth_deg);
  rr_truth = vp2rr(Vx, Vy, az_truth)
  
  # sample data
  az_sample_deg = az_truth_deg + stats::rnorm(length(az_truth_deg), 0, sigma_az);
  az_sample = deg2rad(az_sample_deg);
  rr_sample = rr_truth + stats::rnorm(length(rr_truth), 0, sigma_rr);
  
  vp_truth = base::data.frame(az_truth, rr_truth, az_truth_deg);
  vp_sample = base::data.frame(az_sample, rr_sample, az_sample_deg);
  
  VP = list(vp_sample = vp_sample, vp_truth = vp_truth,
            Vx = Vx, Vy = Vy, n_samples = n_samples, sigma_rr = sigma_rr, sigma_az = sigma_az)
  VP
 }