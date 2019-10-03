UPDATE ModuleScreenGroup SET MainModuleName = 'EPStandard' 
WHERE IsEPClassic = 1 AND MainModuleName = 'EPClassic';

UPDATE ModuleScreenGroup SET MainModuleName = 'EPStandard'
WHERE ModuleScreenId = 'EC_eIndividualReport';

COMMIT WORK;
