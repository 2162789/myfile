if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'eIndRptEmail') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  Values('eIndRptEmail','CoreModules','e-Individual Report Email','Core',0,0,0,'EC_eIndRptEmail');
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'EC_eIndRptEmail') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  Values('EC_eIndRptEmail','EC_EmployeeReports','e-Individual Report Email','EPStandard',0,0,1,NULL);
end if;

Update UserModuleNoAccess set ModuleScreenId = 'eIndRptEmail' where ModuleScreenId = 'eIndividualReportEma';
Update UserModuleNoAccess set ModuleScreenId = 'EC_eIndRptEmail' where ModuleScreenId = 'EC_eIndividualReport';

if exists(select * from ModuleScreenGroup where ModuleScreenId = 'eIndividualReportEma') then
  delete from ModuleScreenGroup where ModuleScreenId = 'eIndividualReportEma';
end if;

if exists(select * from ModuleScreenGroup where ModuleScreenId = 'EC_eIndividualReport') then
  delete from ModuleScreenGroup where ModuleScreenId = 'EC_eIndividualReport';
end if;

commit work;