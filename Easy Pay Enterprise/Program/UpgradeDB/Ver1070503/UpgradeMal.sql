Read UpgradeDB\Ver1070503\AllScript.sql;
Read UpgradeDB\Ver1070503\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070503, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;