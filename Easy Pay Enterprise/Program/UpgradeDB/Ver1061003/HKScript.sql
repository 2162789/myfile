/*SystemRptComp*/

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - CS 2' and SysRptCompName = 'DateOfContribution_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - CS 2','DateOfContribution_wwDBDateTimePicker','Date of Contribution','Date',0,NULL);
end if;

if not exists(select * from SystemRptComp where SysRptId = 'Payslip - Laser' and SysRptCompName = 'DateOfContribution_wwDBDateTimePicker') then
    insert into SystemRptComp(SysRptId,SysRptCompName,SysRptCompDesc,SysRptCompType,IsRptKey,RptKeyIndex)
	values('Payslip - Laser','DateOfContribution_wwDBDateTimePicker','Date of Contribution','Date',0,NULL);
end if;


/*RptCompConfig*/

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_76' and RptConfigId = '_Payslip - CS 2') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_76','_Payslip - CS 2','Payslip - CS 2','DateOfContribution_wwDBDateTimePicker');
end if;

if not exists(select * from RptCompConfig where RptCompSysId = 'Sys_77' and RptConfigId = '_Payslip - Laser') then
    insert into RptCompConfig(RptCompSysId,RptConfigId,SysRptId,SysRptCompName)
	values('Sys_77','_Payslip - Laser','Payslip - Laser','DateOfContribution_wwDBDateTimePicker');
end if;

/*RptCompItemConfig*/

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_76' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_76','1','1899-12-30');
end if;

if not exists(select * from RptCompItemConfig where RptCompSysId = 'Sys_77' and RptCompItemSysId = '1') then
    insert into RptCompItemConfig(RptCompSysId,RptCompItemSysId,ItemValue)
	values('Sys_77','1','1899-12-30');
end if;


commit work;