Read UpgradeDB\Ver1070601\AllScript.sql;
Read UpgradeDB\Ver1070601\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070601, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;