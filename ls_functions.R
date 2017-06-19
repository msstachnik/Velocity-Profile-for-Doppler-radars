ols = function(vp_sample)
{
  # Ordinary Least Squares Regression implementation for Velocity Profile problem
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

orth_nonlin_ls = function(vp_sample)
{
  # Orthogonal Nonlinear Least Squares Regression implementation for Velocity Profile problem
  
  # Initial solution from OLS
  model_ols = ols(vp_sample)
  init_coefs = list(Vx = model_ols$Vx, Vy = model_ols$Vy)
  
  # Formula definition
  formula_onls = rr_sample ~ Vx * cos(az_sample) + Vy * sin(az_sample) + 0;
  
  # Fit data
  model_onls = onls::onls(formula_onls, vp_sample, start = init_coefs, verbose = FALSE);

  # Populate only relevant outputs
  out = list(Vx = model_onls$parONLS$Vx, Vy = model_onls$parONLS$Vy)
}