
if exists(select * from CPFTableComponent where CPFTableCodeId ='BPJS-Pensiun0317PR') then
  Update CPFTableComponent set MaxCPFAge=56 where CPFTableCodeId ='BPJS-Pensiun0317PR';
end if;

if exists(select * from CPFTableComponent where CPFTableCodeId ='BPJS-Pensiun0317FW') then
  Update CPFTableComponent set MaxCPFAge=56 where CPFTableCodeId ='BPJS-Pensiun0317FW';
end if;

if exists(select * from CPFTableComponent where CPFTableCodeId ='BPJS-Pensiun0317ST') then
  Update CPFTableComponent set MaxCPFAge=56 where CPFTableCodeId ='BPJS-Pensiun0317ST';
end if;


commit work;