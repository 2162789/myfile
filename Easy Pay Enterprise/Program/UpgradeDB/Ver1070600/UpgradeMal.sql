Read UpgradeDB\Ver1070600\AllScript.sql;
Read UpgradeDB\Ver1070600\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070600, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;