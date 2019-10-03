Read UpgradeDB\Ver1070509\AllScript.sql;
Read UpgradeDB\Ver1070509\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070509, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;