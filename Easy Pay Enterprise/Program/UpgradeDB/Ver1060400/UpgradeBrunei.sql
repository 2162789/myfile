READ UpgradeDB\Ver1060400\SageIntelligenceSecurity.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060400, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;