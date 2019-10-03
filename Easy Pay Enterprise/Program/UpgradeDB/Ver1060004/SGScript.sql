READ UpgradeDB\Ver1060004\SG_CPF.sql;
READ UpgradeDB\Ver1060004\SG_Holidays.sql;

/*ModuleScreenGroup*/
IF NOT EXISTS (SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId = 'EC_PayCPFProg') THEN
   INSERT INTO ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   VALUES ('EC_PayCPFProg','EC_PayModules','CPF Progression','EPStandard',0,0,1,'')
END IF;

IF NOT EXISTS (SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId = 'PayCPFProg') THEN
   INSERT INTO ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   VALUES ('PayCPFProg','PayModules','CPF Progression','Pay',0,0,0,'EC_PayCPFProg')
ELSE
   UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_PayCPFProg' WHERE ModuleScreenId = 'PayCPFProg'
END IF;

Commit WORK;