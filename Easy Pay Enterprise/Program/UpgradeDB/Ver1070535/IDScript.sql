/*-------------------------------------------------
BPJS Pensiun Max Age from 56 to 57 wef 1st Jan 2019
-------------------------------------------------*/
Update CPFTableComponent Set MaxCPFAge = 57 where CPFTableCodeId in ('BPJS-Pensiun0319ST', 'BPJS-Pensiun0319PR','BPJS-Pensiun0319FW');

commit work;