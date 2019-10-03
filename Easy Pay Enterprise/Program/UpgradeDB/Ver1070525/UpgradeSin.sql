Read UpgradeDB\Ver1070525\AllScript.sql;
Read UpgradeDB\Ver1070525\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070525, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;