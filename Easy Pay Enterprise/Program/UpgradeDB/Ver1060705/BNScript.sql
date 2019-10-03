READ UpgradeDB\Ver1060705\2014BN_PH.sql;

if EXISTS (select * from rptcompitemconfig where rptcompsysid='Sys_33' ) then
delete from rptcompitemconfig where rptcompsysid='Sys_33'
end if;

if EXISTS (select * from rptcompconfig where rptcompsysid='Sys_33') then
delete from rptcompconfig where rptcompsysid='Sys_33'
end if;

if EXISTS (select * from systemrptcomp where sysrptid='Payslip - CS 2' and sysrptcompname='IncludeZeroNetWage_CheckBox') then
delete from systemrptcomp where sysrptid='Payslip - CS 2' and sysrptcompname='IncludeZeroNetWage_CheckBox'
end if;

if NOT EXISTS (select * from systemrptcomp where sysrptid='Payslip - CS 2' and sysrptcompname='CheckBox_IncludeZeroNetWage') then
insert into systemrptcomp (sysrptid,sysrptcompname,sysrptcompdesc,sysrptcomptype,isrptkey,rptkeyindex)values('Payslip - CS 2','CheckBox_IncludeZeroNetWage','Include Zero Net Wage','int',0,NULL)
end if;

if NOT EXISTS (select * from rptcompconfig where rptcompsysid='Sys_33' ) then
insert into rptcompconfig (rptcompsysid,rptconfigid,sysrptid,sysrptcompname) values('Sys_33','_Payslip - CS 2','Payslip - CS 2','CheckBox_IncludeZeroNetWage')
end if;

if NOT EXISTS (select * from rptcompitemconfig where rptcompsysid='Sys_33' ) then
insert into rptcompitemconfig (rptcompsysid,rptcompitemsysid,itemvalue) values('Sys_33','1','0')
end if;

if  EXISTS (select * from rptcompitemconfig where rptcompsysid='Sys_76' ) then
update rptcompitemconfig set itemvalue=1 where rptcompsysid='Sys_76'
else 
insert into rptcompitemconfig (rptcompsysid,rptcompitemsysid,itemvalue) values('Sys_76','1','1')
end if;

commit work;