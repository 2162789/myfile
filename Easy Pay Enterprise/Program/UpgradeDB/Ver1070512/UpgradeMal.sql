Read UpgradeDB\Ver1070512\AllScript.sql;
Read UpgradeDB\Ver1070512\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070512, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;