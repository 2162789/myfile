Read UpgradeDB\Ver1070608\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070608, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;