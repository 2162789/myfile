/* Change KeyWordDesc from 'OverseasEECPF' to 'SDFWage' for EX_HRD_Levy_W and EX_HRD_Levy_W */
UPDATE Keyword SET KeyWordDesc = 'SDFWage' where KeyWordId = 'EX_HRD Levy_W' or KeyWordId = 'EX_HRD Levy_W_Prev'
commit work;