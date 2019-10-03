Update ModuleScreenGroup set EC_ModuleScreenId = 'EC_PayCPFProgRpt' where ModuleScreenId = 'PayCPFProgRpt';
Update ModuleScreenGroup set EC_ModuleScreenId = 'EC_PayFWLProgRpt' where ModuleScreenId = 'PayFWLProgRpt';
Update ModuleScreenGroup set EC_ModuleScreenId = 'EC_PayEPProgRpt' where ModuleScreenId = 'PayEPProgRpt';

If not exists(select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_PayCPFProgRpt') then
   insert into ModuleScreenGroup
   Values('EC_PayCPFProgRpt','EC_EmployeeReports','CPF Progression Report','EPStandard',0,0,0,'');
end if;

If not exists(select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_PayFWLProgRpt') then
   insert into ModuleScreenGroup
   Values('EC_PayFWLProgRpt','EC_EmployeeReports','Foreign Worker Levy Report','EPStandard',0,0,0,'');
end if;

If not exists(select 1 from ModuleScreenGroup where ModuleScreenId = 'EC_PayEPProgRpt') then
   insert into ModuleScreenGroup
   Values('EC_PayEPProgRpt','EC_EmployeeReports','Employment Pass Report','EPStandard',0,0,0,'');
end if;

If not exists(select 1 from RemFunction where RemFunctionID = 'PayNSTrainingStart') then 
   Insert Into RemFunction(RemFunctionID,TaskCategoryID,IsCustomised,DllName,FuncMessage,SysDateTableID,SysDateAttributeID,SysDateSqlJoin,SysDateSqlCond,ParamNameU1,ParamNameU2,ParamNameU3,ParamNameU4,ParamNameU5,FuncKeyAttributeId1,FuncKeyAttributeId2,FuncKeyAttributeId3,FuncKeyAttributeId4,FuncKeyAttributeId5,FuncKeyword1,FuncKeyword2,FuncKeyword3,FuncKeyword4,FuncKeyword5) Values ('PayNSTrainingStart','Pay',0,'DReminderSysEng','Pay - NS Training - Start Date','NSPayCase', 'NSStartDate','NSPayCase N JOIN Employee E ON N.EmployeeSysID=E.EmployeeSysID', '','','','','','','E.EmployeeSysID','NSPaySysId','','','','EmployeeName','EmployeeID','NSStartDate','','');
end if;

If not exists(select 1 from RemDetailsTmpl where RemFunctionID = 'PayNSTrainingStart') then
  Insert Into RemDetailsTmpl(RemFunctionID,RemDetailsTmplOrder,Details) Values ('PayNSTrainingStart',1,'<K1> (<K2>), due on <K3>');
end if;

if not exists (select 1 from DBA.Registry where RegistryId = 'PayElementProperty') then
  insert into DBA.Registry Values('PayElementProperty','Pay Element Property Report');
end if;

if not exists (select 1 from DBA.SubRegistry where RegistryId = 'PayElementProperty') then
  insert into DBA.SubRegistry Values('PayElementProperty','GrossSalaryCode','Income a)','','','','','','','','','',0,10,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','NSCode','Income a)','','','','','','','','','',0,15,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','BonusCode','Income b)','','','','','','','','','',0,20,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','DirectorFeeCode','Income c)','','','','','','','','','',0,25,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','CommissionCode','Income d)1','','','','','','','','','',0,30,'',0,'','','1899-12-31','1899-12-30 00:00:01');
  insert into DBA.SubRegistry Values('PayElementProperty','PensionCode','Income d)2','','','','','','','','','',0,35,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','TransportCode','Income d)3','','','','','','','','','',0,40,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','EntertainmentCode','Income d)3','','','','','','','','','',0,45,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','GratuityCode','Income d)4','','','','','','','','','',0,50,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','CompensationCode','Income d)4','','','','','','','','','',0,55,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','NoticePayCode','Income d)4','','','','','','','','','',0,60,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','ExGratiaCode','Income d)4','','','','','','','','','',0,65,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','YMFCode','Deduction (Donations)','','','','','','','','','',0,70,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','MBMFCode','Deduction (Donations)','','','','','','','','','',0,75,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','COMCCode','Deduction (Donations)','','','','','','','','','',0,80,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','SINDACode','Deduction (Donations)','','','','','','','','','',0,85,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','CDACCode','Deduction (Donations)','','','','','','','','','',0,90,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','EUCFCode','Deduction (Donations)','','','','','','','','','',0,95,'',0,'','','1899-12-30','1899-12-30 00:00:00');
  insert into DBA.SubRegistry Values('PayElementProperty','InsuranceCode','Deduction (Life Insurance)','','','','','','','','','',0,100,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;

