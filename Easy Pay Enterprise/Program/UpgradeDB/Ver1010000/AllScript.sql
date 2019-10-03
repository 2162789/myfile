UPDATE SubRegistry 
SET SubRegistryId = 'EPStandard', RegProperty1 = 'EP Standard' 
WHERE RegistryId = 'Application' AND SubRegistryId = 'EPClassic';

COMMIT WORK;
