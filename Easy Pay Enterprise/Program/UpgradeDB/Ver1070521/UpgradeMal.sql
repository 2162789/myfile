Read UpgradeDB\Ver1070521\AllScript.sql;
Read UpgradeDB\Ver1070521\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070521, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;