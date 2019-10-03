IF NOT EXISTS (SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId = 'EC_PayFWLSDFRpt') THEN
  INSERT INTO ModuleScreenGroup 
    (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  VALUES 
    ('EC_PayFWLSDFRpt','EC_PayAnalysisRpts','FWL/SDF Report','EPStandard',0,1,1,'')
END IF;

IF NOT EXISTS (SELECT 1 FROM ModuleScreenGroup WHERE ModuleScreenId = 'PayFWLSDFRpt') THEN
  INSERT INTO ModuleScreenGroup 
    (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  VALUES 
    ('PayFWLSDFRpt','PayAnalysisRpts','FWL/SDF Report','Pay',0,1,0,'EC_PayFWLSDFRpt')
ELSE
  UPDATE ModuleScreenGroup SET
    EC_ModuleScreenId = 'EC_PayFWLSDFRpt'
  WHERE ModuleScreenId = 'PayFWLSDFRpt'
END IF;

Commit work;