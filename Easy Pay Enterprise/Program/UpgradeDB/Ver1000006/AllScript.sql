UPDATE ModuleScreenGroup SET ModuleScreenName = 'Modules' WHERE ModuleScreenId = 'EC_EmployeeModules';
UPDATE ModuleScreenGroup SET ModuleScreenName = 'Register License' WHERE ModuleScreenId = 'EC_RegisterModule';
UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_InterfaceSetup' WHERE ModuleScreenId = 'InterfaceSetup';
UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_ProcessInterface' WHERE ModuleScreenId = 'CoreInterfaceUpdate';
UPDATE ModuleScreenGroup SET Mod_ModuleScreenId = 'EC_EmployeeReports' WHERE ModuleScreenId = 'EC_PersonnelDataRpt';

if exists(select * from modulescreengroup where modulescreenid = 'EC_Personnel') then 
	delete from modulescreengroup where modulescreenid = 'EC_Personnel';
end if;