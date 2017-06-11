ols = function(vp_sample)
{
  Sx = sum(vp_sample$rr_sample * base::cos(vp_sample$az_sample));
  Sy = sum(vp_sample$rr_sample * base::sin(vp_sample$az_sample));
  Sxx = sum((base::cos(vp_sample$az_sample))^2);
  Syy = sum((base::sin(vp_sample$az_sample))^2);
  Sxy = sum(base::sin(vp_sample$az_sample) * base::cos(vp_sample$az_sample));
  
  W = Sxx * Syy - Sxy * Sxy;
  Wx = Sx * Syy - Sy * Sxy;
  Wy = Sxx * Sy - Sxy * Sx;
  
  Vx = Wx/W;
  Vy = Wy/W;
  
  out = list(Vx = Vx, Vy = Vy)
}