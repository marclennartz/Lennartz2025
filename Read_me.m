% Exploring Hourly Rainfall Extremes in a Changing Climate: A Comparative Analysis of sMEV and GEV Distributions Using COSMO-CLM Simulations over Germany. 
% Marc Lennartz, 2025
% All inquieries please direct at marc.lennartz1@gmail.com
%
% Data preperation is based on Francesco Marra (2023) which uses several other
% papers in turn.
%
% Francesco Marra (2023). The TEmperature-dependent Non-Asymptotic statistical model for eXtreme return levels (TENAX). (https://zenodo.org/records/8345905)
% John Bockstege (2023). Shade area between two curves (https://www.mathworks.com/matlabcentral/fileexchange/13188-shade-area-between-two-curves), MATLAB Central File Exchange. 
% Ebo Ewusi-Annan (2023). Weighted and unweighted linear fit (https://www.mathworks.com/matlabcentral/fileexchange/34352-weighted-and-unweighted-linear-fit), MATLAB Central File Exchange. 
% Aslak Grinsted (2023). quantreg(x,y,tau,order,Nboot) (https://www.mathworks.com/matlabcentral/fileexchange/32115-quantreg-x-y-tau-order-nboot), MATLAB Central File Exchange. 
% halleyhit (2023). generate random numbers according to pdf or cdf (https://www.mathworks.com/matlabcentral/fileexchange/68492-generate-random-numbers-according-to-pdf-or-cdf), MATLAB Central File Exchange. 
% Francesco Marra (2020). A Unified Framework for Extreme Sub-daily Precipitation Frequency Analyses based on Ordinary Events - data & codes (Version v1). Zenodo. https://doi.org/10.5281/zenodo.3971558
% Edward Zechmann (2023). Continuous Sound and Vibration Analysis (https://www.mathworks.com/matlabcentral/fileexchange/21384-continuous-sound-and-vibration-analysis), MATLAB Central File Exchange. 
% 
% The calculation to generate the starting data was done on the DKRZ
% supercomputer. Any script used to calculate the starting data is heavily
% based on Francesco Marra (2023) and can be provided upon request.
%
% Description of the starting data:
% 1. "fit_smev"
%   dim: 42x42
%   description: the result of the sMEV test introduced by Marra et al. 
%   (2020) - for all 10x10 grid squares on sample was used
% 2. "T_all"
%   dim: 90x1
%   description: spatial average annual temperature in K
% 3. "AMS"
%   dim: 423x415x90
%   description: the RX1h values for each grid point for 90 years
% 4. "GEV_prm"
%   dim: 423x415x4x3
%   description: for 4 time periods (past, near future, distant future, 
%   combined) the GEV parameter (shape, scale, location)
% 5. "GEV_RL"
%   dim: 423x415x4x40
%   description: for 4 time periods the GEV return levels for 40 return
%   periods (5, 10, ..., 200)
% 6. "SMEV_prm"
%   dim: 423x415x4x2
%   description: for 4 time periods (past, near future, distant future, 
%   combined) the SMEV parameter (shape, scale)
% 7. "SMEV_RL"
%   dim: 423x415x4x40
%   description: for 4 time periods the SMEV return levels for 40 return
%   periods 
% 8. "n0_per"
%   dim: 423x415x4
%   description: the intercept for the regression of number of ordinary
%   events for 4 time periods
% 9. "n1_per"
%   dim: 423x415x4
%   description: the slope for the regression of number of ordinary
%   events per year for 4 time periods
% 10. "nsGEV_prm"
%   dim: 423x415x4x4
%   description: for 4 time periods the nsGEV parameter (shape, scale, 
%   location intercept, location slope)
% 11. "nsSMEV_prm"
%   dim: 423x415x4x3
%   description: for 4 time periods the nsSMEV parameter (shape, scale 
%   factor, scale exponent) 
% 12. "GEV_prm_unc_[1,2,3]"
%   dim: 423x415x5x3x5
%   description: the GEV parameter quantile of the 1,2,3 time period for 5
%   different observation length (10, 15, 20, 25, 30) years for 3 
%   parameters (shape, scale, location) for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 13. "GEV_prm_unc_4"
%   dim: 423x415x17x3x5
%   description: the GEV parameter quantile of the combined time period for 
%   17 different observation length (10, 15, ..., 90) years for 3 
%   parameters (shape, scale, location) for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 14. "SMEV_prm_unc_[1,2,3]"
%   dim: 423x415x5x2x5
%   description: the SMEV parameter quantile of the 1,2,3 time period for 5
%   different observation length (10, 15, 20, 25, 30) years for 2 
%   parameters (shape, scale) for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 15. "SMEV_prm_unc_4"
%   dim: 423x415x17x2x5
%   description: the SMEV parameter quantile of the combined time period for 
%   17 different observation length (10, 15, ..., 90) years for 2 
%   parameters (shape, scale) for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 16. "GEV_rmse_[1,2,3]"
%   dim: 423x415x5x40
%   description: the relative root mean square error of the GEV from the
%   1,2,3 time period for 5 different observation length for 40 different
%   return periods
% 17. "GEV_rmse_4"
%   dim: 423x415x17x40
%   description:the relative root mean square error of the GEV from the
%   combined time period for 17 different observation length for 40 
%   different return periods
% 18. "SMEV_rmse_[1,2,3]"
%   dim: 423x415x5x40
%   description: the relative root mean square error of the SMEV from the
%   1,2,3 time period for 5 different observation length for 40 different
%   return periods
% 19. "SMEV_rmse_4"
%   dim: 423x415x17x40
%   description:the relative root mean square error of the SMEV from the
%   combined time period for 17 different observation length for 40 
%   different return periods
% 20. "GEV_RL_unc_[1,2,3]"
%   dim: 423x415x5x40x5
%   description: the GEV return level quantile of the 1,2,3 time period for 
%   5 different observation length (10, 15, 20, 25, 30) years for 40 
%   different return periods for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 21. "GEV_RL_unc_4"
%   dim: 423x415x17x40x5
%   description: the GEV return level quantile of the 4 time period for 
%   17 different observation length (10, 15, 20, 25, 30) years for 40 
%   different return periods for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 22. "SMEV_RL_unc_[1,2,3]"
%   dim: 423x415x5x40x5
%   description: the SMEV return level quantile of the 1,2,3 time period for 
%   5 different observation length (10, 15, 20, 25, 30) years for 40 
%   different return periods for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 23. "SMEV_RL_unc_4"
%   dim: 423x415x17x40x5
%   description: the SMEV return level quantile of the 4 time period for 
%   17 different observation length (10, 15, 20, 25, 30) years for 40 
%   different return periods for the quantiles (0.05
%   0.15 0.5 0.85 0.95).
% 24. "nsGEV_RL"
%   dim: 423x415x4x40
%   description: the return levels of the nsGEV for 4 time periods and 40
%   return periods with average temperatures for eachtime period
% 25. "nsSMEV_RL"
%   dim: 423x415x4x40
%   description: the return levels of the nsGEV for 4 time periods and 40
%   return periods with average temperatures for eachtime period
% 26. "N"
%   dim: 423x415x4x40
%   description: the number of events per year for 4 time periods 