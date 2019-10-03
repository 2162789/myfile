Read UpgradeDB\Ver1070401\AllScript.sql;
Read UpgradeDB\Ver1070401\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070401, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;