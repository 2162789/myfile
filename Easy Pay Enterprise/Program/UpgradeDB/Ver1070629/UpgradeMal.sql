Read UpgradeDB\Ver1070629\AllScript.sql;
Read UpgradeDB\Ver1070629\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070629, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;