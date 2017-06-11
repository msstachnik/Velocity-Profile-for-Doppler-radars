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
  Vx = mag * cos(heading);
  Vy = mag * sin(heading);
  # truth data
  az_truth_deg = base::seq(-az_spread/2, az_spread/2, length.out = n_samples);
  az_truth = deg2rad(az_truth_deg);
  rr_truth = vp2rr(Vx, Vy, az_truth)
  
  # sample data
  az_sample_deg = az_truth_deg + stats::rnorm(length(az_truth_deg), 0, sigma_az);
  az_sample = deg2rad(az_sample_deg);
  rr_sample = rr_truth + stats::rnorm(length(rr_truth), 0, sigma_rr);

  VP = list(az_sample = az_sample, rr_sample = rr_sample,
            mag = mag, heading = heading,Vx = Vx, Vy = Vy, 
            n_samples = n_samples, sigma_rr = sigma_rr, sigma_az = sigma_az)
  VP
 }