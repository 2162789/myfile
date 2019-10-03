Read UpgradeDB\Ver1070000\AllScript.sql;
Read UpgradeDB\Ver1070000\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070000, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;