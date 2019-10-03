Read UpgradeDB\Ver1070611\AllScript.sql;
Read UpgradeDB\Ver1070611\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070611, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;