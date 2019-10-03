READ UpgradeDB\Ver1070306\StoredProc.sql;
/*
	Insert new record for Privacy agreement in SubRegistry
*/

if not exists (Select * from subregistry where registryId = 'System' and subregistryid = 'ConsentToUseData')
    INSERT INTO SubRegistry (RegistryId, SubRegistryId, BooleanAttr, DateAttr, DateTimeAttr) VALUES ('System', 'ConsentToUseData', '1', getDate(), CURRENT_TIMESTAMP)

commit work;
	
