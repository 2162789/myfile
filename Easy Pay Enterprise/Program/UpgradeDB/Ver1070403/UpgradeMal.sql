Read UpgradeDB\Ver1070403\AllScript.sql;
Read UpgradeDB\Ver1070403\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070403, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;