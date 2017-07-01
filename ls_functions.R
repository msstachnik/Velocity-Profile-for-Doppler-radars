ols = function(vp_sample)
{
  start_time <- Sys.time();
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
  
  end_time <- Sys.time();
  out = list(Vx = Vx, Vy = Vy, time = end_time - start_time)
}

orth_nonlin_ls = function(vp_sample)
{
  start_time <- Sys.time()
  # Orthogonal Nonlinear Least Squares Regression implementation for Velocity Profile problem
  
  # Initial solution from OLS
  model_ols = ols(vp_sample)
  init_coefs = list(Vx = model_ols$Vx, Vy = model_ols$Vy)
  
  # Formula definition
  formula_onls = rr_sample ~ Vx * cos(az_sample) + Vy * sin(az_sample) + 0;
  
  # Fit data
  model_onls = onls::onls(formula_onls, vp_sample, start = init_coefs, verbose = FALSE);

  # Populate only relevant outputs
  end_time <- Sys.time();
  out = list(Vx = model_onls$parONLS$Vx, Vy = model_onls$parONLS$Vy, time = end_time - start_time)
}

odr = function(vp_sample, rr_sigma = 0.03, az_sigma = deg2rad(0.5), sigma_level = 2, cnv_thr = 1e-3, max_iter = 10, use_jac = TRUE)
{
  start_time <- Sys.time();
  NI = az_sigma / rr_sigma;
  max_az_deviation = sigma_level * az_sigma;
  
  ITERS = 1:max_iter;
  POINTS = 1:length(vp_sample$az_sample);
  
  # Initial solution from OLS
  model_ols = ols(vp_sample)
  init_coefs = list(Vx = model_ols$Vx, Vy = model_ols$Vy)
  
  limits = lapply(as.list(vp_sample$az_sample), function(az_sample){
    limit = c(az_sample - max_az_deviation, az_sample + max_az_deviation)
  })
  
  point_res = function(az_sample, vx, vy, ref_az, ref_rr, ni)
  {
    res = (ref_rr - vx*cos(az_sample) - vx*sin(az_sample))^2 + ni*(ref_az - az_sample)^2
  }
  jacobian = function(az_sample, vx, vy, ref_az, ref_rr, ni)
  {
    J = 2 * ((ref_rr - vx*cos(az_sample) - vy*sin(az_sample)) * (vx*sin(az_sample) - vy*cos(az_sample)) - 
               ni * (ref_az - az_sample))
  }
  
  # Initialization
  actual_coefs = init_coefs;
  actual_sample = vp_sample;
  for (i in ITERS)
  {
    prev_coefs = actual_coefs;
    # Step 1 for each angle
    for (j in POINTS)
    {
      # cost function in this iteration
      res_func = function(az_sample, vx = actual_coefs$Vx, vy = actual_coefs$Vy, ref_az = vp_sample$az_sample[j], 
                        ref_rr = vp_sample$rr_sample[j], ni = NI)
      {
        res = point_res(az_sample, vx, vy, ref_az, ref_rr, ni)
      }
      # jacobian function in this iteration
      if (use_jac)
      {
        jac_fun = function(az_sample, vx = actual_coefs$Vx, vy = actual_coefs$Vy, ref_az = vp_sample$az_sample[j], 
                           ref_rr = vp_sample$rr_sample[j], ni = NI)
        {
          J = jacobian(az_sample, vx, vy, ref_az, ref_rr, ni)
        }       
      }
      else
      {
        jac_fun = NULL;
      }

      lm_sol = minpack.lm::nls.lm(par = actual_sample$az_sample[j], lower = limits[[j]][1], upper = limits[[j]][2],
                                  fn = res_func, jac = jac_fun);
      
      actual_sample$az_sample[j] = lm_sol$par;
    }
    
    # Step 2 OLS fit
    actual_coefs = ols(actual_sample);
    
    # Check convergence
    if ((abs(actual_coefs$Vx - prev_coefs$Vx)) + (abs(actual_coefs$Vy - prev_coefs$Vy)) < cnv_thr)
    {
      break
    }
    else
    {
      # Do nothing
    }
  }
  end_time <- Sys.time()
  out = list(Vx = actual_coefs$Vx, Vy = actual_coefs$Vy, n_iters = i, time = end_time - start_time)
}

