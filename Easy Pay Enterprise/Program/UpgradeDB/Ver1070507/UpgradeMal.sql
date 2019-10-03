Read UpgradeDB\Ver1070507\AllScript.sql;
Read UpgradeDB\Ver1070507\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070507, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;