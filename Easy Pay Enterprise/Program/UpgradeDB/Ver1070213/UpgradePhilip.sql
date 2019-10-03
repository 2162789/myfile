Read UpgradeDB\Ver1070213\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070213, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;