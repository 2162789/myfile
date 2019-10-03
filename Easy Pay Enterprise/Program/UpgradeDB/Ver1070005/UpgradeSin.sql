Read UpgradeDB\Ver1070005\AllScript.sql;
Read UpgradeDB\Ver1070005\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070005, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;