Read UpgradeDB\Ver1070104\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070104, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;