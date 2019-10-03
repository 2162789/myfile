Read UpgradeDB\Ver1070311\AllScript.sql;
Read UpgradeDB\Ver1070311\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070311, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;