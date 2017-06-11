## Prepare data set for big data velocity profile estimation
rm(list = ls())
base::source("utilities.R")

RR_SIGMA = 0.03; # [m/s]
AZ_SIGMA = 0.5; # [deg]
N_SAMPLES_V = base::round(emdbook::lseq(2, 50, 10))
AZ_SPREAD_V = base::round(emdbook::lseq(2, 150, 10))
MAG_V_KPM = c(c(0), base::round(emdbook::lseq(2, 200, 9)))
MAG_V = kph2mps(MAG_V_KPM)
HEADING_V = base::seq(0, 90, length.out = 10)
N_REPETITION = 50;
i = 0;
NSAMPLES = length(N_SAMPLES_V) * length(AZ_SPREAD_V) * length(MAG_V_KPM) * length(HEADING_V);
## Data set 

for(n_sample in N_SAMPLES_V)
{
  for(az_spread in AZ_SPREAD_V)
  {
    for(mag in MAG_V)
    {
      for(heading in HEADING_V)
      {
        i = i+1;
        vp_single_list = replicate(N_REPETITION, 
                            VP_sample(mag, heading, az_spread, n_sample, RR_SIGMA, AZ_SIGMA), simplify = FALSE)
        if(i != 1)
        {
          vp_list = c(vp_list, vp_single_list)
        }
        else
        {
          vp_list = vp_single_list;
        }
      }
    }
    print(i / NSAMPLES * 100)
  }
}

# Save data
save(vp_list, file = 'vp_list.RData')

