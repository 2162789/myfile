if exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_122') then
   delete from RptCompItemConfig where RptCompSysId = 'Sys_122'
end if;

if exists(select * from RptCompConfig where RptCompSysId = 'Sys_122') then
   delete from RptCompConfig where RptCompSysId = 'Sys_122'
end if;


commit work;