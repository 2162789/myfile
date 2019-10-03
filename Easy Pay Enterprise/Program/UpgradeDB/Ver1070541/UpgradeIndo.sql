Read UpgradeDB\Ver1070541\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070541, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;